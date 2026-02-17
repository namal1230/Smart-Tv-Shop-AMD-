import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  CollectionReference productRequests = FirebaseFirestore.instance.collection(
    'productRequests',
  );
  static CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );

  Future<String> addProductRequest(Map<String, dynamic> requestData) async {
    try {
      final docRef = productRequests.doc();
      await docRef.set({'id': docRef.id, ...requestData});
      print("Product request added with ID: ${docRef.id}");
      return "success";
    } catch (e) {
      print("Error adding product request: $e");
      return "error $e";
    }
  }

  Future<List<Map<String, dynamic>>> getProducts({String? id}) async {
    List<Map<String, dynamic>> products = [];

    QuerySnapshot productSnapshot;
    if (id != null) {
      productSnapshot = await productRequests
          .where('userId', isEqualTo: id)
          .get();
    } else {
      productSnapshot = await productRequests.get();
    }

    QuerySnapshot shopSnapshot = await FirebaseFirestore.instance
        .collection("shopDetails")
        .get();

    List<Map<String, dynamic>> shopDetails = shopSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    for (var doc in productSnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String type = data["type"];

      var matchingShop = shopDetails.firstWhere(
        (shop) =>
            (shop["prices"] as List<dynamic>).any((p) => p["item"] == type),
        orElse: () => {},
      );

      if (matchingShop.isNotEmpty) {
        List<dynamic> prices = matchingShop["prices"];

        var priceMap = prices.firstWhere(
          (p) => p["item"] == type,
          orElse: () => null,
        );

        data["price"] = priceMap != null ? priceMap["amount"] : 0;
        data["timings"] = matchingShop["timings"];
      } else {
        data["price"] = 0;
        data["timings"] = {};
      }

      data.remove("prices");

      products.add(data);
    }

    return products;
  }

  Future<List<Map<String, dynamic>>> getPendingProducts() async {
    List<Map<String, dynamic>> products = [];

    print("Fetching pending products");

    try {
      QuerySnapshot productsSnapshot = await productRequests
          .where('status', isEqualTo: 'Pending')
          .get();

      if (productsSnapshot.docs.isEmpty) return products;

      Set<String> userIds = productsSnapshot.docs
          .map(
            (doc) => (doc.data() as Map<String, dynamic>)['userId'] as String,
          )
          .toSet();

      print("User IDs for pending products: $userIds");

      QuerySnapshot usersSnapshot = await users
          .where('uid', whereIn: userIds.toList())
          .get();

      print("Users snapshot: ${usersSnapshot.docs.length} documents");

      Map<String, Map<String, dynamic>> userMap = {
        for (var doc in usersSnapshot.docs)
          (doc.data() as Map<String, dynamic>)['uid']:
              doc.data() as Map<String, dynamic>,
      };

      print("User map constructed with ${userMap.length} entries");

      for (var doc in productsSnapshot.docs) {
        final productData = doc.data() as Map<String, dynamic>;
        final uid = productData['userId'];

        products.add({
          'productId': doc.id,
          ...productData,
          'user': userMap[uid],
        });
      }
      print("Fetched pending products: $products");
    } catch (e) {
      print("Error fetching pending products: $e");
    }
    return products;
  }

  Future<List<Map<String, dynamic>>> getAcceptedProducts() async {
    List<Map<String, dynamic>> products = [];

    print("Fetching accepted products");

    try {
      QuerySnapshot productsSnapshot = await productRequests
          .where('status', isEqualTo: 'Accepted')
          .get();

      if (productsSnapshot.docs.isEmpty) return products;

      Set<String> userIds = productsSnapshot.docs
          .map(
            (doc) => (doc.data() as Map<String, dynamic>)['userId'] as String,
          )
          .toSet();

      print("User IDs for accepted products: $userIds");
      QuerySnapshot usersSnapshot = await users
          .where('uid', whereIn: userIds.toList())
          .get();

      print("Users snapshot: ${usersSnapshot.docs.length} documents");

      Map<String, Map<String, dynamic>> userMap = {
        for (var doc in usersSnapshot.docs)
          (doc.data() as Map<String, dynamic>)['uid']:
              doc.data() as Map<String, dynamic>,
      };

      print("User map constructed with ${userMap.length} entries");

      for (var doc in productsSnapshot.docs) {
        final productData = doc.data() as Map<String, dynamic>;
        final uid = productData['userId'];

        products.add({
          'productId': doc.id,
          ...productData,
          'user': userMap[uid],
        });
      }
      print("Fetched accepted products: $products");
    } catch (e) {
      print("Error fetching accepted products: $e");
    }
    return products;
  }

  Future<int?> getCompletedCount() async {
    final query = productRequests.where('status', isEqualTo: 'Completed');

    final snapshot = await query.count().get();
    return snapshot.count;
  }

  Future<int?> getPendingCount() async {
    final query = productRequests.where('status', isEqualTo: 'Pending');

    final snapshot = await query.count().get();
    return snapshot.count;
  }

  Future<int?> getProgressCount() async {
    final query = productRequests.where('status', isEqualTo: 'Accepted');

    final snapshot = await query.count().get();
    return snapshot.count;
  }

  Future<Map<String, int>> getPriceMap() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('shopDetails')
        .limit(1)
        .get();

    final data = snapshot.docs.first.data();
    List prices = data['prices'];

    Map<String, int> priceMap = {};
    for (var p in prices) {
      priceMap[p['item']] = p['amount'];
    }

    return priceMap;
  }

  Future<Map<String, int>> getCompletedTotals() async {
    final priceMap = await getPriceMap();

    final snapshot = await FirebaseFirestore.instance
        .collection('productRequests')
        .where('status', isEqualTo: 'Completed')
        .get();

    Map<String, int> totals = {};

    for (var doc in snapshot.docs) {
      String type = doc['type'];

      if (priceMap.containsKey(type)) {
        totals[type] = (totals[type] ?? 0) + priceMap[type]!;
      }
    }

    return totals;
  }

  Future<List<Map<String, dynamic>>> getRepairHistory() async {
  List<Map<String, dynamic>> finalData = [];

  final shopSnapshot = await FirebaseFirestore.instance
      .collection('shopDetails')
      .doc('KDc0ZUNjELfwwgt5h9QP')
      .get();

  final List prices = shopSnapshot.data()?['prices'] ?? [];

  final productRequestsSnapshot = await FirebaseFirestore.instance
      .collection('productRequests')
      .where('status', isEqualTo: 'Completed')
      .get();

  final productRequests = productRequestsSnapshot.docs;

  for (var request in productRequests) {
    final requestData = request.data();
    final requestType = requestData['type'];
    final userId = requestData['userId'];


    final matchedPrice = prices.firstWhere(
      (price) => price['item'] == requestType,
      orElse: () => null,
    );

    if (matchedPrice != null) {

      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      final userData = userSnapshot.data();

      finalData.add({
        'productRequest': requestData,
        'price': matchedPrice,
        'user': userData,
      });
    }
  }

  return finalData;
}

Future<List<Map<String, dynamic>>> getPrices() async {
  try {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('shopDetails')
        .doc('KDc0ZUNjELfwwgt5h9QP')
        .get();

    if (doc.exists) {
      List<dynamic> prices = doc.get('prices');
      return prices.map((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      return [];
    }
  } catch (e) {
    print("Error fetching prices: $e");
    return [];
  }
}
}

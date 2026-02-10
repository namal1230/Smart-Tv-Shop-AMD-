import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  // Product service methods would be here
  CollectionReference productRequests = FirebaseFirestore.instance.collection(
    'productRequests',
  );
  static CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );

  Future<String> addProductRequest(Map<String, dynamic> requestData) async {
    try {
      final docRef = productRequests.doc();
      var value = await docRef.set({'id': docRef.id, ...requestData});
      print("Product request added with ID: ${docRef.id}");
      return "success";
    } catch (e) {
      print("Error adding product request: $e");
      return "error $e";
    }
  }

  Future<List<Map<String, dynamic>>> getProducts({String? id}) async {
    List<Map<String, dynamic>> products = [];
    print("Fetching products for user ID: $id");
    try {
      QuerySnapshot querySnapshot;
      if (id != null) {
        querySnapshot = await productRequests
            .where('userId', isEqualTo: id)
            .get();
      } else {
        querySnapshot = await productRequests.get();
      }
      for (var doc in querySnapshot.docs) {
        products.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching products: $e");
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
}

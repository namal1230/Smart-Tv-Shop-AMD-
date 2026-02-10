import 'package:cloud_firestore/cloud_firestore.dart';

class ShopService {
  CollectionReference shopDetails = FirebaseFirestore.instance.collection(
    'shopDetails',
  );

  Future<void> saveShopDetails(Map<String, dynamic> shopData) async {
    try {
      final docRef = shopDetails.doc(shopData['ownerId']);
      await docRef.set(shopData);
      print("Shop details saved for owner ID: ${shopData['ownerId']}");
    } catch (e) {
      print("Error saving shop details: $e");
    }
  }

  Future<Map<String, dynamic>?> getShopDetails() async {
    try {
      final QuerySnapshot querySnapshot = await shopDetails.get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        print("Shop details fetched: ${doc.data()}");
        return doc.data() as Map<String, dynamic>;
      } else {
        print("No shop details found.");
        return null;
      }
    } catch (e) {
      print("Error fetching shop details: $e");
      return null;
    }
  }
}

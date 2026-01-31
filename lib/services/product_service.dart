import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  // Product service methods would be here
  CollectionReference productRequests = FirebaseFirestore.instance.collection('productRequests');

  Future<String> addProductRequest(Map<String, dynamic> requestData) async {
    try{
    var value = await productRequests.add(requestData);
    print("Product request added with ID: ${value.id}");
    return "success";
    }catch(e){
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
        querySnapshot = await productRequests.where('userId', isEqualTo: id).get();
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

}
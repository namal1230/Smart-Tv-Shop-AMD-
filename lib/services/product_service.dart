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

}
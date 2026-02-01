import 'package:flutter/foundation.dart';
import 'package:smart_tv_shop/models/repair_request_model.dart';
import 'package:smart_tv_shop/services/auth_service.dart';
import 'package:smart_tv_shop/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  // Product provider methods and properties would be here
  String? _itemType;
  String? _itemModel;
  String? _itemBrand;
  String? _issueDescription;

  String? get itemType => _itemType;
  String? get itemModel => _itemModel;
  String? get itemBrand => _itemBrand;
  String? get issueDescription => _issueDescription;

  ProductProvider(){
    getProducts();
  }

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _pendingProducts = [];
  List<Map<String, dynamic>> _acceptedProducts = [];

  set itemType(String? value) {
    _itemType = value;
    notifyListeners();
  }

  set itemModel(String? value) {
    _itemModel = value;
    notifyListeners();
  }

  set itemBrand(String? value) {
    _itemBrand = value;
    notifyListeners();
  }

  set issueDescription(String? value) {
    _issueDescription = value;
    notifyListeners();
  }

  Future<String> saveProductDetails() {
    return ProductService().addProductRequest(
      RepairRequestModel(
        userId: AuthService.uid,
        type: _itemType,
        model: _itemModel,
        brand: _itemBrand,
        description: _issueDescription,
        status: "Pending",
        date: DateTime.now(),
      ).toMap(),
    );

  }

  Future<void> getProducts() async {
    var products = await ProductService().getProducts(id: AuthService.uid);
    this._products = products;
    notifyListeners();
  }

  get productList => _products;

  Future<void> getPendingProducts() async {
    var pendingProducts = await ProductService().getPendingProducts();
    this._pendingProducts = pendingProducts;
    notifyListeners();
  }

  get pendingProductsList => _pendingProducts;
  get acceptedProducts => _acceptedProducts;

  Future<void> acceptRequest(String requestId) async {
    // Logic to accept the request
    // For example, update the status in Firestore
    var requestRef = ProductService().productRequests.doc(requestId);
    await requestRef.update({'status': 'Accepted'});
    // Refresh the pending products list
    await getPendingProducts();
  }

   Future<void> rejectRequest(String requestId) async {
    // Logic to reject the request
    // For example, update the status in Firestore
    var requestRef = ProductService().productRequests.doc(requestId);
    await requestRef.update({'status': 'Rejected'});
    // Refresh the pending products list
    await getPendingProducts();
  }

  Future<void> getAcceptedProducts() async {
    var acceptedProducts = await ProductService().getAcceptedProducts();
    this._acceptedProducts = acceptedProducts;
    print("Accepted products: $_acceptedProducts");
    notifyListeners();
  }

  Future<void> markRepairCompleted(String requestId) async {
    // Logic to reject the request
    // For example, update the status in Firestore
    var requestRef = ProductService().productRequests.doc(requestId);
    await requestRef.update({'status': 'Completed'});
    // Refresh the pending products list
    await getPendingProducts();
  }

  Future<void> clearData() async {
    _itemType = null;
    _itemModel = null;
    _itemBrand = null;
    _issueDescription = null;
    _products = [];
    _pendingProducts = [];
    _acceptedProducts = [];
    notifyListeners();
  }
}
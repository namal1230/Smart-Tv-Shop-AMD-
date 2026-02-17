import 'package:flutter/foundation.dart';
import 'package:smart_tv_shop/models/repair_request_model.dart';
import 'package:smart_tv_shop/services/auth_service.dart';
import 'package:smart_tv_shop/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
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
    getProductsHistory();
    getAllItems();
  }

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>?> _productsHistory = [];
  List<Map<String, dynamic>> _pendingProducts = [];
  List<Map<String, dynamic>> _acceptedProducts = [];
  List<Map<String, dynamic>> _itemDetails = [];

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

  Future<void> getProductsHistory() async {
    var products = await ProductService().getRepairHistory();
    this._productsHistory = products;
    notifyListeners();
  }

  get productHistory => _productsHistory;

  get productList => _products;

  get itemList => _itemDetails;

  Future<void> getPendingProducts() async {
    var pendingProducts = await ProductService().getPendingProducts();
    this._pendingProducts = pendingProducts;
    notifyListeners();
  }

  get pendingProductsList => _pendingProducts;
  get acceptedProducts => _acceptedProducts;

  Future<void> acceptRequest(String requestId) async {
    var requestRef = ProductService().productRequests.doc(requestId);
    await requestRef.update({'status': 'Accepted','date':DateTime.now()});
    await getPendingProducts();
  }

   Future<void> rejectRequest(String requestId) async {
    var requestRef = ProductService().productRequests.doc(requestId);
    await requestRef.update({'status': 'Rejected','date':DateTime.now()});
    await getPendingProducts();
  }

  Future<void> getAcceptedProducts() async {
    var acceptedProducts = await ProductService().getAcceptedProducts();
    this._acceptedProducts = acceptedProducts;
    print("Accepted products: $_acceptedProducts");
    notifyListeners();
  }

  Future<void> markRepairCompleted(String requestId) async {
    var requestRef = ProductService().productRequests.doc(requestId);
    await requestRef.update({'status': 'Completed','date':DateTime.now()});
    await getPendingProducts();
  }

 Future<void> getAllItems() async {
    var items = await ProductService().getPrices();
    this._itemDetails = items;
    notifyListeners();
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
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
      ).toMap(),
    );

  }

}
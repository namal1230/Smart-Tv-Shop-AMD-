import 'package:flutter/material.dart';
import 'package:smart_tv_shop/services/shop_service.dart';

class ShopProvider extends ChangeNotifier {

  Map<String, dynamic>? _shopDetails = {};

  ShopProvider(){
    // Initialization if needed
    fetchShopDetails();
  }

  Future<void> saveShopDetails(Map<String, dynamic> shopData) async {
    // Logic to save shop details

    await ShopService().saveShopDetails(shopData);

  }

  Future<void> fetchShopDetails() async {
    final details = await ShopService().getShopDetails();
    if (details != null) {
      _shopDetails = details;
      notifyListeners();
    }

    print("Shop details in provider: $_shopDetails");
  }

  Map<String, dynamic>? get shopDetails => _shopDetails;
}
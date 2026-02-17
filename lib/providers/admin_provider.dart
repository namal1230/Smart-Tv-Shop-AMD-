import 'package:flutter/material.dart';
import 'package:smart_tv_shop/services/product_service.dart';

class AdminProvider extends ChangeNotifier {
  Map<String, dynamic>? dashboardData;
  bool isLoading = false;

  Future<void> getDashboardValues() async {
    isLoading = true;
    notifyListeners();

    final Map<String, int> totalsByProduct =
        await ProductService().getCompletedTotals();

    final int grandTotal =
        totalsByProduct.values.fold(0, (sum, v) => sum + v);

    final int completedCount =
        await ProductService().getCompletedCount() ?? 0;

    final int pendingCount =
        await ProductService().getPendingCount() ?? 0;

    final int inProgressCount =
        await ProductService().getProgressCount() ?? 0;

    dashboardData = {
      "completedCount": completedCount,
      "pendingCount": pendingCount,
      "inProgressCount": inProgressCount,
      "totalsByProduct": totalsByProduct,
      "grandTotal": grandTotal,
    };

    isLoading = false;
    notifyListeners();
  }
}
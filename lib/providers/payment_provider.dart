import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:smart_tv_shop/controllers/payment_controller.dart';

class PaymentProvider extends ChangeNotifier {
  Future<bool?> payFunction(String amount) async {
    Map<String, dynamic>? paymentIntent = await PaymentController()
        .createPaymentIntent(amount);
    try {
      if (paymentIntent != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent['client_secret'],
            style: ThemeMode.dark,
            merchantDisplayName: "Smart Tv Shop",
          ),
        );

        await Stripe.instance.presentPaymentSheet().then((value) {
          
          return true;
        });
      } else {
        return false;
      }
    } on StripeException catch (e) {
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

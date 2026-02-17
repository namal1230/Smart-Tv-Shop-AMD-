import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PaymentController {
  Future<Map<String,dynamic>?> createPaymentIntent(String amount) async{
    try{
      var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),headers: {
        'Authorization':'Bearer ${dotenv.env['SECRET_KEY']}',
        'Content-Type':'application/x-www-form-urlencoded'
      },
      body: {
        'amount':(int.parse(amount) * 100).toString(),
        'currency':'LKR',
      },
      );
      return json.decode(response.body);
    } catch(e) {
      print(e);
      return null;
    }
  }
}
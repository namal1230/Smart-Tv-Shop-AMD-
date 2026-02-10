import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_shop/providers/shop_provider.dart';

class ShopDetailsScreen extends StatelessWidget {
  const ShopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final shopDetails = Provider.of<ShopProvider>(context).shopDetails;

    final Map<String, dynamic> timings = Map<String, dynamic>.from(shopDetails?['timings'] ?? {});
    final List<Map<String, dynamic>> prices = List<Map<String, dynamic>>.from(shopDetails?['prices'] ?? []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// MAP PLACEHOLDER
            Text(
              "Shop Location",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              child: const Center(
                child: Text("Google Map Placeholder"),
              ),
            ),

            const SizedBox(height: 20),

            /// TIMINGS
            Text(
              "Available Timings & Holidays",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: timings.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.key, style: GoogleFonts.poppins()),
                          Text(e.value, style: GoogleFonts.poppins()),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// PRICES
            Text(
              "Basic Repair Prices",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: prices.map((p) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(p["item"], style: GoogleFonts.poppins()),
                    trailing: Text("Rs. ${p["amount"]}",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

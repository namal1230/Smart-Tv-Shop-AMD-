import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopDetailsScreen extends StatelessWidget {
  const ShopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final Map<String, String> timings = {
      "Weekdays": "9:00 AM - 6:00 PM",
      "Saturday": "9:00 AM - 4:00 PM",
      "Sunday": "Closed",
      "Poya Days": "Closed",
      "Christmas": "Closed",
    };

    final List<Map<String, dynamic>> prices = [
      {"item": "TV Repair", "amount": 5000},
      {"item": "Radio Repair", "amount": 2500},
      {"item": "AC Repair", "amount": 7000},
      {"item": "Microwave Repair", "amount": 3500},
    ];

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

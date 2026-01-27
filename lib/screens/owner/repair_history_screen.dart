import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class RepairHistoryScreen extends StatelessWidget {
  const RepairHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Dummy completed repairs
    final List<Map<String, dynamic>> completedRepairs = [
      {
        "item": "Samsung LED TV",
        "customer": "Kamal Perera",
        "amount": 5000,
        "date": "2026-01-15",
        "rating": 4.5,
      },
      {
        "item": "Sony Radio",
        "customer": "Nimal Silva",
        "amount": 2500,
        "date": "2026-01-16",
        "rating": 5.0,
      },
      {
        "item": "LG Smart TV",
        "customer": "Saman Perera",
        "amount": 6000,
        "date": "2026-01-18",
        "rating": 4.0,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Repair History"),
        centerTitle: true,
      ),
      body: completedRepairs.isEmpty
          ? Center(
              child: Text(
                "No completed repairs yet",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: completedRepairs.length,
              itemBuilder: (context, index) {
                final repair = completedRepairs[index];

                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// Item Name
                        Text(
                          repair["item"],
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// Customer
                        Text(
                          "Customer: ${repair["customer"]}",
                          style: GoogleFonts.poppins(),
                        ),

                        const SizedBox(height: 6),

                        /// Amount & Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount: Rs. ${repair["amount"]}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Date: ${repair["date"]}",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// Rating
                        Row(
                          children: [
                            const Text("Rating: "),
                            RatingBarIndicator(
                              rating: repair["rating"],
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

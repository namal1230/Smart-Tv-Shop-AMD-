import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_shop/providers/product_provider.dart';

class RepairHistoryScreen extends StatelessWidget {
  const RepairHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

     final List<Map<String, dynamic>?> completedRepairs =  Provider.of<ProductProvider>(context).productHistory!;
     print(completedRepairs);
   

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

                Timestamp timestamp = repair!["productRequest"]?["date"];
                DateTime dateTime = timestamp.toDate();
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

                        Text(
                          "${repair!["productRequest"]?["brand"]} ${repair["productRequest"]?["type"]}",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Customer: ${repair["user"]?["name"]}",
                          style: GoogleFonts.poppins(),
                        ),

                        const SizedBox(height: 6),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount: Rs. ${repair["price"]?["amount"]}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                         const SizedBox(height: 6),

                          Text(
                            "Repair Completed Date: ${dateTime.toLocal().toString().split(' ')[0]}",
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

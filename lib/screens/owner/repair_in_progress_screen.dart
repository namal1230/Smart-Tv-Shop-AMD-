import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_shop/providers/product_provider.dart';

class RepairInProgressScreen extends StatefulWidget {
  const RepairInProgressScreen({super.key});

  @override
  State<RepairInProgressScreen> createState() =>
      _RepairInProgressScreenState();
}

class _RepairInProgressScreenState extends State<RepairInProgressScreen> {

   @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getAcceptedProducts();
    super.initState();
  }

  List<Map<String, dynamic>> acceptRequest = [];

  void _markCompleted(String id) {
    print("id in product $id");
    Provider.of<ProductProvider>(context, listen: false)
        .markRepairCompleted(id)
        .then((_) {
      
    });
    Fluttertoast.showToast(
      msg: "Repair marked as completed",
      backgroundColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
     final List<Map<String, dynamic>> acceptedProducts =  Provider.of<ProductProvider>(context).acceptedProducts;
    print("Fetched accepted products: $acceptedProducts");
    acceptRequest =acceptedProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Repairs In Progress"),
        centerTitle: true,
      ),
      body: acceptRequest.isEmpty
          ? Center(
              child: Text(
                "No repairs in progress",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: acceptRequest.length,
              itemBuilder: (context, index) {
                final repair = acceptRequest[index];

                Timestamp timestamp = repair["date"];
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
                          repair["type"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Issue: ${repair["description"]}",
                          style: GoogleFonts.poppins(),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Customer: ${repair["user"]["name"]}",
                          style: GoogleFonts.poppins(),
                        ),

                        const SizedBox(height: 6),

                          Text(
                            "Repair Accept Date: ${dateTime.toLocal().toString().split(' ')[0]}",
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                        const SizedBox(height: 12),

                        Chip(
                          label: Text(repair["status"]!),
                          backgroundColor: Colors.orange.shade100,
                          labelStyle: const TextStyle(color: Colors.orange),
                        ),

                        const SizedBox(height: 16),

                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            onPressed: () => _markCompleted(repair['id']),
                            icon: const Icon(Icons.check_circle),
                            label: const Text("Mark Completed"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                          ),
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

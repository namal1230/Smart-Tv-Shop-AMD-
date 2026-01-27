import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RepairInProgressScreen extends StatefulWidget {
  const RepairInProgressScreen({super.key});

  @override
  State<RepairInProgressScreen> createState() =>
      _RepairInProgressScreenState();
}

class _RepairInProgressScreenState extends State<RepairInProgressScreen> {
  final List<Map<String, String>> inProgressRepairs = [
    {
      "item": "Samsung LED TV",
      "issue": "Display issue",
      "customer": "Kamal Perera",
      "status": "In Progress",
    },
    {
      "item": "Sony Radio",
      "issue": "No sound",
      "customer": "Nimal Silva",
      "status": "In Progress",
    },
  ];

  void _markCompleted(int index) {
    Fluttertoast.showToast(
      msg: "Repair marked as completed",
      backgroundColor: Colors.green,
    );

    setState(() {
      inProgressRepairs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repairs In Progress"),
        centerTitle: true,
      ),
      body: inProgressRepairs.isEmpty
          ? Center(
              child: Text(
                "No repairs in progress",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: inProgressRepairs.length,
              itemBuilder: (context, index) {
                final repair = inProgressRepairs[index];

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

                        /// Item
                        Text(
                          repair["item"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// Issue
                        Text(
                          "Issue: ${repair["issue"]}",
                          style: GoogleFonts.poppins(),
                        ),

                        const SizedBox(height: 6),

                        /// Customer
                        Text(
                          "Customer: ${repair["customer"]}",
                          style: GoogleFonts.poppins(),
                        ),

                        const SizedBox(height: 12),

                        /// Status Chip
                        Chip(
                          label: Text(repair["status"]!),
                          backgroundColor: Colors.orange.shade100,
                          labelStyle: const TextStyle(color: Colors.orange),
                        ),

                        const SizedBox(height: 16),

                        /// Complete Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            onPressed: () => _markCompleted(index),
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

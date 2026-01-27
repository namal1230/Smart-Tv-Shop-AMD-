import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv_shop/screens/owner/request_details_screen.dart';

class PendingRequestsScreen extends StatefulWidget {
  const PendingRequestsScreen({super.key});

  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen> {
  final List<Map<String, String>> pendingRequests = [
    {
      "item": "Samsung LED TV",
      "issue": "No display",
      "customer": "Kamal Perera",
      "phone": "0771234567",
      "date": "2026-01-20",
    },
    {
      "item": "Sony Radio",
      "issue": "Sound issue",
      "customer": "Nimal Silva",
      "phone": "0719876543",
      "date": "2026-01-21",
    },
  ];

  void _acceptRequest(int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      title: "Accept Request",
      desc: "Do you want to accept this repair request?",
      btnOkText: "Accept",
      btnOkOnPress: () {
        setState(() {
          pendingRequests.removeAt(index);
        });
      },
      btnCancelOnPress: () {},
    ).show();
  }

  void _rejectRequest(int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      title: "Reject Request",
      desc: "Are you sure you want to reject this request?",
      btnOkText: "Reject",
      btnOkOnPress: () {
        setState(() {
          pendingRequests.removeAt(index);
        });
      },
      btnCancelOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending Repair Requests"),
        centerTitle: true,
      ),
      body: pendingRequests.isEmpty
          ? Center(
              child: Text(
                "No pending requests",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pendingRequests.length,
              itemBuilder: (context, index) {
                final request = pendingRequests[index];

                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RequestDetailsScreen()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          /// Item name
                          Text(
                            request["item"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      
                          const SizedBox(height: 8),
                      
                          /// Issue
                          Text(
                            "Issue: ${request["issue"]}",
                            style: GoogleFonts.poppins(),
                          ),
                      
                          const SizedBox(height: 6),
                      
                          /// Customer
                          Text(
                            "Customer: ${request["customer"]}",
                            style: GoogleFonts.poppins(),
                          ),
                      
                          const SizedBox(height: 6),
                      
                          /// Phone
                          Text(
                            "Phone: ${request["phone"]}",
                            style: GoogleFonts.poppins(),
                          ),
                      
                          const SizedBox(height: 6),
                      
                          /// Date
                          Text(
                            "Requested Date: ${request["date"]}",
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                      
                          const SizedBox(height: 16),
                      
                          /// Action Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () => _rejectRequest(index),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: const Text("Reject"),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () => _acceptRequest(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text("Accept"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

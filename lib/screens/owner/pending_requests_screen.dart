import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_shop/providers/product_provider.dart';
import 'package:smart_tv_shop/screens/owner/request_details_screen.dart';

class PendingRequestsScreen extends StatefulWidget {
  const PendingRequestsScreen({super.key});

  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen> {

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getPendingProducts();
    super.initState();
  }

  List<Map<String, dynamic>> pendingRequests = [];

  void _acceptRequest(int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      title: "Accept Request",
      desc: "Do you want to accept this repair request?",
      btnOkText: "Accept",
      btnOkOnPress: () {
        Provider.of<ProductProvider>(context, listen: false)
                            .acceptRequest(pendingRequests[index]['id'])
                            .then((_) {

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
           Provider.of<ProductProvider>(context, listen: false)
                            .rejectRequest(pendingRequests[index]['id'])
                            .then((_) {
                          
                        });
      },
      btnCancelOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pendingProducts =  Provider.of<ProductProvider>(context).pendingProductsList;
    print("Fetched pending products: $pendingProducts");
    pendingRequests =pendingProducts;

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

                Timestamp timestamp = request["date"];
                DateTime dateTime = timestamp.toDate();

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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RequestDetailsScreen(request: request)));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          /// Item name
                          Text(
                            request["type"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      
                          const SizedBox(height: 8),
                      
                          /// Issue
                          Text(
                            "Issue: ${request["description"]}",
                            style: GoogleFonts.poppins(),
                          ),
                      
                          const SizedBox(height: 6),
                      
                          /// Customer
                          Text(
                            "Customer: ${request["user"]["name"]}",
                            style: GoogleFonts.poppins(),
                          ),
                      
                          const SizedBox(height: 6),
                      
                          /// Phone
                          Text(
                            "Phone: ${request["user"]["contact"]}",
                            style: GoogleFonts.poppins(),
                          ),
                      
                          const SizedBox(height: 6),
                      
                          /// Date
                          Text(
                            "Requested Date: ${dateTime.toLocal().toString().split(' ')[0]}",
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

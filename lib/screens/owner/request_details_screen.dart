import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_shop/providers/product_provider.dart';

class RequestDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> request;

  const RequestDetailsScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = request["date"];
    DateTime dateTime = timestamp.toDate();


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Request Details"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              _sectionTitle("Item Information"),
              _infoTile("Item", request["type"]!),
              _infoTile("Brand", request["brand"]!),
              _infoTile("Issue", request["description"]!),
      
              const SizedBox(height: 20),
      
              _sectionTitle("Customer Information"),
              _infoTile("Name", request["user"]["name"]!),
              _infoTile("Phone", request["user"]["contact"]!),
              _infoTile("Email", request["user"]["email"]!),
              _infoTile("Address", request["user"]["address"]!),
              const SizedBox(height: 20),
      
              _sectionTitle("Request Info"),
              _infoTile("Requested Date", dateTime.toLocal().toString().split(' ')[0]),
      
              const SizedBox(height: 30),
      
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Back"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<ProductProvider>(context, listen: false)
                            .acceptRequest(request['id'])
                            .then((_) {
                          Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Accept Request"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          value,
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}

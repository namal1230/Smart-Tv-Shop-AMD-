import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    /// Dummy data (later replace with real model)
    final Map<String, String> request = {
      "item": "Samsung 55'' Smart TV",
      "brand": "Samsung",
      "issue": "Screen flickering and no sound",
      "customer": "Kamal Perera",
      "phone": "0771234567",
      "email": "kamal@gmail.com",
      "address": "No. 45, Galle Road, Colombo",
      "requestedDate": "2026-01-20",
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ITEM INFO
            _sectionTitle("Item Information"),
            _infoTile("Item", request["item"]!),
            _infoTile("Brand", request["brand"]!),
            _infoTile("Issue", request["issue"]!),

            const SizedBox(height: 20),

            /// CUSTOMER INFO
            _sectionTitle("Customer Information"),
            _infoTile("Name", request["customer"]!),
            _infoTile("Phone", request["phone"]!),
            _infoTile("Email", request["email"]!),
            _infoTile("Address", request["address"]!),

            const SizedBox(height: 20),

            /// DATE INFO
            _sectionTitle("Request Info"),
            _infoTile("Requested Date", request["requestedDate"]!),

            const SizedBox(height: 30),

            /// ACTION BUTTONS
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
                    onPressed: () {},
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

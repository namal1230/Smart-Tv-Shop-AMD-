import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_shop/providers/product_provider.dart';

class CustomerRequestsScreen extends StatelessWidget {
  const CustomerRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Building CustomerRequestsScreen");
    Provider.of<ProductProvider>(context, listen: false).getProducts();

    // var products = Provider.of<ProductProvider>(context).productList;


    // Dummy requests data
    final List<Map<String, dynamic>> requests =  Provider.of<ProductProvider>(context).productList;
    print("Fetched products: $requests");
    Color statusColor(String status) {
      switch (status) {
        case "Accepted":
          return Colors.green;
        case "Rejected":
          return Colors.red;
        case "Pending":
        default:
          return Colors.orange;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Requests"),
        centerTitle: true,
      ),
      body: requests.isEmpty
          ? Center(
              child: Text(
                "You have no requests yet",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];

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

                         Text(
                          "Brand: ${request["brand"]}",
                          style: GoogleFonts.poppins(),
                        ),

                        const SizedBox(height: 6),

                         Text(
                          "Model: ${request["model"]}",
                          style: GoogleFonts.poppins(),
                        ),

                        const SizedBox(height: 6),
                        /// Date
                        Text(
                          "Date: ${new DateTime.now().day}/${new DateTime.now().month}/${new DateTime.now().year}",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),

                        const SizedBox(height: 12),

                        /// Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                color: statusColor(request["status"]!)
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                request["status"]!,
                                style: GoogleFonts.poppins(
                                  color: statusColor(request["status"]!),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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

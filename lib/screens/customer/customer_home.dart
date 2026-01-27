import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv_shop/screens/customer/customer_requests_screen.dart';
import 'package:smart_tv_shop/screens/customer/request_repair_screen.dart';
import 'package:smart_tv_shop/screens/customer/shop_details_screen.dart';

class CustomerHome extends StatelessWidget {
  const CustomerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        "title": "Shop Details",
        "icon": Icons.storefront,
        "route": ShopDetailsScreen(),
        "color": Colors.deepPurple,
      },
      {
        "title": "Request Repair",
        "icon": Icons.build,
        "route": RequestRepairScreen(),
        "color": Colors.orange,
      },
      {
        "title": "My Requests",
        "icon": Icons.pending_actions,
        "route": CustomerRequestsScreen(),
        "color": Colors.blue,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Home"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            FadeInDown(
              child: Text(
                "Welcome, Customer 👋",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.builder(
                itemCount: features.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * index),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => feature['route']));
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(feature['icon'], size: 50, color: feature['color']),
                            const SizedBox(height: 12),
                            Text(
                              feature['title'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

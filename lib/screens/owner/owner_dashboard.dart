import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv_shop/screens/customer/shop_details_screen.dart';
import 'package:smart_tv_shop/screens/owner/pending_requests_screen.dart';
import 'package:smart_tv_shop/screens/owner/repair_history_screen.dart';
import 'package:smart_tv_shop/screens/owner/repair_in_progress_screen.dart';
import 'package:smart_tv_shop/screens/owner/request_details_screen.dart';
import 'package:smart_tv_shop/screens/owner/shop_details_edit_screen.dart';
import 'package:smart_tv_shop/services/auth_service.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Call sign out method from AuthService
              AuthService(context).signOut();
            },
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            FadeInDown(
              child: Text(
                "Welcome, Shop Owner 👋",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// STAT CARDS
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [

                  FadeInUp(
                    child: _statCard(
                      context,
                      title: "Pending Repairs",
                      value: "8",
                      icon: Icons.pending_actions,
                      color: Colors.orange,
                      route: PendingRequestsScreen(),
                    ),
                  ),

                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: _statCard(
                      context,
                      title: "In Progress",
                      value: "5",
                      icon: Icons.build_circle,
                      color: Colors.blue,
                      route: RepairInProgressScreen(),
                    ),
                  ),

                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _statCard(
                      context,
                      title: "Completed",
                      value: "23",
                      icon: Icons.check_circle,
                      color: Colors.green,
                      route: RepairHistoryScreen(),
                    ),
                  ),

                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: _statCard(
                      context,
                      title: "Total Earnings",
                      value: "Rs. 185,000",
                      icon: Icons.currency_rupee,
                      color: Colors.purple,
                      route: null,
                    ),
                  ),

                  FadeInUp(
                    child: _statCard(
                      context,
                      title: "Shop Details",
                      value: "8",
                      icon: Icons.shop,
                      color: Colors.orange,
                      route: ShopDetailsEditScreen(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    Widget? route,
  }) {
    return InkWell(
      onTap: route == null
          ? null
          : () => Navigator.push(context, MaterialPageRoute(builder: (context) => route)),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

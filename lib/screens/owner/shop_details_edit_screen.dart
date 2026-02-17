import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_shop/providers/shop_provider.dart';

class ShopDetailsEditScreen extends StatefulWidget {
  const ShopDetailsEditScreen({super.key});

  @override
  State<ShopDetailsEditScreen> createState() => _ShopDetailsEditScreenState();
}

class _ShopDetailsEditScreenState extends State<ShopDetailsEditScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _initialized = false;
  final Map<String, TextEditingController> _timingsControllers = {
    "Weekdays": TextEditingController(),
    "Saturday": TextEditingController(),
    "Sunday": TextEditingController(),
    "Poya Days": TextEditingController(),
    "Christmas": TextEditingController(),
  };

  List<Map<String, dynamic>> _prices = [];

  void _addPriceDialog() {
    final itemController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Repair Price"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: itemController,
              decoration: const InputDecoration(labelText: "Item"),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _prices.add({
                  "item": itemController.text,
                  "amount": int.parse(amountController.text),
                });
              });
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  /// Save action
  void _saveShopDetails() {
    if (!_formKey.currentState!.validate()) return;

    final shopData = {
      "timings": {
        for (var e in _timingsControllers.entries) e.key: e.value.text,
      },
      "prices": _prices,
    };

    debugPrint("Shop Details: $shopData");

    Provider.of<ShopProvider>(context, listen: false)
        .saveShopDetails(shopData)
        .then((_) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Shop details saved")));
        })
        .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to save shop details: $error")),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final shopDetails = Provider.of<ShopProvider>(
          context,
          listen: false,
        ).shopDetails;

        if (shopDetails == null || _initialized) return;

        final timings = Map<String, dynamic>.from(shopDetails['timings'] ?? {});

        for (final key in _timingsControllers.keys) {
          _timingsControllers[key]!.text = timings[key] ?? "";
        }

        _initialized = true;
      });
    }

    @override
    void dispose() {
      for (final c in _timingsControllers.values) {
        c.dispose();
      }
      super.dispose();
    }

    final shopDetails = Provider.of<ShopProvider>(context).shopDetails;

    final List<Map<String, dynamic>> prices = List<Map<String, dynamic>>.from(
      shopDetails?['prices'] ?? [],
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Manage Shop Details"),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveShopDetails,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shop Location",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade300,
                  ),
                  child: const Center(child: Text("Map Picker Coming Soon")),
                ),

                const SizedBox(height: 20),

                Text(
                  "Timings & Holidays",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ..._timingsControllers.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: e.value,
                      decoration: InputDecoration(
                        labelText: e.key,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),
                  );
                }),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Repair Prices",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _addPriceDialog,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ..._prices.map((p) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(p["item"]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Rs. ${p["amount"]}"),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() => _prices.remove(p));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                ...prices.map((p) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(p["item"], style: GoogleFonts.poppins()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Rs. ${p["amount"]}"),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() => prices.remove(p));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

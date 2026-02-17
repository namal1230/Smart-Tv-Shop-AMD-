import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_shop/providers/product_provider.dart';

class RequestRepairScreen extends StatefulWidget {
  const RequestRepairScreen({super.key});

  @override
  State<RequestRepairScreen> createState() => _RequestRepairScreenState();
}

class _RequestRepairScreenState extends State<RequestRepairScreen> {
  final _formKey = GlobalKey<FormState>();

  final _itemController = TextEditingController();
  final _brandController = TextEditingController();
  final _issueController = TextEditingController();

  String selectedItemType = "TV";

  void submitRequest() {
    if (!_formKey.currentState!.validate()) return;

    Provider.of<ProductProvider>(context, listen: false).itemType =
        selectedItemType;
    Provider.of<ProductProvider>(context, listen: false).itemModel =
        _itemController.text;
    Provider.of<ProductProvider>(context, listen: false).itemBrand =
        _brandController.text;
    Provider.of<ProductProvider>(context, listen: false).issueDescription =
        _issueController.text;

    Provider.of<ProductProvider>(
      context,
      listen: false,
    ).saveProductDetails().then((value) {
      if (value == "success") {
        Fluttertoast.showToast(
          msg: "Repair request submitted successfully!",
          backgroundColor: Colors.green,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to submit repair request.",
          backgroundColor: Colors.red,
        );
      }
    });

    Fluttertoast.showToast(
      msg: "Repair request submitted successfully!",
      backgroundColor: Colors.green,
    );

    _formKey.currentState!.reset();
    setState(() {
      selectedItemType = "TV";
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = Provider.of<ProductProvider>(
      context,
    ).itemList;
    print("Fetched pending products: $items");

    return Scaffold(
      appBar: AppBar(title: const Text("Request Repair"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: selectedItemType,
                decoration: _inputDecoration(label: "Item Type"),
                items: [
                  ...items.map((item) {
                    return DropdownMenuItem<String>(
                      value: item["item"],
                      child: Text("${item["item"]} | Rs.${item["amount"]}"),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedItemType = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _itemController,
                decoration: _inputDecoration(label: "Item Name / Model"),
                validator: (value) =>
                    value!.isEmpty ? "Item name is required" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _brandController,
                decoration: _inputDecoration(label: "Brand"),
                validator: (value) =>
                    value!.isEmpty ? "Brand is required" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _issueController,
                decoration: _inputDecoration(label: "Describe the issue"),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? "Please describe the issue" : null,
              ),

              const SizedBox(height: 16),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 221, 219, 226),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Submit Request"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String label}) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      prefixIcon: const Icon(Icons.build),
    );
  }
}

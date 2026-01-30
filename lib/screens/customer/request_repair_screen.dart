import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final _customerNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

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

    Provider.of<ProductProvider>(context, listen: false)
        .saveProductDetails().then((value) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Repair"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              /// Item Type
              DropdownButtonFormField<String>(
                value: selectedItemType,
                decoration: _inputDecoration(label: "Item Type"),
                items: const [
                  DropdownMenuItem(value: "TV", child: Text("TV")),
                  DropdownMenuItem(value: "Radio", child: Text("Radio")),
                  DropdownMenuItem(value: "AC", child: Text("AC")),
                  DropdownMenuItem(value: "Microwave", child: Text("Microwave")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedItemType = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              /// Item Name / Model
              TextFormField(
                controller: _itemController,
                decoration: _inputDecoration(label: "Item Name / Model"),
                validator: (value) =>
                    value!.isEmpty ? "Item name is required" : null,
              ),

              const SizedBox(height: 16),

              /// Brand
              TextFormField(
                controller: _brandController,
                decoration: _inputDecoration(label: "Brand"),
                validator: (value) =>
                    value!.isEmpty ? "Brand is required" : null,
              ),

              const SizedBox(height: 16),

              /// Issue
              TextFormField(
                controller: _issueController,
                decoration: _inputDecoration(label: "Describe the issue"),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? "Please describe the issue" : null,
              ),

              const SizedBox(height: 16),

              /// Customer Name
              TextFormField(
                controller: _customerNameController,
                decoration: _inputDecoration(label: "Your Name"),
                validator: (value) =>
                    value!.isEmpty ? "Name is required" : null,
              ),

              const SizedBox(height: 16),

              /// Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration(label: "Phone Number"),
                validator: (value) =>
                    value!.length < 9 ? "Invalid phone number" : null,
              ),

              const SizedBox(height: 16),

              /// Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(label: "Email"),
                validator: (value) =>
                    value!.contains("@") ? null : "Enter valid email",
              ),

              const SizedBox(height: 30),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
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

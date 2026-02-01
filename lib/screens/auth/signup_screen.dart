import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_shop/providers/auth_provider.dart';
import 'package:smart_tv_shop/services/auth_service.dart';
import 'package:smart_tv_shop/services/image_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  bool obscurePassword = true;
  String selectedRole = "Customer";

  @override
  void initState() {
    // TODO: implement initState
    AuthService(context);
    super.initState();
  }

  void signup() {
    if (!_formKey.currentState!.validate()) return;

    // Call the AuthService to sign up the user
    // AuthService.signUp(
    //   _emailController.text,
    //   _passwordController.text,
    //   selectedRole,
    //   _nameController.text,
    //   _phoneController.text,
    // );

    final result = Provider.of<AuthStateProvider>(context, listen: false)
        .signUp(
          _emailController.text,
          _passwordController.text,
          selectedRole,
          _nameController.text,
          _phoneController.text,
          _addressController.text,
        )
        .then(
          (value) => Fluttertoast.showToast(
            msg: value == "success"
                ? "Account created successfully"
                : "Error creating account",
            backgroundColor: value == "success" ? Colors.green : Colors.red,
          ),
        );

    Navigator.pop(context); // back to login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    "Create your account to continue",
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 30),

                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Profile Picture"),
                          content: const Text(
                            "Choose you profile picture from gallery or take a new photo.",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => context
                                  .read<AuthStateProvider>()
                                  .pickImage("gallery"),
                              child: const Text("choose from gallery"),
                            ),
                            TextButton(
                              onPressed: () => context
                                  .read<AuthStateProvider>()
                                  .pickImage("camera"),
                              child: const Text("take a new photo"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Consumer<AuthStateProvider>(
                    builder: (context, authProvider, child) {
                      return Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child:
                              authProvider.imagePath == null ||
                                  authProvider.imagePath!.path.isEmpty
                              ? Container(
                                  color: Colors.deepPurple.shade50,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                    color: Colors.deepPurple,
                                  ),
                                )
                              : Image.file(
                                  authProvider.imagePath!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                /// Name
                FadeInLeft(
                  child: TextFormField(
                    controller: _nameController,
                    decoration: _inputDecoration(
                      label: "Full Name",
                      icon: Icons.person,
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Name is required" : null,
                  ),
                ),

                const SizedBox(height: 20),

                /// Email
                FadeInRight(
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration(
                      label: "Email",
                      icon: Icons.email,
                    ),
                    validator: (value) =>
                        value!.contains("@") ? null : "Enter valid email",
                  ),
                ),

                const SizedBox(height: 20),

                /// Phone
                FadeInLeft(
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: _inputDecoration(
                      label: "Phone Number",
                      icon: Icons.phone,
                    ),
                    validator: (value) =>
                        value!.length < 9 ? "Invalid phone number" : null,
                  ),
                ),

                const SizedBox(height: 20),

                FadeInLeft(
                  child: TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: _inputDecoration(
                      label: "Address",
                      icon: Icons.home,
                    ),
                    validator: (value) =>
                        value!.length < 9 ? "Invalid address" : null,
                  ),
                ),
                const SizedBox(height: 20),

                /// Password
                FadeInRight(
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: obscurePassword,
                    decoration:
                        _inputDecoration(
                          label: "Password",
                          icon: Icons.lock,
                        ).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                        ),
                    validator: (value) => value!.length < 6
                        ? "Password must be at least 6 characters"
                        : null,
                  ),
                ),

                const SizedBox(height: 30),

                /// Signup Button
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: signup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Back to Login
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Already have an account? Login"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

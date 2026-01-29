import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv_shop/providers/auth_provider.dart';
import 'package:smart_tv_shop/services/auth_service.dart';

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
    AuthService.signUp(
       _emailController.text,
       _passwordController.text,
        selectedRole,
        _nameController.text,
        _phoneController.text
    );

    Fluttertoast.showToast(
      msg: "Account created successfully",
      backgroundColor: Colors.green,
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

                const SizedBox(height: 20),

                /// Role
                FadeInUp(
                  child: DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: _inputDecoration(
                      label: "Register As",
                      icon: Icons.person_outline,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Customer",
                        child: Text("Customer"),
                      ),
                      DropdownMenuItem(
                        value: "Owner",
                        child: Text("Shop Owner"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value!;
                      });
                    },
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

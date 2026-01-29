import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv_shop/screens/auth/reset_password_screen.dart';
import 'package:smart_tv_shop/screens/auth/signup_screen.dart';
import 'package:smart_tv_shop/screens/customer/customer_home.dart';
import 'package:smart_tv_shop/screens/owner/owner_dashboard.dart';
import 'package:smart_tv_shop/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String selectedRole = "Customer";
  bool obscurePassword = true;

  void login() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields");
      return;
    }

    AuthService.signIn(_emailController.text, _passwordController.text, selectedRole,context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: Text(
                  "Welcome Back 👋",
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
                  "Login to continue",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              ),

              const SizedBox(height: 30),

              FadeInLeft(
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              FadeInRight(
                child: TextField(
                  controller: _passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              FadeInUp(
                child: DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: InputDecoration(
                    labelText: "Login As",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Customer",
                      child: Text("Customer"),
                    ),
                    DropdownMenuItem(value: "Owner", child: Text("Shop Owner")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Login", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Center(
                  child: Column(
                    children:[ TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/signup');
                      },
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                        },
                        child: const Text("Don't have an account? Sign Up")
                        ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/signup');
                      },
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(),));
                        },
                        child: const Text("Forgot Password? Reset Here")
                        ),
                    ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

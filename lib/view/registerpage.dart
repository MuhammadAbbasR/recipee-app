import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/auth_vm.dart';
import '../widget/MyButton.dart';
import '../widget/textfield.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthVm(),
      child: Consumer<AuthVm>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock_open_rounded,
                      size: 100,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Let's create an account",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 25),
                    Textfield(
                      controller: emailController,
                      hinttext: 'Email',
                      obscuretext: false,
                    ),
                    const SizedBox(height: 25),
                    Textfield(
                      controller: passwordController,
                      hinttext: 'Password',
                      obscuretext: true,
                    ),
                    const SizedBox(height: 25),
                    Textfield(
                      controller: confirmPasswordController,
                      hinttext: 'Confirm Password',
                      obscuretext: true,
                    ),
                    const SizedBox(height: 25),
                    vm.status == AuthStatus.loading
                        ? const CircularProgressIndicator()
                        : MyButton(
                      onTap: () async {
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match"),
                            ),
                          );
                          return;
                        }

                        await vm.signUp(emailController.text,
                            passwordController.text);

                        if (vm.status == AuthStatus.success) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(

                                "Registration Successful",
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              backgroundColor: Colors.greenAccent,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              duration: const Duration(seconds: 3), // auto-dismiss
                            ),
                          );

                          // Navigate to login or home
                          // Navigator.pushReplacementNamed(context, '/login');
                        } else if (vm.status == AuthStatus.error) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(

                                "error ${vm.errorMessage}",
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              duration: const Duration(seconds: 3), // auto-dismiss
                            ),
                          );
                        }
                      },
                      text: "Sign Up",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
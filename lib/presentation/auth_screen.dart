import 'package:flutter/material.dart';
import 'package:triathlon_tracker/presentation/onboarding/custom_button.dart';
import 'package:triathlon_tracker/presentation/onboarding/custom_text_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),
              const Text(
                "We are glad to see you again!",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9EA1B2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24, bottom: 32),
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF40445C),
                  ),
                ),
              ),
              CustomTextForm(
                controller: _emailController,
                hintText: 'enter your email here',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF40445C),
                  ),
                ),
              ),
              CustomTextForm(
                controller: _passwordController,
                hintText: 'enter your password here',
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: CustomButton(
                  title: 'Continue',
                  onPressed: () async {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

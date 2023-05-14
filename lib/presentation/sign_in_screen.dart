import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triathlon_tracker/bloc/sign_in/sign_in_bloc.dart';
import 'package:triathlon_tracker/presentation/error_widget.dart';
import 'package:triathlon_tracker/presentation/landing_screen.dart';
import 'package:triathlon_tracker/presentation/onboarding/custom_button.dart';
import 'package:triathlon_tracker/presentation/onboarding/custom_text_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      context
          .read<SignInBloc>()
          .add(SignInEvent.emailChanged(_emailController.text));
    });
    _passwordController.addListener(() {
      context
          .read<SignInBloc>()
          .add(SignInEvent.passwordChanged(_passwordController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                  splashRadius: 24,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SignInButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            showError(context, message);
          },
          success: () {
            Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(builder: (context) => const LandingScreen()),
              (route) => false,
            );
          },
        );
      },
      builder: (context, state) {
        final isActive = state.maybeWhen(
          buttonState: (isActive) => isActive,
          success: () => true,
          error: (_) => true,
          orElse: () => false,
        );
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: CustomButton(
            isActive: isActive,
            isLoading: isLoading,
            title: 'Continue',
            onPressed: () async {
              context.read<SignInBloc>().add(
                    const SignInEvent.buttonPressed(),
                  );
            },
          ),
        );
      },
    );
  }
}

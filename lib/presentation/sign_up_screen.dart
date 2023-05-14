import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triathlon_tracker/bloc/sign_up/sign_up_bloc.dart';
import 'package:triathlon_tracker/data/session_manager.dart';
import 'package:triathlon_tracker/domain/goals.dart';
import 'package:triathlon_tracker/injection.dart';
import 'package:triathlon_tracker/managers/trainings.manager.dart';
import 'package:triathlon_tracker/presentation/error_widget.dart';
import 'package:triathlon_tracker/presentation/landing_screen.dart';
import 'package:triathlon_tracker/presentation/onboarding/custom_button.dart';
import 'package:triathlon_tracker/presentation/onboarding/custom_text_form.dart';
import 'package:triathlon_tracker/presentation/sign_in_screen.dart';
import 'package:triathlon_tracker/state_holders/personal_info_state_holder/personal_info_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      context
          .read<SignUpBloc>()
          .add(SignUpEvent.emailChanged(_emailController.text));
    });
    _passwordController.addListener(() {
      context
          .read<SignUpBloc>()
          .add(SignUpEvent.passwordChanged(_passwordController.text));
    });
    getIt.get<SessionManager>().getAuthToken().then((token) {
      if (token != null) {
        getIt.get<SessionManager>().initToken(token);
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => const LandingScreen(),
          ),
        );
      }
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
                  obscureText: true,
                  hintText: 'enter your password here',
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'Already have account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A6680),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                const SignInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocConsumer<SignUpBloc, SignUpState>(
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
              final goals =
                  ref.read(personalInfoStateNotifierProvider).maybeWhen(
                        orElse: () => Goals(
                          swimming: 0,
                          cycling: 0,
                          running: 0,
                        ),
                        data: (goals, profile) => goals,
                      );
              final name =
                  ref.read(personalInfoStateNotifierProvider).maybeWhen(
                        orElse: () => '',
                        data: (goals, profile) => profile.name,
                      );
              context.read<SignUpBloc>().add(
                    SignUpEvent.buttonPressed(
                      name,
                      goals,
                    ),
                  );
            },
          ),
        );
      },
    );
  }
}

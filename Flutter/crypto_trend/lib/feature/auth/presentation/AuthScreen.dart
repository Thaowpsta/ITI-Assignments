import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/setupLocator.dart';
import '../../../utils/AppAssets.dart';
import '../../../utils/AppColors.dart';
import '../../../utils/AppRoutes.dart';
import '../../../utils/widgets/CustomTextField.dart';
import '../../../utils/widgets/PrimaryButton.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/auth_state.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(repository: appRepository)..loadSavedCredentials(),
      child: const AuthView(),
    );
  }
}

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is AuthSuccess) {
              if (isLogin) {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registered! Please Login.')));
                _emailController.clear();
                _passwordController.clear();
                setState(() {
                  isLogin = true;
                });
              }
            } else if (state is AuthCredentialsLoaded) {
              _emailController.text = state.email;
              _passwordController.text = state.password;
              _rememberMe = true;
            }
          },
          builder: (context, state) {
            bool isLoading = state is AuthLoading;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors.overlay50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                onPressed: () {
                                  setState(() {
                                    isLogin = true;
                                  });
                                },
                                backgroundColor: isLogin ? AppColors.darkBackground : AppColors.overlay50,
                                text: "Sign In",
                                textColor: AppColors.white,
                              ),
                            ),
                            Expanded(
                              child: PrimaryButton(
                                onPressed: () {
                                  setState(() {
                                    isLogin = false;
                                  });
                                },
                                backgroundColor: isLogin ? AppColors.overlay50 : AppColors.darkBackground,
                                text: "Sign Up",
                                textColor: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      isLogin ? "Sign in" : "Sign Up",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 44),
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      text: "Please enter Email",
                      controller: _emailController,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Pass",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      text: "Please enter Pass",
                      controller: _passwordController,
                      icon: const Icon(
                        Icons.visibility_off_sharp,
                        color: AppColors.grey,
                      ),
                      isObscure: true,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: _rememberMe,
                                onChanged: (val) {
                                  setState(() {
                                    _rememberMe = val ?? false;
                                  });
                                },
                                activeColor: AppColors.primary,
                                side: const BorderSide(color: AppColors.grey),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Remember me",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.lightGrey,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.primary25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    PrimaryButton(
                      onPressed: isLoading
                          ? () {}
                          : () {
                        if (isLogin) {
                          context.read<AuthCubit>().login(_emailController.text, _passwordController.text, _rememberMe);
                        } else {
                          context.read<AuthCubit>().register(_emailController.text, _passwordController.text);
                        }
                      },
                      text: isLoading ? 'Processing...' : (isLogin ? 'Sign In' : 'Sign Up'),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Expanded(child: Divider(color: AppColors.white)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Or login with",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.grey),
                          ),
                        ),
                        Expanded(child: Divider(color: AppColors.white)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: PrimaryButton(onPressed: () {}, text: "Facebook", backgroundColor: AppColors.white, icon: AppAssets.facebook)),
                        const SizedBox(width: 20),
                        Expanded(child: PrimaryButton(onPressed: () {}, text: "Google", backgroundColor: AppColors.white, icon: AppAssets.google)),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedplan/core/config/exception.dart';
import 'package:wedplan/core/theme/color.dart';
import 'package:wedplan/core/utils/assets.dart';
import 'package:wedplan/core/utils/definites.dart';
import 'package:wedplan/features/auth/data/dto.dart';
import 'package:wedplan/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wedplan/features/home/presentation/pages/home_page.dart';
import 'package:wedplan/shared/widgets/elevated_button.dart';
import 'package:wedplan/shared/widgets/textfield.dart';

import '../../../../core/utils/validations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _registerMode = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.error != current.error || previous.user != current.user,
      listener: (context, state) {
        final error = state.error;
        log(error ?? "Nope");
        if (error != null) {
          Fluttertoast.showToast(msg: error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(AppAssets.logo, height: 400.h, width: 400.h),
                  AppTextField(
                    controller: _email,
                    hintText: "email@example.com",
                    validator: Validation.emailValidator,
                  ),
                  AppTextField(
                    controller: _pass,
                    hintText: "Enter password",
                    obscureText: true,
                    validator: Validation.passValidator,
                  ),

                  SizedBox(height: 20.h),
                  AppElevatedButton(
                    onPressed: _registerMode
                        ? _onSignUpPressed
                        : _onSignInPressed,
                    loading: state.loginStatus == AppStatus.loading,
                    label: _registerMode ? "Sign up" : "Sign in",
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _registerMode
                            ? "Already have an account ?"
                            : "Don't have an account ?",
                        style: AppDefinites.style,
                      ),
                      SizedBox(width: 5.w),
                      GestureDetector(
                        onTap: _onRegisterHereTap,
                        child: Text(
                          _registerMode ? "Log in" : "Register here",
                          style: AppDefinites.style.copyWith(
                            color: AppColor.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSignInPressed() async {
    if (_key.currentState?.validate() ?? false) {
      final success = await context.read<AuthCubit>().login(
        loginDto: LoginDTO(
          email: _email.text.trim(),
          password: _pass.text.trim(),
        ),
      );
      if (mounted && success) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      }
    }
  }

  void _onSignUpPressed() async {
    if (_key.currentState?.validate() ?? false) {
      final success = await context.read<AuthCubit>().register(
        loginDto: LoginDTO(
          email: _email.text.trim(),
          password: _pass.text.trim(),
        ),
      );
      if (mounted && success) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      }
    }
  }

  AppBar buildAppBar() {
    return AppBar(toolbarHeight: 0);
  }

  void _onRegisterHereTap() {
    setState(() {
      _registerMode = !_registerMode;
    });
  }
}

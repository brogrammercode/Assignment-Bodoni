import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wedplan/core/config/exception.dart';
import 'package:wedplan/core/utils/assets.dart';
import 'package:wedplan/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wedplan/features/auth/presentation/pages/login_page.dart';
import 'package:wedplan/features/weeding/presentation/pages/home_page.dart'; // <-- assume you have this

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().init();
  }

  void _navigateTo(Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => page));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.getUserStatus != current.getUserStatus,
      listener: (context, state) {
        if (state.getUserStatus == AppStatus.success) {
          final user = state.user;
          if (user == null) {
            _navigateTo(const LoginPage());
          } else {
            _navigateTo(const HomePage());
          }
        } else if (state.getUserStatus == AppStatus.failed) {
          _navigateTo(const LoginPage());
        }
      },
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: Center(
          child: Image.asset(AppAssets.logo, height: 400.h, width: 400.h),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wedplan/core/theme/theme.dart';
import 'package:wedplan/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wedplan/features/auth/presentation/pages/splash_page.dart';

import 'features/venue/presentation/cubit/venue_cubit.dart';
import 'features/weeding/presentation/cubit/wedding_cubit.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => VenueCubit()),
        BlocProvider(create: (_) => WeddingCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(411.42857142857144, 843.4285714285714),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: AppTheme.light,
            home: SplashPage(),
          );
        },
      ),
    );
  }
}

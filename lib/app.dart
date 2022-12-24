import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triathlon_tracker/core/app_theme.dart';
import 'package:triathlon_tracker/core/s.dart';
import 'package:triathlon_tracker/core/style.dart';
import 'package:triathlon_tracker/presentation/landing_screen.dart';
import 'package:triathlon_tracker/presentation/onboarding/onboarding_main_screen.dart';
import 'package:triathlon_tracker/state_holders/personal_info_state_holder/personal_info_state.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // StaticS.init(context);

    final themeColor = ref.watch(styleProvider).themeColor;
    final colors = ref.watch(styleProvider).colors;
    final locale = ref.watch(localeProvider);
    final isLogged = ref.read(personalInfoStateNotifierProvider).when(
          empty: () => false,
          data: (goals, profile) => true,
        );

    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          theme: AppTheme.theme(themeColor, colors),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.supportedLocales,
          locale: locale,
          home: isLogged ? const LandingScreen() : const OnBoardingMainScreen(),
        );
      },
    );
  }
}

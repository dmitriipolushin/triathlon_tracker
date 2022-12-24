import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_test/hive_test.dart';
import 'package:triathlon_tracker/core/s.dart';
import 'package:triathlon_tracker/data/goals_local_storage.dart';
import 'package:triathlon_tracker/data/profile_local_storage.dart';
import 'package:triathlon_tracker/data/trainings_local_storage.dart';
import 'package:triathlon_tracker/domain/goals.dart';
import 'package:triathlon_tracker/domain/profile.dart';
import 'package:triathlon_tracker/domain/training.dart';
import 'package:triathlon_tracker/managers/personal_info_manager.dart';
import 'package:triathlon_tracker/managers/trainings.manager.dart';
import 'package:triathlon_tracker/presentation/home_screen.dart';
import 'package:triathlon_tracker/presentation/onboarding/custom_button.dart';
import 'package:triathlon_tracker/presentation/onboarding/onboarding_main_screen.dart';

void main() {
  group('Onbording', () {
    final container = ProviderContainer();
    setUp(() async {
      await setUpTestHive();
      Hive.resetAdapters();
      Hive.registerAdapter(GoalsAdapter());
      Hive.registerAdapter(TrainingAdapter());
      Hive.registerAdapter(TrainingTypeAdapter());
      Hive.registerAdapter(ProfileAdapter());
      await container.read(profileLocalStorageProvider).init();
      await container.read(goalsLocalStorageProvider).init();
      await container.read(trainingsLocalStorageProvider).init();
      container.read(personalInfoManagerProvider).init();
      container.read(trainingsManagerProvider).init();
    });
    testWidgets("Onbording1 screen", (WidgetTester tester) async {
      final name = find.byType(TextField);

      await tester.pumpWidget(
        MaterialApp(
          home: const OnBoardingMainScreen(),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.supportedLocales,
          locale: const Locale('en'),
        ),
      );
      await tester.enterText(name, 'eldar');
      expect(find.text('eldar'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
      expect(
        find.text("We are glad you joined us! Let's get acquainted"),
        findsOneWidget,
      );
      expect(find.text("Your name is"), findsOneWidget);
    });
    testWidgets("Checking Onboarding 2 and returning to onbording1", (
      WidgetTester tester,
    ) async {
      final name = find.byType(TextField);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: const OnBoardingMainScreen(),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.supportedLocales,
            locale: const Locale('en'),
          ),
        ),
      );
      await tester.enterText(name, 'eldar');
      await tester.runAsync(() => tester.tap(find.byType(CustomButton)));
      await tester.pump();
      await tester.ensureVisible(find.byKey(const ValueKey('arrow_back')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('arrow_back')));
      await tester.pumpAndSettle();
      expect(find.text('eldar'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
    });
    tearDown(() async {
      await tearDownTestHive();
    });
  });

  group('Landing', () {
    final container = ProviderContainer();
    setUp(() async {
      await setUpTestHive();
      Hive.resetAdapters();
      Hive.registerAdapter(GoalsAdapter());
      Hive.registerAdapter(TrainingAdapter());
      Hive.registerAdapter(TrainingTypeAdapter());
      Hive.registerAdapter(ProfileAdapter());
      await container.read(profileLocalStorageProvider).init();
      await container.read(goalsLocalStorageProvider).init();
      await container.read(trainingsLocalStorageProvider).init();
      container.read(personalInfoManagerProvider).init();
      container.read(trainingsManagerProvider).init();
    });
    testWidgets('HomeScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: ScreenUtilInit(
            designSize: const Size(414, 896),
            minTextAdapt: true,
            builder: (context, child) {
              return MaterialApp(
                home: const OnBoardingMainScreen(),
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.supportedLocales,
                locale: const Locale('en'),
              );
            },
            
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'eldar');
      await tester.runAsync(() => tester.tap(find.byType(CustomButton)));
      await tester.pump();
      await tester.runAsync(() => tester.tap(find.byType(CustomButton)));
      await tester.pumpAndSettle();
      expect(find.text('Welcome, eldar'), findsOneWidget);
      expect(find.text('0.0/40.0'), findsOneWidget);
      await tester.runAsync(() async {
        await tester.tap(find.text('Swimming'));
        await tester.pump();
        expect(find.text('Enter tour training'), findsOneWidget);
        expect(find.text('0.0 km'), findsOneWidget);
        await tester.enterText(find.byType(TextField), '12');
        await tester.pump(const Duration(milliseconds: 200));
        await tester.tap(find.byType(AppButton));
      });
      await tester.pump();
      expect(find.text('12.0/40.0'), findsOneWidget);
    });

    testWidgets('Checking data tracking', (WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: ScreenUtilInit(
            designSize: const Size(414, 896),
            minTextAdapt: true,
            builder: (context, child) {
              return MaterialApp(
                home: const OnBoardingMainScreen(),
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.supportedLocales,
                locale: const Locale('en'),
              );
            },
            
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'eldar');
      await tester.runAsync(() => tester.tap(find.byType(CustomButton)));
      await tester.pump();
      await tester.runAsync(() => tester.tap(find.byType(CustomButton)));
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        await tester.tap(find.text('Swimming'));
        await tester.pump();
        expect(find.text('Enter tour training'), findsOneWidget);
        expect(find.text('0.0 km'), findsOneWidget);
        await tester.enterText(find.byType(TextField), '12');
        await tester.pump(const Duration(milliseconds: 200));
        await tester.tap(find.byType(AppButton));
      });
      await tester.pump();
      expect(find.text('12.0/40.0'), findsOneWidget);
    });
    testWidgets('StatisticsScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: ScreenUtilInit(
            designSize: const Size(414, 896),
            minTextAdapt: true,
            builder: (context, child) {
              return MaterialApp(
                home: const OnBoardingMainScreen(),
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.supportedLocales,
                locale: const Locale('en'),
              );
            },
            
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'eldar');
      await tester.runAsync(() => tester.tap(find.byType(CustomButton)));
      await tester.pump();
      await tester.runAsync(() => tester.tap(find.byType(CustomButton)));
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        await tester.tap(find.text('Swimming'));
        await tester.pump();
        await tester.enterText(find.byType(TextField), '24');
        await tester.pump(const Duration(milliseconds: 200));
        await tester.tap(find.byType(AppButton));
      });
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('stats_tab_icon')));
      await tester.pump();
      expect(find.text('Day'), findsOneWidget);
      expect(find.text('Week'), findsOneWidget);
      expect(find.text('Month'), findsOneWidget);
      expect(find.text('Swimming'), findsOneWidget);
      await tester.ensureVisible(find.byType(LineChart));
    });
    tearDown(() async {
      await tearDownTestHive();
    });
  });
}

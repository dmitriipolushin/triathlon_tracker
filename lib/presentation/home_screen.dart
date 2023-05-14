import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:triathlon_tracker/core/s.dart';
import 'package:triathlon_tracker/domain/training.dart';
import 'package:triathlon_tracker/managers/trainings.manager.dart';
import 'package:triathlon_tracker/presentation/landing_screen.dart';
import 'package:triathlon_tracker/presentation/settings_screen.dart';
import 'package:triathlon_tracker/state_holders/personal_info_state_holder/personal_info_state.dart';
import 'package:triathlon_tracker/state_holders/trainings_state_holder/trainings_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(personalInfoStateNotifierProvider).maybeMap(
          orElse: () => "Lee",
          data: (value) => value.profile.name,
        );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset('assets/icons/user.svg'),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFE0F0FF),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            HeaderBar(name: name),
            const SizedBox(height: 48),
            const TrainingsIndicator(
              sportType: TrainingType.swimming,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: TrainingsIndicator(
                sportType: TrainingType.running,
              ),
            ),
            const TrainingsIndicator(
              sportType: TrainingType.cycling,
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  final String name;
  const HeaderBar({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${S.of(context).welcome}, $name',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF40445C),
          ),
        ),
        Image.asset(
          'assets/images/waving_hand.png',
          scale: 3,
        ),
      ],
    );
  }
}

class GoalIndicator extends StatelessWidget {
  final double progress;
  const GoalIndicator({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
              ),
            ),
            AnimatedContainer(
              width: (MediaQuery.of(context).size.width - 32) * progress,
              duration: const Duration(milliseconds: 300),
              height: 8,
              curve: Curves.easeIn,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color(0xFF4A4999),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TrainingsIndicator extends ConsumerWidget {
  final TrainingType sportType;
  const TrainingsIndicator({
    super.key,
    required this.sportType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentProgress = ref
        .watch(trainingsStateNotifierProvider)
        .byTrainingsType(sportType)
        .fold(
          0.0,
          (previousValue, element) => previousValue += element.distance,
        );
    final goal = ref.watch(personalInfoStateNotifierProvider).maybeWhen(
          orElse: () => 0,
          data: (goals, profile) => goals.byTrainingtype(sportType),
        );

    return GestureDetector(
      onTap: () {
        showValueWindow(
          context,
          title: S.of(context).enter_training,
          hintText: '$currentProgress',
        ).then((value) {
          if (value != null) {
            ref.read(trainingsManagerProvider).addTraining(
                  sportType,
                  Training(
                    distance: double.parse(value),
                    dateTime: DateTime.now().toString(),
                  ),
                );
          }
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sportType.getString(context),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '$currentProgress/$goal',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  S.of(context).log,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A6680),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.add_rounded,
                  color: Color(0xFF4A6680),
                  size: 18,
                ),
                const SizedBox(width: 4),
              ],
            ),
            const SizedBox(height: 11),
            GoalIndicator(
              progress: _format(currentProgress / goal),
            )
          ],
        ),
      ),
    );
  }
}

double _format(double value) {
  if (value > 1.0) {
    return 1.0;
  } else {
    return value;
  }
}

Future<String?> showValueWindow(
  BuildContext context, {
  required String title,
  required String hintText,
}) {
  final TextEditingController valueController = TextEditingController();
  return showModalBottomSheet(
    context: globalContext!,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (_) {
      return IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                width: 70,
                height: 5,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  color: Color(0xFFD6D7E4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 24,
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF40445C),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextFormField(
                controller: valueController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF40445C),
                ),
                cursorColor: const Color(0xFF4A4999),
                decoration: InputDecoration(
                  isDense: false,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  hintText: '$hintText ${S.of(context).km}',
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF40445C),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Color(0xFF4A4999),
                      width: 2,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Color(0xFFD6D7E4)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 30,
                ),
                child: AppButton(
                  onPressed: () {
                    if (valueController.text.isEmpty) {
                      Navigator.of(globalContext!).pop(hintText);
                    } else {
                      Navigator.of(globalContext!).pop(
                        valueController.text,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class AppButton extends StatelessWidget {
  final Function() onPressed;
  const AppButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF4A4999),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Text(
            S.of(context).save,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

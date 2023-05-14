import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triathlon_tracker/domain/goals.dart';
import 'package:triathlon_tracker/domain/profile.dart';
import 'package:triathlon_tracker/domain/training.dart';
import 'package:triathlon_tracker/managers/personal_info_manager.dart';
import 'package:triathlon_tracker/managers/trainings.manager.dart';
import 'package:triathlon_tracker/presentation/home_screen.dart';
import 'package:triathlon_tracker/presentation/onboarding/custom_text_form.dart';
import 'package:triathlon_tracker/state_holders/personal_info_state_holder/personal_info_notifier.dart';
import 'package:triathlon_tracker/state_holders/personal_info_state_holder/personal_info_state.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String? _name;
  double? _chosenSwimmingGoal;
  double? _chosenCyclingGoal;
  double? _chosenRunningGoal;

  @override
  Widget build(BuildContext context) {
    final swimmingGoal = ref.watch(personalInfoStateNotifierProvider).maybeWhen(
          orElse: () => 0,
          data: (goals, profile) => goals.byTrainingtype(TrainingType.swimming),
        ) as double;
    final cyclingGoal = ref.watch(personalInfoStateNotifierProvider).maybeWhen(
          orElse: () => 0,
          data: (goals, profile) => goals.byTrainingtype(TrainingType.cycling),
        ) as double;
    final runningGoal = ref.watch(personalInfoStateNotifierProvider).maybeWhen(
          orElse: () => 0,
          data: (goals, profile) => goals.byTrainingtype(TrainingType.running),
        ) as double;
    _chosenSwimmingGoal = _chosenSwimmingGoal ?? swimmingGoal;
    _chosenCyclingGoal = _chosenCyclingGoal ?? cyclingGoal;
    _chosenRunningGoal = _chosenRunningGoal ?? runningGoal;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Profile settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF40445C),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.clear_rounded,
              color: Color(0xFF40445C),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditNameField(
                nameChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const FriendCode(),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFFD6D7E4),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showValueWindow(
                    context,
                    title: 'Enter your goal',
                    hintText: '$_chosenSwimmingGoal',
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        _chosenSwimmingGoal = double.parse(value);
                      });
                    }
                  });
                },
                child: GoalItem(
                  title: 'Swimming',
                  goal: _chosenSwimmingGoal!,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showValueWindow(
                    context,
                    title: 'Enter your goal',
                    hintText: '$_chosenCyclingGoal',
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        _chosenCyclingGoal = double.parse(value);
                      });
                    }
                  });
                },
                child: GoalItem(
                  title: 'Cycling',
                  goal: _chosenCyclingGoal!,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showValueWindow(
                    context,
                    title: 'Enter your goal',
                    hintText: '$_chosenRunningGoal',
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        _chosenRunningGoal = double.parse(value);
                      });
                    }
                  });
                },
                child: GoalItem(
                  title: 'Running',
                  goal: _chosenRunningGoal!,
                ),
              ),
              const Spacer(),
              AppButton(onPressed: saveGoals),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  saveGoals() {
    ref.read(personalInfoManagerProvider).setNewPersonalData(
          profile: _name != null ? Profile(name: _name!) : null,
          goals: Goals(
            swimming: _chosenSwimmingGoal!,
            cycling: _chosenCyclingGoal!,
            running: _chosenRunningGoal!,
          ),
        );
    Navigator.of(context).pop();
  }
}

class EditNameField extends ConsumerStatefulWidget {
  final ValueChanged<String> nameChanged;
  const EditNameField({
    super.key,
    required this.nameChanged,
  });

  @override
  ConsumerState<EditNameField> createState() => _EditNameFieldState();
}

class _EditNameFieldState extends ConsumerState<EditNameField> {
  final TextEditingController _nameController = TextEditingController();

  bool _inited = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameController.addListener(() {
        widget.nameChanged(_nameController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_inited) {
      final name = ref.watch(personalInfoStateNotifierProvider).maybeMap(
            orElse: () => "Lee",
            data: (value) => value.profile.name,
          );
      _nameController.text = name;
      _inited = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 24, bottom: 8),
          child: Text(
            'Name',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Color(0xFF40445C),
            ),
          ),
        ),
        CustomTextForm(
          controller: _nameController,
          hintText: 'enter your name here',
        ),
      ],
    );
  }
}

class FriendCode extends StatelessWidget {
  const FriendCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Your Friend code',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF40445C),
          ),
        ),
        SizedBox(height: 20),
        Text(
          '123456',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF4A4999),
          ),
        ),
      ],
    );
  }
}

class GoalItem extends StatelessWidget {
  final String title;
  final double goal;
  const GoalItem({
    super.key,
    required this.title,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF40445C),
                ),
              ),
              const Spacer(),
              Text(
                '$goal',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4A4999),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 1,
            color: const Color(0xFFD6D7E4),
          ),
        ],
      ),
    );
  }
}

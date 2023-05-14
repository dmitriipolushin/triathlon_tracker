import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triathlon_tracker/constants.dart';
import 'package:triathlon_tracker/presentation/home_screen.dart';
import 'package:triathlon_tracker/presentation/landing_screen.dart';

class User {
  final String name;
  final double swimming;
  final double cycling;
  final double running;

  const User({
    required this.name,
    required this.swimming,
    required this.cycling,
    required this.running,
  });
}

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final List<User> _friends = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _friends.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          return GestureDetector(
            onTap: () {
              showAddFriendDialog(
                context,
              ).then((value) {
                setState(() {
                  _friends.add(
                    const User(
                      name: 'Dmitrii Polushin',
                      swimming: 20,
                      cycling: 90.5,
                      running: 30,
                    ),
                  );
                });
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Add new Friend',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A6680),
                  ),
                ),
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 40),
          child: FriendCard(
            friend: _friends[i - 1],
          ),
        );
      },
    );
  }
}

class FriendCard extends StatelessWidget {
  final User friend;
  const FriendCard({
    super.key,
    required this.friend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 30,
      ),
      child: Row(
        children: [
          Text(
            friend.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          _resultWithIcon(
            'assets/icons/swimming.svg',
            friend.swimming,
            6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: _resultWithIcon(
              'assets/icons/cycling.svg',
              friend.cycling,
              6,
            ),
          ),
          _resultWithIcon(
            'assets/icons/running.svg',
            friend.running,
            0,
          ),
        ],
      ),
    );
  }

  Widget _resultWithIcon(String iconPath, double result, double padding) {
    return Container(
      color: Colors.transparent,
      height: 43 + padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath),
          SizedBox(height: padding),
          Text(
            '$result',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

Future<String?> showAddFriendDialog(BuildContext context) {
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
              const Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 24,
                ),
                child: Text(
                  'Enter your Friend code',
                  style: TextStyle(
                    color: Color(0xFF40445C),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Text(
                'To add Friend in you list you need to ask him his code. Enter this code in the field below, and you will see your friend results.',
                style: TextStyle(
                  color: Color(0xFF7E8298),
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
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
                decoration: const InputDecoration(
                  isDense: false,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  hintText: 'Your friend code',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF40445C),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Color(0xFF4A4999),
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
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
                    Navigator.of(globalContext!).pop(
                      valueController.text,
                    );
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

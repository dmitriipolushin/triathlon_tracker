import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triathlon_tracker/constants.dart';
import 'package:triathlon_tracker/presentation/profile/friends_screen.dart';
import 'package:triathlon_tracker/presentation/profile/news_screen.dart';

enum ScreenType {
  news('News'),
  friends('Friends');

  final String title;
  const ScreenType(this.title);
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  ScreenType _screenType = ScreenType.news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F0FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Social',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF40445C),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/images/sparkles.png',
                    scale: 3,
                  ),
                ],
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl(
                  children: {
                    ScreenType.news: Text(
                      ScreenType.news.title,
                      style: AppStyles.heading13.copyWith(
                        color: _screenType == ScreenType.news
                            ? Colors.white
                            : const Color(0xFF7E8298),
                      ),
                    ),
                    ScreenType.friends: Text(
                      ScreenType.friends.title,
                      style: AppStyles.heading13.copyWith(
                        color: _screenType == ScreenType.friends
                            ? Colors.white
                            : const Color(0xFF7E8298),
                      ),
                    ),
                  },
                  groupValue: _screenType,
                  thumbColor: AppColors.primaryColor,
                  backgroundColor: const Color.fromRGBO(255, 83, 94, 0.04),
                  onValueChanged: (ScreenType? val) {
                    if (val != null) {
                      setState(
                        () {
                          _screenType = val;
                        },
                      );
                      if (_screenType == ScreenType.news) {
                        _tabController.animateTo(0);
                      } else {
                        _tabController.animateTo(1);
                      }
                    }
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    NewScreen(),
                    FriendsScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

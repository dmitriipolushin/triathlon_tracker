import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triathlon_tracker/presentation/home_screen.dart';
import 'package:triathlon_tracker/presentation/statistics_screen.dart';

BuildContext? globalContext;

class LandingScreen extends StatefulWidget {
  static const kHomeScreen = '/home_screen';
  static const kStatisticsScreen = '/statistics_screen';
  const LandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final navigatorKey = GlobalKey<NavigatorState>();
  var _index = 0;
  final routeNames = {
    0: LandingScreen.kHomeScreen,
    1: LandingScreen.kStatisticsScreen,
  };
  final navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          setState(() => _index = index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF707880),
        unselectedItemColor: const Color(0xFFD6D7E4),
        items: [
          BottomNavigationBarItem(
            label: '',
            tooltip: '',
            icon: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/home.svg',
                    height: 24,
                    color: _index == 0
                        ? const Color(0xFF707880)
                        : const Color(0xFFD6D7E4),
                  ),
                ],
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            tooltip: '',
            icon: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/stats.svg',
                    height: 24,
                    color: _index == 1
                        ? const Color(0xFF707880)
                        : const Color(0xFFD6D7E4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
          ],
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(final int index) {
    return Offstage(
      offstage: _index != index,
      child: TabNavigator(
        navigatorKey: navigatorKeys[index],
        routeName: routeNames[index],
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? routeName;
  const TabNavigator({
    Key? key,
    this.navigatorKey,
    this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeName!]!(context),
        );
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      LandingScreen.kHomeScreen: (context) => const HomeScreen(),
      LandingScreen.kStatisticsScreen: (context) => const StatisticsScreen(),
    };
  }
}

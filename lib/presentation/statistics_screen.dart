import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triathlon_tracker/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'package:triathlon_tracker/state_holders/statistics_bloc.dart';
import 'package:triathlon_tracker/state_holders/trainings_state_holder/trainings_notifier.dart';

class Unit {
  final double amount;
  final String time;

  Unit({
    required this.amount,
    required this.time,
  });
}

class StatisticsScreen extends ConsumerStatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  StatisticsPeriod _chosenPeriod = StatisticsPeriod.day;
  final _statisticsBloc = StatisticsBloc();
  List<Unit> _swimmingData = [];
  List<Unit> _cyclingData = [];
  List<Unit> _runningData = [];

  @override
  Widget build(BuildContext context) {
    _swimmingData = ref.watch(trainingsStateNotifierProvider).swimming.map((e) {
      return Unit(amount: e.distance, time: e.dateTime.toString());
    }).toList();
    _cyclingData = ref.watch(trainingsStateNotifierProvider).cycling.map((e) {
      return Unit(amount: e.distance, time: e.dateTime.toString());
    }).toList();
    _runningData = ref.watch(trainingsStateNotifierProvider).running.map((e) {
      return Unit(amount: e.distance, time: e.dateTime.toString());
    }).toList();
    return BlocProvider(
      create: (context) => _statisticsBloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xFFE0F0FF),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoSlidingSegmentedControl(
                          children: {
                            StatisticsPeriod.day: Text(
                              'Day',
                              style: AppStyles.heading13.copyWith(
                                color: _chosenPeriod == StatisticsPeriod.day
                                    ? Colors.white
                                    : const Color(0xFF7E8298),
                              ),
                            ),
                            StatisticsPeriod.week: Text(
                              'Week',
                              style: AppStyles.heading13.copyWith(
                                color: _chosenPeriod == StatisticsPeriod.week
                                    ? Colors.white
                                    : const Color(0xFF7E8298),
                              ),
                            ),
                            StatisticsPeriod.month: Text(
                              'Month',
                              style: AppStyles.heading13.copyWith(
                                color: _chosenPeriod == StatisticsPeriod.month
                                    ? Colors.white
                                    : const Color(0xFF7E8298),
                              ),
                            )
                          },
                          groupValue: _chosenPeriod,
                          thumbColor: AppColors.primaryColor,
                          backgroundColor:
                              const Color.fromRGBO(255, 83, 94, 0.04),
                          onValueChanged: (StatisticsPeriod? val) {
                            if (val != null) {
                              BlocProvider.of<StatisticsBloc>(context).add(
                                StatisticsEvent(period: val, initData: true),
                              );
                              setState(
                                () {
                                  _chosenPeriod = val;
                                },
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        children: [
                          if (_swimmingData.isNotEmpty) ...[
                            UnitStatistics(
                              data: _swimmingData,
                              title: 'Swimming',
                            ),
                            const SizedBox(height: 24),
                          ],
                          if (_cyclingData.isNotEmpty) ...[
                            UnitStatistics(
                              data: _cyclingData,
                              title: 'Cycling',
                            ),
                            const SizedBox(height: 24),
                          ],
                          if (_runningData.isNotEmpty) ...[
                            UnitStatistics(
                              data: _runningData,
                              title: 'Running',
                            ),
                            const SizedBox(height: 24),
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class UnitStatistics extends StatefulWidget {
  final List<Unit> data;
  final String title;
  const UnitStatistics({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);
  @override
  State<UnitStatistics> createState() => _UnitStatisticsState();
}

class _UnitStatisticsState extends State<UnitStatistics>
    with TickerProviderStateMixin {
  List<Unit> _lastPeriodUnits = [];
  List<double> _uniqueValues = [];
  final List<FlSpot> _spots = [];
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];
  final List<double> _yAxis = [];

  double maxValue = 0;
  double minValue = 0;
  double _padding = 0;
  int _chosenItem = -1;
  int _previousItem = -1;
  double _currentDx = -1;
  double width = 20;
  StatisticsPeriod? _currentPeriod;
  double? _axisStep;

  initData(StatisticsPeriod period) {
    _currentPeriod = period;
    _lastPeriodUnits = widget.data;
    _uniqueValues =
        _lastPeriodUnits.map((e) => e.amount.toDouble()).toSet().toList();

    _controllers.clear();
    _animations.clear();
    _spots.clear();
    _yAxis.clear();
    _chosenItem = -1;
    _previousItem = -1;
    _currentDx = -1;

    for (int i = 0; i < _lastPeriodUnits.length; i++) {
      final AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      );
      final Animation<double> animation = CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      );
      _controllers.add(controller);
      _animations.add(animation);
    }

    final minValueOfList = _uniqueValues.reduce(min);
    final maxValueOfList = _uniqueValues.reduce(max);
    if (maxValueOfList == minValueOfList) {
      minValue = 0;
      maxValue = maxValueOfList;
    } else {
      _padding = (maxValueOfList - minValueOfList) / 18;
      minValue = minValueOfList - (maxValueOfList - minValueOfList) / 2;
      if (minValue < 0) {
        minValue = 0;
      }
      maxValue = maxValueOfList + _padding * 2;
    }

    for (int i = 0; i < _lastPeriodUnits.length; i++) {
      _spots.add(FlSpot(i.toDouble(), _lastPeriodUnits[i].amount));
      _yAxis.add(
        ((_lastPeriodUnits[i].amount - minValue) *
                (44 * 3 / (maxValue - minValue))) +
            43,
      );
    }
    if (_lastPeriodUnits.length > 1) {
      _axisStep = (MediaQuery.of(context).size.width - 93.6) /
          (_lastPeriodUnits.length - 1);
    } else {
      _axisStep = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, state) {
        if (state.initData) {
          initData(state.period);
        }
        return CardCover(
          child: Padding(
            padding: const EdgeInsets.all(10).copyWith(right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(widget.title, style: AppStyles.heading20),
                ),
                SizedBox(
                  height: 206,
                  child: Stack(
                    children: <Widget>[
                          Positioned(
                            bottom: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 76,
                              margin: EdgeInsets.only(
                                left: _currentPeriod == StatisticsPeriod.month
                                    ? 27
                                    : 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children:
                                    List.generate(_lastPeriodUnits.length, (i) {
                                  if (_currentPeriod == StatisticsPeriod.week) {
                                    final day = DateFormat('MMMd').format(
                                      DateTime.parse(
                                        _lastPeriodUnits[i].time,
                                      ),
                                    );
                                    return Text(
                                      day,
                                      style: AppStyles.subtitle12
                                          .copyWith(fontSize: 11.sp),
                                    );
                                  } else if (_currentPeriod ==
                                      StatisticsPeriod.month) {
                                    final condition =
                                        _lastPeriodUnits.length > 6 &&
                                                _lastPeriodUnits.length < 19
                                            ? i % 3 == 0
                                            : _lastPeriodUnits.length >= 19
                                                ? i % 5 == 0
                                                : true;
                                    if (condition) {
                                      final day = DateFormat('d').format(
                                        DateTime.parse(
                                          _lastPeriodUnits[i].time,
                                        ),
                                      );
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right:
                                              i == _lastPeriodUnits.length - 1
                                                  ? 12
                                                  : 0,
                                        ),
                                        child: Text(
                                          day,
                                          style: AppStyles.subtitle12
                                              .copyWith(fontSize: 11.sp),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    final time = DateFormat('kk:mm').format(
                                      DateTime.parse(
                                        _lastPeriodUnits[i].time,
                                      ),
                                    );
                                    final condition =
                                        _lastPeriodUnits.length > 7
                                            ? i % 3 == 0
                                            : true;
                                    return condition
                                        ? Text(
                                            time,
                                            style: AppStyles.subtitle12
                                                .copyWith(fontSize: 11.sp),
                                          )
                                        : Container();
                                  }
                                }).toList(),
                              ),
                              //color: Colors.greenAccent,
                            ),
                          ),
                          Container(
                            height: 161,
                            margin: const EdgeInsets.only(top: 45),
                            child: LineChart(
                              mainData(),
                              swapAnimationDuration:
                                  const Duration(milliseconds: 300),
                            ),
                          ),
                        ] +
                        List.generate(_lastPeriodUnits.length, (index) => index)
                            .map(
                          (i) {
                            var left = _axisStep! * i - 6.72.w;
                            final border =
                                MediaQuery.of(context).size.width - 124;
                            var tailPadding = 0.0;
                            if (left > border) {
                              tailPadding = left - border;
                              left = border;
                            }
                            return Positioned(
                              bottom: _yAxis[i],
                              left: left,
                              child: ScaleTransition(
                                scale: _animations[i],
                                child: TooltipWidget(
                                  title:
                                      '${_lastPeriodUnits[i].amount.round()} bpm',
                                  tailPadding: tailPadding,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final interval = (maxValue - minValue) / 3;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10.0,
      child: value != maxValue + (interval < 1 ? 0.01 : 0.1) &&
              value != minValue - (interval < 1 ? 0.01 : 0.1)
          ? Text(
              '${value.toInt()}',
              style: AppStyles.subtitle12.copyWith(fontSize: 11.sp),
            )
          : Container(),
    );
  }

  LineChartData mainData() {
    final interval = (maxValue - minValue) / 3;
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
        touchCallback: (event, res) async {
          if (event is FlTapDownEvent && res?.lineBarSpots != null) {
            _chosenItem = res!.lineBarSpots!.last.spotIndex;
            _currentDx = res.lineBarSpots!.last.x;
            if (_chosenItem != _previousItem) {
              if (_previousItem != -1) {
                _controllers[_previousItem].reverse();
              }
              _controllers[_chosenItem].forward();
              _previousItem = _chosenItem;
              BlocProvider.of<StatisticsBloc>(context).add(
                StatisticsEvent(
                  period: _currentPeriod ?? StatisticsPeriod.day,
                ),
              );
            } else {
              _controllers[_chosenItem].reverse();
              _chosenItem = -1;
              _previousItem = -1;
              _currentDx = -1;
              BlocProvider.of<StatisticsBloc>(context).add(
                StatisticsEvent(
                  period: _currentPeriod ?? StatisticsPeriod.day,
                ),
              );
            }
          }
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
        ),
      ),
      gridData: FlGridData(
        drawHorizontalLine: true,
        horizontalInterval: interval,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xFFD6D7E4),
            strokeWidth: 1,
            dashArray: [2, 4],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            strokeWidth: 0,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 10,
            getTitlesWidget: (val, meta) => Container(),
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            interval: 1,
            getTitlesWidget: (val, meta) => Container(), //bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: interval,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 28,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      // minX: 0,
      // maxX: 21,
      minY: minValue - (interval < 1 ? 0.01 : 0.1),
      maxY: maxValue + (interval < 1 ? 0.01 : 0.1),
      baselineY: minValue - interval,
      //maxX: (3 * _lastPeriodUnits.length).toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: _spots,
          isCurved: true,
          preventCurveOverShooting: true,
          color: AppColors.primaryColor,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 3,
                color: Colors.white,
                strokeWidth: 3,
                strokeColor: const Color(0xFF4A4999),
              );
            },
            checkToShowDot: (spot, barData) {
              return spot.x == _currentDx;
            },
          ),
          shadow: Shadow(
            color: const Color(0xFFFF9CBA).withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ),
      ],
    );
  }
}

class CardCover extends StatelessWidget {
  final Widget child;
  const CardCover({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(4, 4),
          )
        ],
      ),
      child: child,
    );
  }
}

class TooltipWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double tailPadding;
  final double width;
  const TooltipWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.tailPadding = 0,
    this.width = 66,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: const Color(0xFFF2F3F4),
              width: 0.3,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(2.66, 2.66),
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: AppStyles.heading13),
                if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    style: AppStyles.subtitle12.copyWith(
                      fontSize: 11.sp,
                      color: const Color(0xFF9EA1B2),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: tailPadding * 2,
          bottom: 0,
          child: Transform.rotate(
            angle: pi / 4,
            child: Center(
              child: Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.only(top: 11, left: 11),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFFF2F3F4),
                      width: 0.3,
                    ),
                    right: BorderSide(
                      color: Color(0xFFF2F3F4),
                      width: 0.3,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(2.66, 2.66),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

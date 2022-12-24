import 'package:flutter_bloc/flutter_bloc.dart';

enum StatisticsPeriod { day, week, month }

class StatisticsEvent {
  final StatisticsPeriod period;
  final bool initData;
  StatisticsEvent({
    required this.period,
    this.initData = false,
  });
}

class StatisticsState {
  final StatisticsPeriod period;
  final bool initData;
  StatisticsState({
    required this.period,
    this.initData = false,
  });
}

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc()
      : super(
          StatisticsState(
            period: StatisticsPeriod.day,
            initData: true,
          ),
        ) {
    on<StatisticsEvent>(
      (event, emit) => emit(
        StatisticsState(
          period: event.period,
          initData: event.initData,
        ),
      ),
    );
  }
}

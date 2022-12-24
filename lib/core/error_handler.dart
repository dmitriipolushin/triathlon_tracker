import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:triathlon_tracker/core/logger.dart';

class ErrorHandler {
  static void init() {
    FlutterError.onError = _recordFlutterError;
    logger.info('ErrorHandler initialized');
  }

  static void recordError(Object error, StackTrace stackTrace) {
    logger.severe(error);
    logger.severe(
      error.toString(),
      error,
      stackTrace,
    );

    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  }

  static void _recordFlutterError(FlutterErrorDetails error) {
    logger.severe(error.toStringShort(), error.exception, error.stack);
    FirebaseCrashlytics.instance.recordError(error, error.stack);
    if (kReleaseMode) exit(1);
  }

  const ErrorHandler._();
}

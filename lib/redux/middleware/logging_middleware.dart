import 'dart:async';

import 'package:core/core.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux/src/store.dart';

import 'dart:core';


class TfLoggingMiddleware<State> extends MiddlewareClass {
  TfLoggingMiddleware({
    TFLogger logger,
    MessageFormatter<State> formatter
  }){
    _formatter = formatter;
  }

  MessageFormatter<State> _formatter;

  final _streamController = StreamController.broadcast();

  factory TfLoggingMiddleware.writer({
    TFLogger logger,
    MessageFormatter<State> formatter = singleLineFormatter,
  }) {
    final middleware = TfLoggingMiddleware<State>(
      logger: logger,
      formatter: formatter,
    );

    middleware._streamController.stream.listen((log) {
      logger.logDebug(log.toString());
    });
    return middleware;
  }

  static String singleLineFormatter(
      dynamic state,
      dynamic action,
      DateTime timestamp,
      ) {
    return "{Action: $action, State: $state, ts: ${new DateTime.now()}}";
  }

  @override
  call(Store<dynamic> store, action, NextDispatcher next) {
    next(action);
    _streamController.add(_formatter(store.state, action, DateTime.now()));
  }
}

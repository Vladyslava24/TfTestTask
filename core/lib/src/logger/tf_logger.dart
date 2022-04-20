import 'dart:async';

import 'package:core/src/logger/log_writer.dart';
import 'package:logger/logger.dart';

class TFLogger {
  static const _appName = 'Totalfit';
  static final Logger _logger = Logger(output: _OutputCompositor([FileOutput(), ConsoleOutput()]));

  void logDebug<T>(String msg) {
    final detailedMessage = _getDetailedMessage(msg, Level.debug, T.toString());
    _logger.d(detailedMessage);
  }

  void logInfo<T>(String msg) {
    final detailedMessage = _getDetailedMessage(msg, Level.info, T.toString());
    _logger.i(detailedMessage);
  }

  void logWarning<T>(String msg) {
    final detailedMessage = _getDetailedMessage(msg, Level.warning, T.toString());
    _logger.w(detailedMessage);
  }

  void logError<T>(String msg) {
    final detailedMessage = _getDetailedMessage(msg, Level.error, T.toString());
    _logger.e(detailedMessage);
  }

  // generic logging method
  String _getDetailedMessage(
    String msg,
    Level level,
    String classType,
  ) {
    final dateTime = DateTime.now();
    final levelString = level.toString().split('.').last;
    final formattedTime = '${dateTime.hour.toString()}:${dateTime.minute.toString()}:${dateTime.second.toString()}';
    final contents = '[$_appName] [$formattedTime] [$classType] [$levelString] - $msg';
    return contents;
  }
}

class PSConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var element in event.lines) {
      print(element);
    }
  }
}

class FileOutput extends LogOutput {
  Future<LogWriter> writer = LogWriter.getInstance();
  late StreamController<List<String>> _controller;
  bool _shouldForward = false;

  @override
  void init() {
    _controller = StreamController<List<String>>.broadcast(
      onListen: () => _shouldForward = true,
      onCancel: () => _shouldForward = false,
    );
    writer.then((writer) {
      _controller.stream.listen((list) {
        for (var element in list) {
          writer.write(element);
        }
      });
    }).catchError((e) {
      //ignore
    });
    super.init();
  }

  @override
  void output(OutputEvent event) {
    if (!_shouldForward) {
      return;
    }

    _controller.add(event.lines);
  }

  @override
  void destroy() {
    _controller.close();
  }
}

class _OutputCompositor extends LogOutput {
  final List<LogOutput> _outputs;

  _OutputCompositor(this._outputs);

  @override
  void output(OutputEvent event) {
    for (var output in _outputs) {
      output.output(event);
    }
  }
}

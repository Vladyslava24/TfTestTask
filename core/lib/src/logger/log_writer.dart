import 'dart:async';
import 'dart:io';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_info/device_info.dart';

class LogWriter {
  final _lock = Lock();
  late File _logFile;

  static Completer<LogWriter>? _completer;

  static Future<LogWriter> getInstance() async {
    if (_completer == null) {
      _completer = Completer<LogWriter>();

      final _logFile = await _getLogFile();
      final stat = await _logFile.stat();
      if (stat.size == -1) {
        await _writeDeviceInfo(_logFile);
      }
      final header = '${DateTime.now()}: SESSION STARTED \n';
      await _logFile.writeAsString(header, mode: FileMode.append, flush: true);

      _completer!.complete(LogWriter._(_logFile));
    }
    return _completer!.future;
  }

  static Future _writeDeviceInfo(File logFile) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      await logFile.writeAsString('Device info ${info.model}, ${info.product}, ${info.manufacturer}, ${info.display}',
          mode: FileMode.append, flush: true);
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      await logFile.writeAsString('Device info ${info.model}, ${info.systemName},  ${info.systemVersion}',
          mode: FileMode.append, flush: true);
    }
  }

  LogWriter._(File logFile) {
    _logFile = logFile;
  }

  static Future<String> get _documentsPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _getLogFile() async {
    final documentPath = await _documentsPath;

    const localDirectory = 'logs';

    Directory targetDirectory = Directory('$documentPath/$localDirectory');
    if (!targetDirectory.existsSync()) {
      targetDirectory = await targetDirectory.create(recursive: true);
    }

    final info = await _getLogInfo(targetDirectory);
    if (info != null) {
      if (info.fileCount != null && info.fileCount! >= 10) {
        final deletedFilesCount = await _deleteLogFiles(targetDirectory);
        if (info.fileCount != null) {
          info.fileCount = info.fileCount! - deletedFilesCount;
          info.lastFileSize = null;
        }
      }
    }

    String fileName;
    if (info == null) {
      fileName = 'log_1';
    } else if (info.lastFileSize == null || info.lastFileSize! / 1024 < 500) {
      if (info.fileCount == null || info.fileCount == 0) {
        fileName = 'log_1';
      } else {
        fileName = 'log_${info.fileCount}';
      }
    } else {
      if (info.fileCount != null) {
        fileName = 'log_${info.fileCount! + 1}';
      } else {
        fileName = 'log_1';
      }
    }

    File file = File('${targetDirectory.path}/$fileName');

    return file;
  }

  static Future<LogInfo?> _getLogInfo(Directory directory) async {
    int fileCount = 0;
    int lastFileSize = 0;

    Completer<LogInfo> completer = Completer();
    if (directory.existsSync()) {
      directory.list(recursive: true, followLinks: false).listen((FileSystemEntity entity) async {
        if (entity.existsSync()) {
          fileCount++;
          final stat = await entity.stat();
          lastFileSize = stat.size;
        }
      }, onDone: () {
        completer.complete(LogInfo(fileCount: fileCount, lastFileSize: lastFileSize));
      }, onError: (e) {
        print("_lastLogFileSize $e");
        completer.complete(null);
      });
    }
    return completer.future;
  }

  static Future<int> _deleteLogFiles(Directory directory) async {
    int deletedCount = 0;

    Completer<int> completer = Completer();
    if (directory.existsSync()) {
      directory.list(recursive: true, followLinks: false).listen((FileSystemEntity entity) async {
        if (entity.existsSync()) {
          entity.deleteSync();
          deletedCount++;
        }
      }, onDone: () {
        completer.complete(deletedCount);
      }, onError: (e) {
        completer.complete(deletedCount);
      });
    }
    return completer.future;
  }

  Future write(String log) async {
    return _lock.synchronized(() async {
      await _logFile.writeAsString('$log\n', mode: FileMode.append, flush: true);
    });
  }
}

class LogInfo {
  int? fileCount;
  int? lastFileSize;

  LogInfo({@required this.fileCount, @required this.lastFileSize});
}

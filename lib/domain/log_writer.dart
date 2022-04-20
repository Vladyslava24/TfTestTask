import 'dart:async';
import 'dart:io';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_info/device_info.dart';
import 'package:core/core.dart';

class LogWriter {
  final _lock = Lock();
  File _logFile;

  static Completer<LogWriter> _completer;

  static Future<LogWriter> getInstance() async {
    if (_completer == null) {
      _completer = Completer<LogWriter>();

      final _logFile = await _getLogFile();
      final stat = await _logFile.stat();
      if (stat.size == -1) {
        await _writeDeviceInfo(_logFile);
      }
      final header = '${new DateTime.now()}: SESSION STARTED \n';
      await _logFile.writeAsString(header, mode: FileMode.append, flush: true);

      _completer.complete(LogWriter._(_logFile));
    }
    return _completer.future;
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

    final localDirectory = 'logs';

    Directory targetDirectory = Directory('$documentPath/$localDirectory');
    if (!targetDirectory.existsSync()) {
      targetDirectory = await targetDirectory.create(recursive: true);
    }

    final info = await _getLogInfo(targetDirectory);
    if (info == null) {
      return new File('${targetDirectory.path}/${'log_${DateTime.now()}'}');
    }

    String fileName;
    if (info.lastFileName == null) {
      fileName = 'log_${DateTime.now()}';

      ///check if need to append to existing file
    } else if (info.lastFileSize / 1024 < 500) {
      fileName = info.lastFileName;
    } else {
      fileName = 'log_${DateTime.now()}';
      if (info.fileCount >= 10) {
        await _deleteOldestFile(targetDirectory);
      }
    }

    File file = new File('${targetDirectory.path}/$fileName');

    return file;
  }

  static Future<LogInfo> _getLogInfo(Directory directory) async {
    int fileCount = 0;
    int lastFileSize = 0;
    String lastFileName;

    Completer<LogInfo> completer = Completer();
    if (directory.existsSync()) {
      directory.list(recursive: true, followLinks: false).listen((FileSystemEntity entity) async {
        if (entity.existsSync()) {
          fileCount++;
          final stat = await entity.stat();
          lastFileSize = stat.size;
          lastFileName = Uri.parse(entity.path).pathSegments.last;
        }
      }, onDone: () {
        completer.complete(LogInfo(fileCount: fileCount, lastFileSize: lastFileSize, lastFileName: lastFileName));
      }, onError: (e) {
        print("_lastLogFileSize $e");
        completer.complete(null);
      });
    }
    return completer.future;
  }

  static Future<void> _deleteOldestFile(Directory directory) async {
    FileSystemEntity oldest;
    Completer<void> completer = Completer();
    if (directory.existsSync()) {
      directory.list(recursive: true, followLinks: false).listen((FileSystemEntity entity) async {
        if (entity.existsSync()) {
          if (oldest == null) {
            oldest = entity;
          } else {
            final oldestLastModified = (await oldest.stat()).changed;
            final entityLastModified = (await entity.stat()).changed;
            if (entityLastModified.isBefore(oldestLastModified)) {
              oldest = entity;
            }
          }
        }
        if (oldest != null) {
          oldest.deleteSync();
        }
      }, onDone: () {
        completer.complete();
      }, onError: (e) {
        completer.completeError(e);
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
  int fileCount;
  int lastFileSize;
  String lastFileName;

  LogInfo({
    @required this.fileCount,
    @required this.lastFileSize,
    @required this.lastFileName,
  });
}

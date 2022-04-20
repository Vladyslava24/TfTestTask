import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:impl/src/download_workout/download_video_service/result.dart';
import 'package:impl/src/download_workout/download_video_service/utils.dart';
import 'package:path_provider/path_provider.dart';

class CacheTask {
  static const TAG = 'CacheTask';

  final String url;
  Isolate? _isolate;

  CacheTask({required this.url});

  Future<CacheResult> execute() async {
    try {
      final docPath = await documentsPath;
      Payload payload = Payload(url: url, documentsPath: docPath);

      final isolateToMainStream = await _initIsolate();
      String cachedFile = await _download(isolateToMainStream, payload);
      return SuccessResult(filePath: Uri.parse(cachedFile).pathSegments.last);
    } catch (e) {
      print("$TAG cacheTask: $url, error: ${e.toString()} ");
      return ErrorResult(e);
    }
  }

  Future<ReceivePort> _initIsolate() async {
    ReceivePort isolateToMainStream = ReceivePort();
    _isolate =
        await Isolate.spawn(downloadIsolate, isolateToMainStream.sendPort);
    return isolateToMainStream;
  }

  Future<String> _download(
      ReceivePort isolateToMainStream, Payload payload) async {
    Completer<String> completer = Completer<String>();

    isolateToMainStream.listen((data) {
      if (data is SendPort) {
        data.send(payload);
      } else {
        completer.complete(data);
      }
    });

    return completer.future;
  }

  void close() {
    if (_isolate != null) {
      _isolate?.kill(priority: Isolate.immediate);
    }
  }

  Future<String> get documentsPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }


}

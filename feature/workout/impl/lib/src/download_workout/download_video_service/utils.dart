import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:core/core.dart';
import 'package:workout_use_case/use_case.dart';
import 'package:http/http.dart' as http;

const URL_LOCAL_PATH_SEPARATOR = '#';
const VIDEO_DIRECTORY = 'video';

Future<File> loadFile(Payload payload, {required String localDirectory}) async {
  final name = Uri.parse(payload.url).pathSegments.last;

  Directory targetDirectory =
      Directory('${payload.documentsPath}/$localDirectory');
  if (!targetDirectory.existsSync()) {
    targetDirectory = await targetDirectory.create(recursive: true);
  }

  File file = File('${targetDirectory.path}/$name');
  if (await file.exists()) {
    return file;
  } else {
    print("downloading... ${payload.url}");
    return await downloadFile(
        "${payload.url}$URL_LOCAL_PATH_SEPARATOR${file.path}");
  }
}

void downloadIsolate(SendPort isolateToMainStream) {
  ReceivePort mainToIsolateStream = ReceivePort();
  isolateToMainStream.send(mainToIsolateStream.sendPort);

  mainToIsolateStream.listen((data) async {
    final file = await loadFile(data, localDirectory: VIDEO_DIRECTORY);
    isolateToMainStream.send(file.path);
  });
}

class Payload {
  final String url;
  final String? documentsPath;

  Payload({required this.url, this.documentsPath});
}

Set<String> getUniqueExercises(WorkoutModel workout) {
  Set<String> uniqueExercises = {};
  for (var stage in workout.stages) {
    for (var exercise in stage.exercises) {
      uniqueExercises.add(exercise.videoVertical);
    }
  }
  return uniqueExercises;
}

Future<File> downloadFile(String urlWithLocalPath) async {
  final url = urlWithLocalPath.substring(0, urlWithLocalPath.indexOf(URL_LOCAL_PATH_SEPARATOR));
  final localPath = urlWithLocalPath.substring(urlWithLocalPath.indexOf(URL_LOCAL_PATH_SEPARATOR) + 1);
  http.Response response;
  try {
    response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final localFile = File('$localPath');
      final writtenFile = await localFile.writeAsBytes(response.bodyBytes);
      return writtenFile;
    } else {
      final stringResponse = utf8.decode(response.bodyBytes);
      final serverErrorMessage = json.decode(stringResponse);
      throw ApiException.fromErrorBody(serverErrorMessage);
    }
  } catch (e) {
    print("$e");
    rethrow;
  }
}

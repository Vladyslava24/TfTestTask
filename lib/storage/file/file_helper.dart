import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

const URL_LOCAL_PATH_SEPARATOR = '#';
const VIDEO_DIRECTORY = 'video';

Future<String> get documentsPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> downloadProfileImage(String url) async {
  final String localPath = await documentsPath;

  http.Response response;
  try {
    response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final localFile = File('$localPath/profile_photo.png');
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

// Future<File> downloadFile(String urlWithLocalPath) async {
//   final url = urlWithLocalPath.substring(0, urlWithLocalPath.indexOf(URL_LOCAL_PATH_SEPARATOR));
//   final localPath = urlWithLocalPath.substring(urlWithLocalPath.indexOf(URL_LOCAL_PATH_SEPARATOR) + 1);
//   http.Response response;
//   try {
//     response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final localFile = File('$localPath');
//       final writtenFile = await localFile.writeAsBytes(response.bodyBytes);
//       return writtenFile;
//     } else {
//       final stringResponse = utf8.decode(response.bodyBytes);
//       final serverErrorMessage = json.decode(stringResponse);
//       throw ApiException.fromErrorBody(serverErrorMessage);
//     }
//   } catch (e) {
//     print("$e");
//     rethrow;
//   }
// }

Future<File> saveToAssets(String url) async {
  final response = await http.get(Uri.parse(url));
  final name = Uri.parse(url).pathSegments.last;
  String dir = (await getApplicationDocumentsDirectory()).path;
  return await new File('$dir/$name').writeAsBytes(response.bodyBytes);
}

Future<File> saveImageToAssets(File file) async {
  final dir = await getApplicationDocumentsDirectory();
  final path = dir.path;
  final fileName = Uri.parse(file.path).pathSegments.last;
  final File localImage = await file.copy('$path/$fileName');
  return localImage;
}

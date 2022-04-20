import 'dart:async';
import 'dart:convert';
import 'package:force_upgrade_data/src/repository/upgrade_repository.dart';
import 'package:version/version.dart';
import 'package:http/http.dart' as http;

class IosUpgradeRepository implements UpgradeRepository {
// iTunes Search API documentation URL
  final String iTunesDocumentationURL =
      'https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/';

  /// iTunes Lookup API URL
  final String lookupPrefixURL = 'https://itunes.apple.com/lookup';

  /// iTunes Search API URL
  final String searchPrefixURL = 'https://itunes.apple.com/search';

  /// Provide an HTTP Client that can be replaced for mock testing.
  http.Client? client = http.Client();

  bool debugEnabled = false;

  @override
  Future<StoreResponse> checkForUpgrade(String bundleId,
      {bool useCacheBuster = true}) async {
    final url = lookupURLByBundleId(bundleId, useCacheBuster: useCacheBuster)!;
    if (debugEnabled) {
      print('IosUpgradeRepository: download: $url');
    }
    try {
      final response = await client!.get(Uri.parse(url));
      if (debugEnabled) {
        print(
            'IosUpgradeRepository: response statusCode: ${response.statusCode}');
      }
      final decodedResults = _decodeResults(response.body);
      if (decodedResults != null) {
        final storeVersion = ITunesResults.version(decodedResults);
        final storeListingURL = ITunesResults.trackViewUrl(decodedResults);
        final releaseNotes = ITunesResults.releaseNotes(decodedResults);
        final mav = ITunesResults.minAppVersion(decodedResults);
        return StoreResponse(
            storeVersion: Version.parse(storeVersion),
            storeListingUrl: storeListingURL,
            releaseNotes: releaseNotes,
            mav: mav);
      } else {
        throw 'IosUpgradeRepository. checkForUpgrade: No response from Store';
      }
    } catch (e) {
      print('IosUpgradeRepository: checkForUpgrade error: $e');
      rethrow;
    }
  }

  Future<Map?> lookupById(String id, {bool useCacheBuster = true}) async {
    if (id.isEmpty) {
      return null;
    }
    final url = lookupURLById(id, useCacheBuster: useCacheBuster)!;
    final response = await client!.get(Uri.parse(url));
    final decodedResults = _decodeResults(response.body);
    return decodedResults;
  }

  String? lookupURLByBundleId(String bundleId, {bool useCacheBuster = true}) {
    if (bundleId.isEmpty) {
      return null;
    }
    return lookupURLByQSP({
      'bundleId': bundleId,
    }, useCacheBuster: useCacheBuster);
  }

  String? lookupURLById(String id, {bool useCacheBuster = true}) {
    if (id.isEmpty) {
      return null;
    }
    return lookupURLByQSP({'id': id}, useCacheBuster: useCacheBuster);
  }

  /// Look up URL by QSP.
  String? lookupURLByQSP(Map<String, String?> qsp,
      {bool useCacheBuster = true}) {
    if (qsp.isEmpty) {
      return null;
    }
    final parameters = <String>[];
    qsp.forEach((key, value) => parameters.add('$key=$value'));
    if (useCacheBuster) {
      parameters.add('_cb=${DateTime.now().microsecondsSinceEpoch.toString()}');
    }
    final finalParameters = parameters.join('&');
    return '$lookupPrefixURL?$finalParameters';
  }

  Map? _decodeResults(String jsonResponse) {
    if (jsonResponse.isNotEmpty) {
      final decodedResults = json.decode(jsonResponse);
      if (decodedResults is Map) {
        final resultCount = decodedResults['resultCount'];
        if (resultCount == 0) {
          if (debugEnabled) {
            print(
                'IosUpgradeRepository.ITunesSearchAPI: results are empty: $decodedResults');
          }
        }
        return decodedResults;
      }
    }
    return null;
  }
}

class ITunesResults {
  /// Return field bundleId from iTunes results.
  static String? bundleId(Map response) {
    String? value;
    try {
      value = response['results'][0]['bundleId'];
    } catch (e) {
      print('IosUpgradeRepository.ITunesResults.bundleId: $e');
    }
    return value;
  }

  /// Return field currency from iTunes results.
  static String? currency(Map response) {
    String? value;
    try {
      value = response['results'][0]['currency'];
    } catch (e) {
      print('IosUpgradeRepository.ITunesResults.currency: $e');
    }
    return value;
  }

  /// Return field description from iTunes results.
  static String? description(Map response) {
    String? value;
    try {
      value = response['results'][0]['description'];
    } catch (e) {
      print('IosUpgradeRepository.ITunesResults.description: $e');
    }
    return value;
  }

  /// Return the minimum app version taken from the tag in the description field
  /// from the store response. The format is: [:mav: 1.2.3].
  /// Returns version, such as 1.2.3, or null.
  static Version? minAppVersion(Map response, {String tagName = 'mav'}) {
    Version? version;
    try {
      final description = ITunesResults.description(response);
      if (description != null) {
        const regExpSource = r'\[\:mav\:[\s]*(?<version>[^\s]+)[\s]*\]';
        final regExp = RegExp(regExpSource, caseSensitive: false);
        final match = regExp.firstMatch(description);
        final mav = match?.namedGroup('version');
        // Verify version string using class Version
        version = mav != null ? Version.parse(mav) : null;
      }
    } on Exception catch (e) {
      print('IosUpgradeRepository.ITunesResults.minAppVersion : $e');
    }
    return version;
  }

  /// Return field releaseNotes from iTunes results.
  static String? releaseNotes(Map response) {
    String? value;
    try {
      value = response['results'][0]['releaseNotes'];
    } catch (e) {
      print('IosUpgradeRepository.ITunesResults.releaseNotes: $e');
    }
    return value;
  }

  /// Return field trackViewUrl from iTunes results.
  static String? trackViewUrl(Map response) {
    String? value;
    try {
      value = response['results'][0]['trackViewUrl'];
    } catch (e) {
      print('IosUpgradeRepository.ITunesResults.trackViewUrl: $e');
    }
    return value;
  }

  /// Return field version from iTunes results.
  static String? version(Map response) {
    String? value;
    try {
      value = response['results'][0]['version'];
    } catch (e) {
      print('IosUpgradeRepository.ITunesResults.version: $e');
    }
    return value;
  }
}

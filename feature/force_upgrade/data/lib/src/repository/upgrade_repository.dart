import 'package:version/version.dart';

abstract class UpgradeRepository {
  Future<StoreResponse> checkForUpgrade(String id);
}

class StoreResponse {
  final Version? storeVersion;
  final String? storeListingUrl;
  final String? releaseNotes;
  final Version? mav;

  StoreResponse({
    required this.storeVersion,
    required this.storeListingUrl,
    required this.releaseNotes,
    required this.mav,
  });

  @override
  String toString() {
    return 'storeVersion: $storeVersion,' +
        '\n' +
        'storeListingUrl: $storeListingUrl,' +
        '\n' +
        'releaseNotes: $releaseNotes,' +
        '\n' +
        'mav: $mav';
  }
}

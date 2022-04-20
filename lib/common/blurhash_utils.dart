import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'blurhash.dart';

Map<String, String> hashes = {
  // "BoxJumpHorizontal.jpg": "L26RAYE000IU00IT~WxukDs:Rjoe",
  //BoxJumpVertical.mp4
  //"BoxJumpVertical": "L584Sl-:00IB01M{-:%200IU~px]",
  // "BoxJumpVertical": "LA7^-|xu4oM{9GRjxut70KRQ?HtQ",
  "BoxJumpVertical": "007^-|",
  // "BurpeesHorizontal.jpg": "L06RDi00PB014:00Ri\$|xc^+9Zs.",
  //BurpeesVertical.mp4
  //"BurpeesVertical": "L0429uS\$0\$\$z00Rj%2WU0NwI^OIr",
  "BurpeesVertical": "L1429tW=ENxE0JWBxaay59s9%0NI",
  "DumbbellSquatCleanThrusterSkill.jpg": "L04eKKkD009r00s,I.NG02r;~Wxv",
  "DumbbellThrusterHorizontal.jpg": "L06RDi00?^4=ER00RO^*Mz?ID%s.",
  // DumbbellSquatCleanThrusterVertical.mp4
  //"DumbbellSquatCleanThrusterVertical": "L04BwbOt0Kng4moeE1Rj0h#*%2S5"
  "DumbbellSquatCleanThrusterVertical": "L04BtUOa0KjD4modD*Rj0h#*%2S5"
};

void generateHashes(BuildContext context) async {
  List<String> images = [];
  final manifestJson =
      await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
  final Map<String, dynamic> map = json.decode(manifestJson);
  map.entries.forEach((entry) {
    if (entry.key.contains('images/temp')) {
      print((entry.key));
      images.add(entry.key);
    }
  });
  images.forEach((image) async {
    // if (image.contains("stub")) {
    await blurHashEncode(image, context);
    //  }
  });
}

Future blurHashEncode(String path, BuildContext context) async {
  ImageProvider image = AssetImage(path);
  image
      .resolve(new ImageConfiguration())
      .addListener(ImageStreamListener((info, _) async {
    ByteData bytes = await info.image.toByteData();
    Uint8List pixels = bytes.buffer.asUint8List();
    final width = info.image.width;
    final height = info.image.height;
    var blurHash =
        encodeBlurHash(pixels, width, height, numCompX: 9, numpCompY: 1);
    print("$path : $blurHash");
  }));
}

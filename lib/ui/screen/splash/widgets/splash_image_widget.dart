import 'package:flutter/material.dart';

class SplashImage extends StatefulWidget {
  final SplashImageConfig config;

  SplashImage({this.config});

  @override
  _SplashImageState createState() => _SplashImageState();
}

class _SplashImageState extends State<SplashImage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: AnimatedOpacity(
        opacity: widget.config.isImageVisible() ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: Image.asset(
          widget.config.imagePath(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

abstract class SplashImageConfig {
  bool isImageVisible();

  String imagePath();
}

class PhotoConfig implements SplashImageConfig {
  bool _isImageVisible;
  String _imagePath;
  SplashImagePathProvider pathProvider;

  bool isImageVisible() => _isImageVisible;

  String imagePath() => _imagePath;

  PhotoConfig(this._imagePath, this._isImageVisible, this.pathProvider);

  void toggle() {
    if (imagePath == null) {
      return;
    }
    bool updatedVisibility = !_isImageVisible;
    if (updatedVisibility) {
      _imagePath = pathProvider.getImagePath();
    }
    _isImageVisible = updatedVisibility;
  }
}

abstract class SplashImagePathProvider {
  String getImagePath();
}

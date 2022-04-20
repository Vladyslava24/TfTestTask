import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/utils/locales_service.dart';

final LocalesService _localesService = DependencyProvider.get<LocalesService>();

abstract class GridItem {}

class HeaderItem implements GridItem {
  String getTitle() {
    return _localesService.locales.choose_or_take_photo;
  }
}

class GalleryPickerItem implements GridItem {}

class ImageItem implements GridItem {
  final String url;

  ImageItem({@required this.url});
}

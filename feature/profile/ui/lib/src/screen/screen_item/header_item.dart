import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'header_item.freezed.dart';

@freezed
class HeaderItem with _$HeaderItem {
  const factory HeaderItem({User? user}) = _HeaderItem;
}

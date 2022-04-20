import 'package:flutter/cupertino.dart';
import 'package:totalfit/model/profile/list_items.dart';

class LoadProgramFullSchedulePageAction {}

class SetProgramFullSchedulePageStateAction {
  final List<FeedItem> listItems;

  SetProgramFullSchedulePageStateAction({@required this.listItems});
}

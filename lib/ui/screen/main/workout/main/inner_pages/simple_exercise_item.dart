import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/redux/states/app_state.dart';


class SimpleExerciseItem extends StatefulWidget {
  final Exercise exercise;

  SimpleExerciseItem({Key key, @required this.exercise}) : super(key: key);

  @override
  _SimpleExerciseItemState createState() => _SimpleExerciseItemState();
}

class _SimpleExerciseItemState extends State<SimpleExerciseItem> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (store) {},
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => Theme(
        data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.transparent,
            accentColor: Colors.transparent),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: new BorderRadius.circular(10),
                child: TfImage(
                  url: widget.exercise.image,
                  width: 75,
                  height: 54,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.exercise.name,
                        style: title14.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                      Container(height: 4),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class _ViewModel {
  _ViewModel();

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel();
  }
}

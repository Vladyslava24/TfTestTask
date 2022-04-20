import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';

class GenderPickerField extends StatefulWidget {
  final String errorMessage;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final Function onClearError;
  final String label;

  GenderPickerField(
      {this.errorMessage,
      this.focusNode,
      this.nextFocusNode,
      this.textEditingController,
      this.onChanged,
      this.onClearError,
      this.label});

  @override
  _GenderPickerFieldState createState() => _GenderPickerFieldState();
}

class _GenderPickerFieldState extends State<GenderPickerField> {
  Function _focusListener;

  List<PopupMenuEntry> _menuEntries;

  @override
  void initState() {
    _menuEntries = Gender.swatch.map((item) {
      return PopupMenuItem<String>(
        value: item.name,
        child: Text(item.name, style: textRegular16.copyWith(color: AppColorScheme.colorPrimaryWhite)),
      );
    }).toList();

    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInitialBuild: (vm) {
          _focusListener = () {
            if (widget.focusNode.hasFocus) {
              _showGenderPicker(vm);
            }
          };
          widget.focusNode.addListener(_focusListener);
        },
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  final popupButtonKey = GlobalKey<State>();

  Widget _buildContent(_ViewModel vm) => Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Stack(
            children: <Widget>[
              PopupMenuButton<String>(
                key: popupButtonKey,
                color: AppColorScheme.colorGreen,
                child: TextFormField(
                  showCursor: false,
                  readOnly: true,
                  textInputAction: widget.nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
                  onTap: () {
                    _showGenderPicker(vm);
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  style: textRegular16.copyWith(color: AppColorScheme.colorPrimaryWhite),
                  focusNode: widget.focusNode,
                  controller: widget.textEditingController,
                  decoration: _inputFieldDecoration(),
                ),
                onCanceled: () {
                  print("canceled");
                },
                itemBuilder: (context) => _menuEntries,
              ),
            ],
          ),
        ),
      );

  _showGenderPicker(_ViewModel vm) {
    FocusScope.of(context).requestFocus(new FocusNode());
    final RenderBox popupButtonObject = popupButtonKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        popupButtonObject.localToGlobal(Offset.zero, ancestor: overlay),
        popupButtonObject.localToGlobal(popupButtonObject.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      elevation: 8.0,
      items: _menuEntries,
      initialValue: null,
      position: position,
    ).then((value) {
      widget.onChanged(value);
      if (widget.nextFocusNode != null) {
        FocusScope.of(context).requestFocus(widget.nextFocusNode);
      }
    });
  }

  InputDecoration _inputFieldDecoration() => InputDecoration(
        hintText: widget.label,
        hintStyle: textRegular16.copyWith(color: AppColorScheme.colorBlack7),
        errorText: _setErrorText(),
        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColorScheme.colorRed)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColorScheme.colorBlack7),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColorScheme.colorYellow),
        ),
      );

  String _setErrorText() {
    return widget.errorMessage != null && widget.errorMessage.isNotEmpty ? widget.errorMessage : null;
  }
}

class _ViewModel {
  _ViewModel();

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel();
  }
}

class MenuItems {
  static const String ShareResults = 'Share Results';
  static const String View = 'View';
  static const String Delete = 'Delete';

  static const List<String> list = <String>[ShareResults, View, Delete];
}

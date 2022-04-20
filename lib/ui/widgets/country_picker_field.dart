import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/widgets/select_country_dialog.dart';
import 'package:totalfit/utils/locales_service.dart';
import 'package:ui_kit/ui_kit.dart';

final LocalesService _localesService = DependencyProvider.get<LocalesService>();

class CountryPickerField extends StatefulWidget {
  final String errorMessage;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final Function onClearError;
  final String label;

  CountryPickerField(
      {this.errorMessage,
      this.focusNode,
      this.nextFocusNode,
      this.textEditingController,
      this.keyboardType,
      this.onChanged,
      this.onClearError,
      this.label});

  @override
  _CountryPickerFieldState createState() => _CountryPickerFieldState();
}

class _CountryPickerFieldState extends State<CountryPickerField> {
  Function _focusListener;

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
              _showCountryPicker(vm);
            }
          };
          widget.focusNode.addListener(_focusListener);
        },
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            textInputAction: widget.nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
            onTap: () {
              _showCountryPicker(vm);
            },
            style: textRegular16.copyWith(color: AppColorScheme.colorPrimaryWhite),
            keyboardType: widget.keyboardType,
            controller: widget.textEditingController,
            decoration: _inputFieldDecoration(),
            onChanged: (text) {
              if (widget.errorMessage.isNotEmpty) {
                widget.onClearError();
              }
              widget.onChanged(text);
            },
          ),
        ),
      );

  String _selectedCountry = _localesService.locales.no_country_selected;

  _showCountryPicker(_ViewModel vm) async {
    FocusScope.of(context).requestFocus(FocusNode());

    String result = await SelectCountryDialog.showModal<String>(
      context,
      backgroundColor: AppColorScheme.colorBlack2,
      label: S.of(context).select_country,
      selectedValue: _selectedCountry,
      showSearchBox: true,
      titleStyle: textRegular16.copyWith(color: AppColorScheme.colorPrimaryWhite),
      searchBoxDecoration: _searchBoxDecoration(),
      itemBuilder: (context, item, isSelected) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item,
              style: isSelected
                  ? textRegular16.copyWith(color: AppColorScheme.colorYellow)
                  : textRegular16.copyWith(color: AppColorScheme.colorPrimaryWhite)),
        );
      },
      // onChange: (String selected) {
      //   setState(() {
      //     _selectedCountry = selected;
      //     if (_selectedCountry != null) {
      //       widget.textEditingController.text = _selectedCountry;
      //     }
      //     FocusScope.of(context).requestFocus(widget.nextFocusNode);
      //   });
      // },
    );

    if (result != null) {
      setState(() {
        _selectedCountry = result;
        if (_selectedCountry != null) {
          widget.textEditingController.text = _selectedCountry;
        }
        FocusScope.of(context).requestFocus(widget.nextFocusNode);
      });
    }
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

  InputDecoration _searchBoxDecoration() => InputDecoration(
        hintText: "${S.of(context).search}...",
        hintStyle: textRegular16.copyWith(color: AppColorScheme.colorBlack7),
        errorText: _setErrorText(),
        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColorScheme.colorRed)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColorScheme.colorBlack7),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColorScheme.colorPrimaryWhite),
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

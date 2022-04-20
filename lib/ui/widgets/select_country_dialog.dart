import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/delay.dart';
import 'package:rxdart/src/transformers/switch_map.dart';
import 'package:totalfit/data/dto/response/load_country_list_response.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

typedef Widget SelectOneItemBuilderType<T>(BuildContext context, T item, bool isSelected);

class SelectCountryDialog<T> extends StatefulWidget {
  final List<T> itemsList;
  final bool showSearchBox;
  final SelectOneItemBuilderType<T> itemBuilder;
  final InputDecoration searchBoxDecoration;
  final Color backgroundColor;
  final TextStyle titleStyle;
  final Function(String) onTextChange;

  const SelectCountryDialog(
      {Key key,
      this.itemsList,
      this.showSearchBox,
      this.itemBuilder,
      this.searchBoxDecoration,
      this.backgroundColor = AppColorScheme.colorPrimaryWhite,
      this.titleStyle,
      this.onTextChange})
      : super(key: key);

  static Future<T> showModal<T>(BuildContext context,
      {List<T> items,
      String label,
      T selectedValue,
      bool showSearchBox,
      Future<List<T>> Function(String text) onFind,
      SelectOneItemBuilderType<T> itemBuilder,
      void Function(T) onChange,
      InputDecoration searchBoxDecoration,
      Color backgroundColor,
      TextStyle titleStyle,
      Function(String) onTextChange}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: Text(
            label ?? "",
            style: titleStyle,
          ),
          content: SelectCountryDialog<T>(
              itemsList: items,
              showSearchBox: showSearchBox,
              itemBuilder: itemBuilder,
              searchBoxDecoration: searchBoxDecoration,
              backgroundColor: backgroundColor,
              titleStyle: titleStyle,
              onTextChange: onTextChange),
        );
      },
    );
  }

  @override
  _SelectCountryDialogState<T> createState() => _SelectCountryDialogState<T>();
}

class _SelectCountryDialogState<T> extends State<SelectCountryDialog<T>> {
  final _controller = TextEditingController();
  _CountryBlocEvent _state;
  String _currentPrefix;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<_CountryBloc>(
      create: (_) => _CountryBloc(),
      child: BlocListener<_CountryBloc, _CountryBlocEvent>(
          listenWhen: (oldState, newState) => oldState?.runtimeType != newState?.runtimeType,
          child: Builder(
            builder: (c) => Container(
              width: MediaQuery.of(context).size.width * .9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget.showSearchBox
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                              controller: _controller,
                              onChanged: (text) {
                                if (text.isNotEmpty && !isLatin(text)) {
                                  setState(() {
                                    _unsupportedInput = true;
                                  });
                                } else {
                                  setState(() {
                                    _unsupportedInput = false;
                                  });
                                }
                                if (_currentPrefix != _controller.text) {
                                  _currentPrefix = _controller.text;
                                  if (text.isNotEmpty && isLatin(text)) {
                                    _onTextChanged(c, _currentPrefix);
                                  }
                                }
                              },
                              style: TextStyle(color: AppColorScheme.colorPrimaryWhite),
                              decoration: _inputFieldDecoration()))
                      : Container(),
                  _buildCountriesContainer(),
                ],
              ),
            ),
          ),
          listener: (c, state) {
            setState(() {
              _state = state;
            });
          }),
    );
  }

  void _onTextChanged(BuildContext c, String typedText) {
    if (typedText.length > 2) {
      BlocProvider.of<_CountryBloc>(c).add(_FetchCountryListAction(typedText));
    } else {
      BlocProvider.of<_CountryBloc>(c).add(_ClearCountryListAction());
    }
  }

  bool _unsupportedInput = false;

  InputDecoration _inputFieldDecoration() => InputDecoration(
        hintStyle: textRegular16.copyWith(color: AppColorScheme.colorBlack7),
        errorText: _unsupportedInput ? S.of(context).only_latin_supported : null,
        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColorScheme.colorRed)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColorScheme.colorBlack7),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColorScheme.colorPrimaryWhite),
        ),
      );

  Widget _buildCountriesContainer() {
    if (_state == null) {
      return SizedBox.shrink();
    }
    if (_state is _Loading) {
      return _progressBar();
    } else if (_state is _Error) {
      return _placeHolderWithText((_state as _Error).exception.toString());
    } else {
      final action = _state as _OnCountryListFetchedAction;
      return _countryList(action.countries);
    }
  }

  Widget _progressBar() => Container(height: 150, child: CircularLoadingIndicator());

  Widget _placeHolderWithText(String text) => Container(
        height: 150,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: AppColorScheme.colorPrimaryWhite),
          ),
        ),
      );

  Widget _countryList(List<String> countryList) => Container(
        height: 150,
        child: ListView.builder(
          itemCount: countryList.length,
          itemBuilder: (context, index) {
            var item = countryList[index];
            return InkWell(
              // child: widget.itemBuilder(context, item as T, item == vm.signUpState.country),
              child: widget.itemBuilder(context, item as T, false),
              onTap: () {
                _controller.text = item;
                Navigator.pop(context, item);
              },
            );
          },
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

String latinUpper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String latinLower = "abcdefghijklmnopqrstuvwxyz";

bool isLatin(String source) {
  if (source == null || source.isEmpty) {
    return false;
  }
  final firstChar = source.characters.first;
  return latinUpper.contains(firstChar) || latinLower.contains(firstChar);
}

class _CountryBloc extends Bloc<dynamic, _CountryBlocEvent> {
  final RemoteStorage _remoteStorage = DependencyProvider.get<RemoteStorage>();
  final Map<String, List<Country>> _cache = {};

  _CountryBloc() : super(null);

  @override
  Stream<Transition<dynamic, _CountryBlocEvent>> transformEvents(
      Stream<dynamic> events, TransitionFunction<dynamic, _CountryBlocEvent> transitionFn) {
    return events.switchMap(transitionFn).delay(Duration(milliseconds: 300));
  }

  @override
  Stream<_CountryBlocEvent> mapEventToState(dynamic event) async* {
    if (event is _ClearCountryListAction) {
      yield _OnCountryListFetchedAction([]);
    } else if (event is _FetchCountryListAction) {
      if (event.prefix.length >= 3) {
        try {
          yield _Loading();
          final key = event.prefix.substring(0, 3);
          if (_cache.containsKey(key)) {
            List<Country> listToFilter = List.from(_cache[key]);
            listToFilter.retainWhere((country) => country.name.toLowerCase().startsWith(event.prefix.toLowerCase()));
            yield _OnCountryListFetchedAction(listToFilter.map((e) => e.name).toList());
          } else {
            List<Country> countries = await _remoteStorage.fetchCountryList(event.prefix, 'en');
            _cache.putIfAbsent(event.prefix, () => countries);
            yield _OnCountryListFetchedAction(countries.map((e) => e.name).toList());
          }
        } catch (e) {
          print(e);
          yield _Error(e);
        }
      }
    }
  }
}

abstract class _CountryBlocEvent {
  @override
  String toString() => runtimeType.toString();
}

class _FetchCountryListAction extends _CountryBlocEvent {
  final String prefix;

  _FetchCountryListAction(this.prefix);
}

class _ClearCountryListAction extends _CountryBlocEvent {}

class _OnCountryListFetchedAction extends _CountryBlocEvent {
  final List<String> countries;

  _OnCountryListFetchedAction(this.countries);
}

class _Error extends _CountryBlocEvent {
  final dynamic exception;

  _Error(this.exception);
}

class _Loading extends _CountryBlocEvent {}

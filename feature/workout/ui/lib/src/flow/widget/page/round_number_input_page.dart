import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class RoundNumberInputPage extends StatefulWidget {
  static final _standardRoundCount=1;
  final int initialRoundCount;
  final Function(int) onSubmit;
  final int editedRoundCount;



  const RoundNumberInputPage(
      {required this.initialRoundCount,
      required this.onSubmit,
      required this.editedRoundCount,
      Key? key})
      : super(key: key);

  @override
  _RoundNumberInputPageState createState() => _RoundNumberInputPageState();
}

class _RoundNumberInputPageState extends State<RoundNumberInputPage> {
  static final List<String> _rounds = List.generate(51, (index) => "$index");

  late int _editedRoundCount;


  @override
  void initState() {
    if (widget.initialRoundCount == 0) {
      _editedRoundCount =RoundNumberInputPage._standardRoundCount;
    } else {
      _editedRoundCount = widget.initialRoundCount;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() => Container(
        color: AppColorScheme.colorBlack,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _appBar(),
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: WillPopScope(
                onWillPop: () => _onBackPressed(),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          HorizontalScrollableSelector(
                            height: 100,
                            itemWidth: MediaQuery.of(context).size.width / 5,
                            initialPosition: widget.initialRoundCount == 0
                                ? RoundNumberInputPage._standardRoundCount
                                : widget.initialRoundCount,
                            itemCount: _rounds.length,
                            onPullUpComplete: (selectedIndex) {
                              _editedRoundCount = selectedIndex;
                            },
                            itemBuilder: (context, index, isSelected) => Align(
                              alignment: Alignment.center,
                              child: Text(
                                _rounds[index],
                                textAlign: TextAlign.center,
                                style: title40.copyWith(
                                  color: isSelected
                                      ? AppColorScheme.colorYellow
                                      : AppColorScheme.colorPrimaryWhite,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 16),
                            child: _buildSelectedRoundIndicator(),
                          ),
                        ],
                      ),
                    ),
                    ActionButton(
                      padding: const EdgeInsets.all(16),
                      text:
                          "${S.of(context).yes.toUpperCase()}, ${S.of(context).all__continue.toUpperCase()}",
                      color: AppColorScheme.colorYellow,
                      onPressed: () => widget.onSubmit(_editedRoundCount),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  AppBar _appBar() => AppBar(
        title: Center(
          child: Text(
            S.of(context).your_result,
            textAlign: TextAlign.center,
            style: title20.copyWith(color: AppColorScheme.colorPrimaryWhite),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColorScheme.colorBlack,
        iconTheme: const IconThemeData(color: AppColorScheme.colorYellow),
      );

  Widget _buildSelectedRoundIndicator() => Column(
        children: <Widget>[
          const SizedBox(
            width: 42,
            height: 42,
            child: Icon(
              Triangle.triangle,
              size: 40,
              color: AppColorScheme.colorYellow,
            ),
          ),
          Container(height: 8),
          Text(
            S.of(context).rounds,
            textAlign: TextAlign.center,
            style: title16.copyWith(
              color: AppColorScheme.colorYellow,
            ),
          ),
        ],
      );

  Future<bool> _onBackPressed() {
    return Future.sync(() => true);
  }
}

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/domain/ab_test/ab_test_service.dart';
import 'package:totalfit/model/purchase_item.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/epics/purchase_epic.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/utils/web.dart';
import 'package:ui_kit/ui_kit.dart';

class DiscountPage extends StatefulWidget {
  final List<double> stops;
  final List<Color> colors;
  final Color accentTextColor;
  final Color btnBackground;
  final Color btnTextColor;
  final Color termsTextColor;
  final DiscountPageType type;

  const DiscountPage({
    this.stops,
    this.colors,
    this.accentTextColor,
    this.btnBackground,
    this.btnTextColor,
    this.termsTextColor,
    this.type = DiscountPageType.unknown,
    Key key,
  }) : super(key: key);

  factory DiscountPage.newYear() {
    return DiscountPage(
      stops: const [.63, .99],
      colors: const [AppColorScheme.colorRed4, AppColorScheme.colorOrange4],
      accentTextColor: AppColorScheme.colorPrimaryWhite,
      btnBackground: AppColorScheme.colorPrimaryWhite,
      btnTextColor: AppColorScheme.colorPrimaryBlack,
      termsTextColor: AppColorScheme.colorPrimaryWhite.withOpacity(.65),
      type: DiscountPageType.newYear
    );
  }

  factory DiscountPage.easter() {
    return DiscountPage(
      stops: const [.77, 1.40],
      colors: const [AppColorScheme.colorYellow3, AppColorScheme.colorRed1],
      accentTextColor: AppColorScheme.colorRed1,
      btnBackground: AppColorScheme.colorRed1,
      btnTextColor: AppColorScheme.colorPrimaryWhite,
      termsTextColor: AppColorScheme.colorBlack2.withOpacity(.65),
      type: DiscountPageType.easter
    );
  }

  factory DiscountPage.stPatrick() {
    return DiscountPage(
      stops: const [.82, 1.0],
      colors: const [AppColorScheme.colorGreen4, AppColorScheme.colorBlue4],
      accentTextColor: AppColorScheme.colorGreen5,
      btnBackground: AppColorScheme.colorGreen5,
      btnTextColor: AppColorScheme.colorPrimaryWhite,
      termsTextColor: AppColorScheme.colorBlack2.withOpacity(.65),
      type: DiscountPageType.stPatrick
    );
  }

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  bool _isProcessingPurchase = false;

  final ABTestService _abTestService = DependencyProvider.get<ABTestService>();

  static const String discountValue = 'discount_value';

  String getDiscountValue() =>
    _abTestService.remoteConfig.getInt(discountValue) > 0 ?
    _abTestService.remoteConfig.getInt(discountValue).toString() + '%' : '';

  getTitle(DiscountPageType type) {
    switch(type) {
      case DiscountPageType.newYear:
        return S.of(context).discount_screen_title_new_year;
      case DiscountPageType.easter:
        return S.of(context).discount_screen_title_easter(getDiscountValue());
      case DiscountPageType.stPatrick:
        return S.of(context).discount_screen_title_st_patrick(getDiscountValue());
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) =>
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: widget.stops,
              colors: widget.colors,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: SimpleAppBar(
              actionType: ActionType.closeCircleLight,
              actionFunction: () => Navigator.of(context).pop(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: vm.discount != null ? SingleChildScrollView(
                child: Column(
                  children: [
                    widget.type == DiscountPageType.newYear ? Container(
                      margin: const EdgeInsets.only(bottom: 24.0),
                      child: Center(
                        child: TfImage(
                          width: 276.0,
                          height: 207.0,
                          url: christmasLetterImage,
                          background: AppColorScheme.colorRed4
                        ),
                      ),
                    ) : const SizedBox(),
                    widget.type == DiscountPageType.easter ? Container(
                      margin: const EdgeInsets.only(bottom: 24.0),
                      child: Center(
                        child: TfImage(
                          width: 273.0,
                          height: 233.0,
                          url: easterFlower,
                          background: Colors.transparent
                        ),
                      ),
                    ) : const SizedBox(),
                    widget.type == DiscountPageType.stPatrick ? Container(
                      margin: const EdgeInsets.only(bottom: 24.0),
                      child: Center(
                        child: TfImage(
                          width: 320.0,
                          height: 223.0,
                          url: stPatrickCleverDiscount,
                          background: Colors.transparent
                        ),
                      ),
                    ) : const SizedBox(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        getTitle(widget.type),
                        textAlign: TextAlign.center,
                        style: title20.copyWith(color: widget.accentTextColor),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                      constraints: BoxConstraints(
                        minHeight: 94.0,
                        maxWidth: 260.0
                      ),
                      decoration: BoxDecoration(
                        color: AppColorScheme.colorPrimaryWhite.withOpacity(.25),
                        borderRadius: BorderRadius.circular(cardBorderRadius)
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            vm.annualPurchase != null ?
                              Text(
                                S.of(context).discount_screen_price(vm.annualPurchase.priceString),
                                style: title16.copyWith(
                                  color: widget.accentTextColor.withOpacity(.65),
                                  decoration: TextDecoration.lineThrough
                                ),
                                textAlign: TextAlign.center,
                              ) : const SizedBox(),
                            vm.discount != null ? Text(
                              S.of(context).discount_screen_price(vm.discount.priceString),
                              style: title30.copyWith(
                                color: widget.accentTextColor,
                              ),
                              textAlign: TextAlign.center,
                            ) : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 80.0),
                    InkWell(
                      borderRadius: BorderRadius.circular(cardBorderRadius),
                      onTap: () {
                        setState(() {
                          _isProcessingPurchase = true;
                        });

                        purchaseProduct(
                          vm.discount.identifier,
                        ).then((result) {
                          setState(() {
                            _isProcessingPurchase = false;
                          });
                          vm.changeDiscountEnableValue(false);
                          Navigator.of(context).pop(true);
                        })
                         .catchError((e) {
                            setState(() {
                              _isProcessingPurchase = false;
                            });
                            TfDialog.show(
                              context,
                              TfDialogAttributes(
                                title: S.of(context).discount_screen_popup_title,
                                description: e.toString(),
                                negativeText: S.of(context).all__OK
                              ),
                            );
                        });
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: 48.0,
                          minWidth: 329.0
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 44.0,
                        ),
                        decoration: BoxDecoration(
                          color: widget.btnBackground,
                          borderRadius: BorderRadius.circular(cardBorderRadius)
                        ),
                        child: Center(
                          child: _isProcessingPurchase ?
                          const SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: CircularProgressIndicator(
                              color: AppColorScheme.colorPrimaryBlack
                            ),
                          ) :
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: S.of(context).discount_screen_btn_text,
                                  style: title16.copyWith(
                                    color: widget.btnTextColor
                                  ),
                                  children: [
                                    TextSpan(
                                      text: vm.annualPurchase != null ?
                                      vm.annualPurchase.priceString : '',
                                      style: title16.copyWith(
                                        color: widget.btnTextColor,
                                        decoration: TextDecoration.lineThrough
                                      ),
                                      children: [
                                        TextSpan(
                                          text: vm.annualPurchase != null ? ' ' : '',
                                          style: title16.copyWith(
                                            color: widget.btnTextColor,
                                            decoration: TextDecoration.none
                                          ),
                                        ),
                                        TextSpan(
                                          text: vm.discount != null ?
                                          vm.discount.priceString : '',
                                          style: title16.copyWith(
                                            color: widget.btnTextColor,
                                            decoration: TextDecoration.none
                                          ),
                                        ),
                                      ]
                                    ),
                                  ]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).discount_screen_subscription_terms,
                          style: textRegular12.copyWith(
                            color: widget.termsTextColor.withOpacity(.65))
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          S.of(context).discount_screen_subscription_text,
                          style: textRegular9.copyWith(
                            color: widget.termsTextColor.withOpacity(.65)),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).discount_screen_subscription_accept,
                              style: textRegular12.copyWith(
                                color: widget.termsTextColor
                                  .withOpacity(.65)
                              ),
                            ),
                            const SizedBox(width: 2.0),
                            GestureDetector(
                              onTap: () => launchURL(PRIVACY_POLICY),
                              child: Text(
                                S.of(context).discount_screen_subscription_privacy,
                                style: textRegular12.copyWith(
                                  color: widget.termsTextColor
                                    .withOpacity(.65),
                                  decoration: TextDecoration.underline
                                ),
                              ),
                            ),
                            const SizedBox(width: 2.0),
                            Text(
                              S.of(context).discount_screen_subscription_and,
                              style: textRegular12.copyWith(
                                color: widget.termsTextColor
                                  .withOpacity(.65)
                              ),
                            ),
                            const SizedBox(width: 2.0),
                            GestureDetector(
                              onTap: () => launchURL(TERMS_OF_USE),
                              child: Text(
                                S.of(context).discount_screen_subscription_terms_of_use,
                                style: textRegular12.copyWith(
                                  color: widget.termsTextColor
                                    .withOpacity(.65),
                                  decoration: TextDecoration.underline
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                      ],
                    ),
                  ],
                ),
              ) : Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 329.0
                  ),
                  child: Text(
                    S.of(context).discount_screen_error_text,
                    style: title20.copyWith(color: widget.accentTextColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}

class _ViewModel {
  final PurchaseItem discount;
  final Function changeDiscountEnableValue;
  final PurchaseItem annualPurchase;

  _ViewModel({
    @required this.discount,
    @required this.changeDiscountEnableValue,
    @required this.annualPurchase
  });

  static _ViewModel fromStore(Store<AppState> store) =>
    _ViewModel(
      discount: store.state.mainPageState.discountProduct,
      changeDiscountEnableValue: (bool value) =>
        store.dispatch(DiscountChangeValueAction(value: value)),
      annualPurchase: store.state.mainPageState.purchaseItems != null &&
          store.state.mainPageState.purchaseItems.isNotEmpty ?
      store.state.mainPageState.purchaseItems.singleWhere((e) =>
        e.itemType == PurchaseItemType.annual, orElse: () => null) : null
    );
}

enum DiscountPageType {newYear, easter, stPatrick, unknown}
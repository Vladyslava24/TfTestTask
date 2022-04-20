import 'dart:io';
import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/domain/ab_test/ab_test_service.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/purchase_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/purchase_item.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/purchase_actions.dart';
import 'package:totalfit/redux/epics/purchase_epic.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/utils/screen_size.dart';
import 'package:totalfit/ui/utils/web.dart';
import 'package:totalfit/ui/widgets/keys.dart';
import 'package:totalfit/utils/double_extensions.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class PaywallScreen extends StatefulWidget {
  final VoidCallback onClose;
  final bool isRoute;

  PaywallScreen({
    this.isRoute = false,
    this.onClose
  });

  static Future<bool> show(BuildContext context) => showModalBottomSheet<bool>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: AppColorScheme.colorPrimaryWhite,
      context: context,
      builder: (_) => PaywallScreen());

  @override
  _PaywallScreenState createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  int _selectedProductIndex = 0;

  final ABTestService _abTestService = DependencyProvider.get<ABTestService>();

  ColorTween _itemBackgroundColorTween = ColorTween(
    begin: Colors.transparent,
    end: AppColorScheme.colorYellow,
  );
  ColorTween _itemTextColorTween = ColorTween(
    begin: AppColorScheme.colorPrimaryWhite,
    end: AppColorScheme.colorYellow,
  );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel.fromStore(store),
        onWillChange: (oldVm, newVm) async {
          if (!oldVm.isPremiumUser && newVm.isPremiumUser) {
            newVm.sendTrialStartedEvent(newVm.purchaseItems[_selectedProductIndex].identifier);
            Future.delayed(Duration(milliseconds: 1000), () {
              if (mounted) {
                if (widget.onClose != null) {
                  widget.onClose();
                } else {
                  Navigator.pop(context, newVm.isPremiumUser);
                }
              }
            });
          }
          if (oldVm.purchaseError is IdleException &&
              newVm.purchaseError is PurchaseException) {
            final attrs = TfDialogAttributes(
              title: S.of(context).all__error,
              description: newVm.purchaseError.getMessage(context),
              negativeText: S.of(context).dialog_error_recoverable_negative_text,
              positiveText: S.of(context).all__retry,
            );
            final result = await TfDialog.show(context, attrs);
            newVm.clearPurchaseError();
            if (result is Confirm) {
              purchaseProduct(newVm.purchaseItems[_selectedProductIndex].identifier);
            }
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) {
    final size = ScreenSize.getForHeight(MediaQuery.of(context).size.height);
    int imageFlex;
    int contentFlex;
    if (size == ScreenSize.SMALL || size == ScreenSize.MEDIUM) {
      imageFlex = 2;
      contentFlex = 6;
    } else {
      imageFlex = 3;
      contentFlex = 5;
    }
    return Material(
      color: AppColorScheme.colorBlack,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 48,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(flex: imageFlex, child: _buildImage(imPaywall, vm)),
                Expanded(
                  flex: contentFlex,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    _buildTitle(),
                    _buildSubTitle(),
                    _buildBenefits(),
                    Expanded(child: SizedBox.shrink()),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 350),
                      reverseDuration: Duration(milliseconds: 350),
                      transitionBuilder: (widget, animation) =>
                        ScaleTransition(child: widget, scale: animation),
                      child: vm.isPremiumUser ?
                        _buildPurchasedStatus() :
                        _buildSubscriptionSelector(vm)),
                    Expanded(child: SizedBox.shrink()),
                    vm.isPremiumUser
                        ? SizedBox.shrink()
                        : AnimatedOpacity(
                            opacity:
                              vm.isPremiumUser || vm.purchaseItems.isEmpty ?
                                0 : 1,
                            duration: Duration(milliseconds: 350),
                            child: _buildActionButton(vm)),
                  ]),
                )
              ],
            ),
          ),
          Platform.isIOS ? _iosPolicy() : _androidPolicy(vm, _selectedProductIndex),
          _buildTermsAndPolicy(vm)
        ]),
      )
    );
  }

  Widget _androidPolicy(_ViewModel vm, index) => Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
    child: Column(
      children: [
        Text(
          vm.purchaseItems.isNotEmpty ?
          S.of(context).paywall_android_subscription_title(
            vm.purchaseItems[index].itemType.stringValue(context),
            '${vm.purchaseItems[index].currencyCode} ${vm.purchaseItems[index].price.toPrecision(2)}',
            vm.purchaseItems[index].itemType.stringValue(context).toLowerCase()
          ) : '',
          style: textRegular12.copyWith(color: AppColorScheme.colorPrimaryWhite),
        ),
        const SizedBox(height: 12.0),
        Text(
          vm.purchaseItems.isNotEmpty ?
          S.of(context).paywall_android_subscription_description(
            '${vm.purchaseItems[index].currencyCode} ${vm.purchaseItems[index].price.toPrecision(2)}',
            '${vm.purchaseItems[index].itemType.stringValue(context).toLowerCase()}'
          ) : '',
          style: textRegular12.copyWith(color: AppColorScheme.colorGrey4),
        ),
      ],
    ),
  );

  Widget _iosPolicy() => Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
    child: Column(
      children: [
        Text(
          S.of(context).paywall_ios_policy_title,
          style: textRegular12.copyWith(color: AppColorScheme.colorGrey4),
        ),
        SizedBox(height: 12),
        Text(
          S.of(context).paywall_ios_policy_description,
          textAlign: TextAlign.justify,
          style: textRegular9.copyWith(color: AppColorScheme.colorGrey4),
        ),
      ],
    ),
  );

  Widget _buildImage(String image, _ViewModel vm) {
    final imageSize = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Stack(children: <Widget>[
          Container(
              child: TfImage(url: image, width: imageSize, height: imageSize)),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    AppColorScheme.colorBlack,
                  ],
                ),
              ),
            ),
          ),
          Positioned(top: 0, left: 0, right: 0, child: _buildControllers(vm)),
        ]));
  }

  Widget _buildTitle() => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Text(
            _abTestService.remoteConfig
                .getString('paywall_title')
                .toUpperCase(),
            style: title20.copyWith(color: AppColorScheme.colorPrimaryWhite),
          ),
        ),
      );

  Widget _buildSubTitle() => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: RichText(
            text: TextSpan(
              text: _abTestService.remoteConfig.getString('paywall_subtitle_1'),
              style: textRegular16.copyWith(color: AppColorScheme.colorBlack7),
              children: <TextSpan>[
                TextSpan(text: ' '),
                TextSpan(
                  text: _abTestService.remoteConfig
                      .getString('paywall_subtitle_2'),
                  style:
                      textRegular16.copyWith(color: AppColorScheme.colorYellow),
                )
              ],
            ),
          ),
        ),
      );

  Widget _buildBenefits() => Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(children: [
          _buildBenefit(S.of(context).paywall_benefit_1),
          _buildBenefit(S.of(context).paywall_benefit_2),
          _buildBenefit(S.of(context).paywall_benefit_3)
        ]),
      );

  Widget _buildBenefit(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(Icons.done, color: AppColorScheme.colorYellow),
            SizedBox(width: 8),
            Text(
              text,
              style: textRegular16.copyWith(
                  color: AppColorScheme.colorPrimaryWhite),
            ),
          ],
        ),
      );

  Widget _buildControllers(_ViewModel vm) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: widget.onClose != null
                  ? 0
                  : MediaQuery.of(Keys.navigatorKey.currentContext)
                      .padding
                      .top),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CupertinoButton(
                    onPressed: () {
                      restoreTransactions();
                    },
                    child: Text(
                      S.of(context).paywall_restore_purchase,
                      style: textRegular16.copyWith(
                          color: AppColorScheme.colorYellow),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  pressedOpacity: 0.7,
                  onPressed: () {
                    vm.sendCloseTrialEvent();
                    if (widget.onClose != null) {
                      widget.onClose();
                    } else {
                      Navigator.of(context).pop(vm.isPremiumUser);
                    }
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColorScheme.colorBlack6,
                          shape: BoxShape.circle
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Icon(
                            Icons.close,
                            color: AppColorScheme.colorPrimaryWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      );

  Widget _buildPurchasedStatus() {
    return Column(
      key: ValueKey("premium"),
      children: [
        Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColorScheme.colorYellow),
            child: Icon(Icons.done, color: AppColorScheme.colorPrimaryBlack)),
        SizedBox(height: 12),
        Text(
          S.of(context).paywall_subscription_done,
          style:
              textRegular16.copyWith(color: AppColorScheme.colorPrimaryWhite),
        ),
      ],
    );
  }

  Widget _buildSubscriptionSelector(_ViewModel vm) {
    if (vm.purchaseItems.length == 0) {
      return Center(
          child: Column(
        children: [
          Text(
            S.of(context).paywall_no_products,
            textAlign: TextAlign.center,
            style:
                textRegular14.copyWith(color: AppColorScheme.colorPrimaryWhite),
          ),
          ActionButton(
              text: S.of(context).all__retry.toUpperCase(),
              padding: EdgeInsets.only(top: 24, left: 16, right: 16),
              onPressed: () => vm.retryFetchProductList())
        ],
      ));
    }

    double itemWidth = (MediaQuery.of(context).size.width -
            32 -
            8 -
            (vm.purchaseItems.length > 2 ? 32 : 0)) /
        2;
    if (vm.purchaseItems.length == 1) {
      itemWidth = MediaQuery.of(context).size.width - 32;
    } else {
      itemWidth = (MediaQuery.of(context).size.width -
              32 -
              8 -
              (vm.purchaseItems.length > 2 ? 32 : 0)) /
          2;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: AnimatedItemPicker(
            itemCount: vm.purchaseItems.length,
            axis: Axis.horizontal,
            multipleSelection: false,
            initialSelection: {_selectedProductIndex},
            onItemPicked: (index, selected) {
              setState(() {
                _selectedProductIndex = index;
              });
            },
            itemBuilder: (index, animValue) {
              return Container(
                width: itemWidth,
                margin: vm.purchaseItems.length == 1
                    ? EdgeInsets.zero
                    : EdgeInsets.only(
                        left: index == 0 ? 0 : 4,
                        right: index == vm.purchaseItems.length - 1 ? 0 : 4),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: 100.0
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color:
                              _itemBackgroundColorTween.transform(animValue)),
                      color: AppColorScheme.colorBlack2,
                      shape: BoxShape.rectangle),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vm.purchaseItems[index].itemType
                                  .stringValue(context),
                              textAlign: TextAlign.center,
                              style: title14.copyWith(
                                color: AppColorScheme.colorPrimaryWhite,
                              ),
                            ),
                            _discount(
                                vm.purchaseItems[index], vm.purchaseItems) != null ?
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 6.0
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: AppColorScheme.colorYellow,
                                  shape: BoxShape.rectangle
                              ),
                              child: Text(
                                S.of(context).paywall_discount_amount(
                                    '${_discount(vm.purchaseItems[index], vm.purchaseItems)}'),
                                textAlign: TextAlign.center,
                                style: textRegular12.copyWith(
                                  color: AppColorScheme.colorBlack2,
                                ),
                              ),
                            ) : const SizedBox(),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vm.purchaseItems.isNotEmpty ? Text(
                            "${vm.purchaseItems[index].currencyCode} ${vm.purchaseItems[index].price.toPrecision(2)} / ${vm.purchaseItems[index].itemType.stringValue(context).toLowerCase()}",
                            textAlign: TextAlign.center,
                            style: textRegular14.copyWith(
                              color: _itemTextColorTween.transform(animValue),
                            ),
                          ) : '',
                          vm.purchaseItems.isNotEmpty ? Text(
                            S.of(context).paywall_weekly_price(
                              '${vm.purchaseItems[index].currencyCode} ${vm.purchaseItems[index].weekPrice().toPrecision(2)}'),
                            textAlign: TextAlign.center,
                            style: textRegular12.copyWith(
                              color: AppColorScheme.colorBlack6),
                          ) : '',
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _buildActionButton(_ViewModel vm) => ActionButton(
      text: _abTestService.remoteConfig.getString('paywall_button_text'),
      padding: EdgeInsets.only(top: 24, left: 16, right: 16),
      fontWeight: FontWeight.w700,
      fontFamily: 'Gilroy',
      onPressed: () {
        purchaseProduct(vm.purchaseItems[_selectedProductIndex].identifier);
      });

  Widget _buildTermsAndPolicy(_ViewModel vm) => SafeArea(
        child: Container(
          padding: EdgeInsets.all(0.0),
          child: Row(
            children: [
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.only(right: 8),
                  onPressed: () => launchURL(PRIVACY_POLICY),
                  child: Text(
                    S.of(context).all__privacy_policy,
                    style: textRegular12.copyWith(
                      color: AppColorScheme.colorBlack7,
                    ),
                  ),
                ),
              )),
              Text(
                "-",
                style: textRegular12.copyWith(
                  color: AppColorScheme.colorBlack7,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CupertinoButton(
                    padding: EdgeInsets.only(left: 8),
                    onPressed: () => launchURL(TERMS_OF_USE),
                    child: Text(
                      S.of(context).all__terms_of_use,
                      style: textRegular12.copyWith(
                        color: AppColorScheme.colorBlack7,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  String _discount(PurchaseItem item, List<PurchaseItem> purchaseItems) {
    if (purchaseItems.length < 2) {
      return null;
    }
    if (item.itemType != PurchaseItemType.annual) {
      return null;
    }

    /// is sorted in main_page_reducers
    final worstPrice = purchaseItems[1].weekPrice();
    int discount = 100 - ((item.weekPrice() * 100) ~/ worstPrice);
    return discount.toString();
  }
}

class _ViewModel {
  final List<PurchaseItem> purchaseItems;
  final bool isPremiumUser;
  final VoidCallback mockChangePremiumStatus;
  final VoidCallback clearPurchaseError;
  final AppLifecycleState appLifecycleState;
  final TfException purchaseError;
  final Function retryFetchProductList;
  final Function(String) sendTrialStartedEvent;
  final Function sendCloseTrialEvent;

  _ViewModel(
      {@required this.purchaseItems,
      @required this.isPremiumUser,
      @required this.mockChangePremiumStatus,
      @required this.clearPurchaseError,
      @required this.purchaseError,
      @required this.retryFetchProductList,
      @required this.sendTrialStartedEvent,
      @required this.sendCloseTrialEvent,
      @required this.appLifecycleState});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      isPremiumUser: store.state.isPremiumUser(),
      purchaseItems: store.state.mainPageState.purchaseItems,
      purchaseError: store.state.mainPageState.purchaseError,
      appLifecycleState: store.state.appLifecycleState,
      clearPurchaseError: () => store.dispatch(ClearPurchaseErrorAction()),
      retryFetchProductList: () => store.dispatch(RetryFetchProductListAction(store.state.loginState.user)),
      sendTrialStartedEvent: (sku) => store.dispatch(TrialStartedEventAction(sku: sku)),
      sendCloseTrialEvent: () => store.dispatch(CloseTrialEventAction()),
      mockChangePremiumStatus: () {
        store.dispatch(MockChangePremiumStatusAction());
      },
    );
  }
}

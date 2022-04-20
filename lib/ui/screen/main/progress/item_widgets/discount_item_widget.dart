import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/domain/ab_test/ab_test_service.dart';
import 'package:totalfit/ui/route/app_route.dart';
import 'package:ui_kit/ui_kit.dart';

class DiscountItemWidget extends StatefulWidget {
  final String name;
  final Function onClose;
  final List<double> stops;
  final List<Color> colors;
  final DiscountItemWidgetType type;
  final Color titleColor;
  final Color btnBackground;
  final Color btnTextColor;

  const DiscountItemWidget({
    @required this.name,
    @required this.onClose,
    this.stops = const [],
    this.colors = const [],
    this.type = DiscountItemWidgetType.unknown,
    this.titleColor = AppColorScheme.colorPrimaryWhite,
    this.btnBackground = AppColorScheme.colorPrimaryWhite,
    this.btnTextColor = AppColorScheme.colorPrimaryBlack,
    Key key
  }) : super(key: key);

  factory DiscountItemWidget.newYear({
    @required name,
    @required onClose
  }) {
    return DiscountItemWidget(
      name: name,
      onClose: onClose,
      stops: const [.63, .99],
      colors: const [AppColorScheme.colorRed4, AppColorScheme.colorOrange4],
      type: DiscountItemWidgetType.newYear,
      titleColor: AppColorScheme.colorPrimaryWhite,
      btnBackground: AppColorScheme.colorPrimaryWhite,
      btnTextColor: AppColorScheme.colorPrimaryBlack,
    );
  }

  factory DiscountItemWidget.easter({
    @required name,
    @required onClose
  }) {
    return DiscountItemWidget(
      name: name,
      onClose: onClose,
      stops: const [.77, 1.40],
      colors: [AppColorScheme.colorYellow3, AppColorScheme.colorRed1],
      type: DiscountItemWidgetType.easter,
      titleColor: AppColorScheme.colorRed1,
      btnBackground: AppColorScheme.colorRed1,
      btnTextColor: AppColorScheme.colorPrimaryWhite,
    );
  }

  factory DiscountItemWidget.stPatrick({
    @required name,
    @required onClose
  }) {
    return DiscountItemWidget(
      name: name,
      onClose: onClose,
      stops: const [.82, 1.0],
      colors: [AppColorScheme.colorGreen4, AppColorScheme.colorBlue4],
      type: DiscountItemWidgetType.stPatrick,
      titleColor: AppColorScheme.colorGreen5,
      btnBackground: AppColorScheme.colorGreen5,
      btnTextColor: AppColorScheme.colorPrimaryWhite,
    );
  }

  @override
  State<DiscountItemWidget> createState() => _DiscountItemWidgetState();
}

class _DiscountItemWidgetState extends State<DiscountItemWidget> {
  final ABTestService _abTestService = DependencyProvider.get<ABTestService>();

  static const String discountValue = 'discount_value';

  String getDiscountValue() =>
    _abTestService.remoteConfig.getInt(discountValue) > 0 ?
      _abTestService.remoteConfig.getInt(discountValue).toString() + '%' : '';

  getTitleCard(DiscountItemWidgetType type) {
    switch(type) {
      case DiscountItemWidgetType.newYear:
        return S.of(context).discount_card_title_new_year;
      case DiscountItemWidgetType.easter:
        return S.of(context).discount_card_title_easter;
      case DiscountItemWidgetType.stPatrick:
        return S.of(context).discount_card_title_st_patrick;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      width: double.infinity,
      height: 178.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardBorderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: widget.stops,
          colors: widget.colors,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cardBorderRadius),
        child: Stack(
          children: [
            widget.type == DiscountItemWidgetType.newYear ? Positioned(
              top: 11.0,
              right: 0,
              child: TfImage(
                url: christmasHandImage,
                width: 120,
                background: Colors.transparent
              ),
            ) : const SizedBox(),
            widget.type == DiscountItemWidgetType.easter ? Positioned(
              top: 32.0,
              right: 0,
              child: TfImage(
                url: easterFlowerImage,
                width: 140,
                background: Colors.transparent
              ),
            ) : const SizedBox(),
            widget.type == DiscountItemWidgetType.stPatrick ? Positioned(
              top: 20.0,
              right: 10.0,
              child: TfImage(
                url: stPatrickImage,
                width: 140,
                background: Colors.transparent
              ),
            ) : const SizedBox(),
            Positioned(
              top: -2.0,
              right: -4.0,
              child: IconCloseWidget(
                action: widget.onClose,
              ),
            ),
            Positioned(
              left: 16.0,
              top: 16.0,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 170.0,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  getTitleCard(widget.type),
                  style: title20.copyWith(color: widget.titleColor),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              child: BaseElevatedButton(
                onPressed: () async {
                  final result =
                    await Navigator.of(context).pushNamed(
                      AppRoute.DISCOUNT_SCREEN,
                      arguments: widget.name
                    );
                  if (result != null) {
                    widget.onClose();
                  }
                },
                text: S.of(context).discount_card_btn_text(getDiscountValue()),
                textColor: widget.btnTextColor,
                width: 154.0,
                fontFamily: 'Gilroy',
                backgroundColor: widget.btnBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum DiscountItemWidgetType {newYear, easter, stPatrick, unknown}
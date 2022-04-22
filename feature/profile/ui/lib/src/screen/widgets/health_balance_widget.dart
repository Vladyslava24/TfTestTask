import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class HealthBalanceWidget extends StatelessWidget {
  final int body;
  final int mind;
  final int spirit;

  HealthBalanceWidget({
    required this.body,
    required this.mind,
    required this.spirit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      decoration: BoxDecoration(
        color: AppColorScheme.colorBlack2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _healthBalanceTitle(
                  '${TextConstants.body} $body%',
                  AppColorScheme.colorYellow.withOpacity(0.8),
                ),
                _healthBalanceTitle('${TextConstants.mind} $mind%', AppColorScheme.colorPurple2),
                _healthBalanceTitle('${TextConstants.spirit} $spirit%', AppColorScheme.colorBlue2),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Row(
              children: [
                if (body != 0)
                  Container(
                    height: 12,
                    width: MediaQuery.of(context).size.width * body / 100 * 0.87,
                    decoration: BoxDecoration(
                      color: AppColorScheme.colorYellow,
                      borderRadius: body != 100
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            )
                          : BorderRadius.circular(12),
                    ),
                  ),
                if (mind != 0)
                  Container(
                    height: 12,
                    width: MediaQuery.of(context).size.width * mind / 100 * 0.87,
                    decoration: BoxDecoration(
                      color: AppColorScheme.colorPurple2,
                      borderRadius: _mindBorderRadius(),
                    ),
                  ),
                if (spirit != 0)
                  Container(
                    height: 12,
                    width: MediaQuery.of(context).size.width * spirit / 100 * 0.87,
                    decoration: BoxDecoration(
                      color: AppColorScheme.colorBlue2,
                      borderRadius: spirit != 100
                          ? const BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              topRight: Radius.circular(12),
                            )
                          : BorderRadius.circular(12),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _healthBalanceTitle(String title, Color circleColor) {
    return Row(
      children: [
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(width: 8),
        Text(
          title,
          style: textRegular14,
        ),
      ],
    );
  }

  BorderRadiusGeometry? _mindBorderRadius() {
    if (body != 0 && spirit != 0) {
      return null;
    } else if (body != 0) {
      return const BorderRadius.only(
        bottomRight: Radius.circular(12),
        topRight: Radius.circular(12),
      );
    } else if (spirit != 0) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(12),
        topLeft: Radius.circular(12),
      );
    } else if (mind == 100) {
      return BorderRadius.circular(12);
    }
    return null;
  }
}

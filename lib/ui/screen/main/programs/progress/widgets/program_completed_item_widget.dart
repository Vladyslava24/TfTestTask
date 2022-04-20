import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgramCompletedItemWidget extends StatelessWidget {
  final VoidCallback onFinishProgram;

  ProgramCompletedItemWidget({@required this.onFinishProgram});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColorScheme.colorBlack3, AppColorScheme.colorBlack2],
            stops: [0.0, 1.0],
          ),
        ),
        margin: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 12),
        padding: const EdgeInsets.all(16),
        child: _buildCongratulationWidget(context));
  }

  Widget _buildCongratulationWidget(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 78,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Positioned(
                      top: 0,
                      child: SizedBox(
                        width: 78,
                        height: 78,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColorScheme.colorYellow),
                        ),
                      ),
                    ),
                    Center(
                      child: TfImage(
                        url: prize,
                        fit: BoxFit.contain,
                        width: 65,
                        height: 100,
                        background: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).program_completed_item_title,
                      textAlign: TextAlign.left,
                      style: title20.copyWith(
                        color: AppColorScheme.colorPrimaryWhite,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      S.of(context).program_completed_item_sub_title,
                      style: textRegular16.copyWith(
                        color: AppColorScheme.colorPrimaryWhite,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 4),
          ActionButton(
            text: S.of(context).program_completed_item_button_text,
            onPressed: onFinishProgram,
            padding: EdgeInsets.zero,
          ),
        ],
      );
}

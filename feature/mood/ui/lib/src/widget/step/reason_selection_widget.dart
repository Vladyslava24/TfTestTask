import 'package:core/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:mood_ui/src/model/feeling_item_ui.dart';
import 'package:mood_ui/src/widget/item/reason_selection_item_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class ReasonSelectionWidget extends StatelessWidget {
  final String image;
  final String title;
  final List<FeelingItemUI> reasons;
  final Function(List<int>) onSave;
  final Function(int) changeReason;

  const ReasonSelectionWidget({
    required this.image,
    required this.title,
    required this.reasons,
    required this.onSave,
    required this.changeReason,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: TfImage(
                      url: image,
                      background: Colors.transparent,
                      width: 160.0,
                    )
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    title,
                    style: title16.copyWith(color: AppColorScheme.colorPrimaryWhite),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  Wrap(
                    children: List<Widget>.of(
                      reasons.map((r) =>
                        MoodReasonSelectionItem(
                          id: r.id,
                          emoji: r.emoji,
                          text: r.name,
                          selected: r.selected,
                          onChange: (id) => changeReason(id)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60.0),
                ],
              )
            ),
          ),
        ),
        Positioned(
          bottom: 24.0,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width
            ),
            child: BaseElevatedButton(
              backgroundColor: AppColorScheme.colorBlue2,
              textColor: AppColorScheme.colorPrimaryWhite,
              text: S.of(context).all__save,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              onPressed: () {
                final _selected = reasons
                  .where((e) => e.selected).map((e) => e.id).toList();
                onSave(_selected);
              },
            ),
          ),
        )
      ],
    );
  }
}

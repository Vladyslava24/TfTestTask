import 'package:flutter/material.dart';
import 'package:mood_ui/src/model/feeling_item_ui.dart';
import 'package:mood_ui/src/widget/item/selection_item_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class SelectionWidget extends StatelessWidget {
  final String image;
  final String title;
  final List<FeelingItemUI> items;
  final Function(int) onSelect;

  const SelectionWidget({
    required this.image,
    required this.title,
    required this.items,
    required this.onSelect,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16
              ),
              itemCount: items.length,
              itemBuilder: (ctx, index) {
                return SelectionItemWidget(
                  emoji: items[index].emoji,
                  text: items[index].name,
                  onSelect: () => onSelect(items[index].id)
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

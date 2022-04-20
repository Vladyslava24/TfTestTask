import 'package:flutter/material.dart';
import 'package:mood_ui/src/model/feeling_group_ui.dart';
import 'package:mood_ui/src/utils/ui_utils.dart';
import 'package:mood_ui/src/widget/item/category_item_widget.dart';

class CategoryWidget extends StatefulWidget {
  final List<FeelingGroupUI> groups;
  final Function(int) onSelect;

  const CategoryWidget({
    required this.groups,
    required this.onSelect,
    Key? key
  }) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 5 / 6,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16
        ),
        itemCount: widget.groups.length,
        itemBuilder: (ctx, index) {
          return CategoryItemWidget(
            text: widget.groups[index].name,
            image: widget.groups[index].image,
            color: Color(convertColor(widget.groups[index].color)),
            onSelect: () => widget.onSelect(widget.groups[index].id)
          );
        }
      ),
    );
  }
}


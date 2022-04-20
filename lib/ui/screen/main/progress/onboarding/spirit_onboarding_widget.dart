import 'package:flutter/material.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/model/story_model.dart';
import 'package:totalfit/ui/screen/main/progress/item_widgets/story_and_statements_item_widget.dart';

class SpiritOnBoardingWidget extends StatelessWidget {
  const SpiritOnBoardingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StoryAndStatementsListItemWidget(
            item: StoryAndStatementListItem(
              storyModel: StoryModel(
                id: '12',
                isRead: false,
                name: 'Lower your bucket!',
                story: '',
                image: 'https://totalfit-app-images.s3.eu-west-1.amazonaws.com/LowerYourBucket.jpg',
                estimatedReadingTime: 3,
               statements: []
              )
            ),
          )
        ]
      )
    );
  }
}

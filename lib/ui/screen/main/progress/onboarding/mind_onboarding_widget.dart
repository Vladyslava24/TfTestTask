import 'package:flutter/material.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:totalfit/model/breathing_model.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/model/wisdom_model.dart';
import 'package:totalfit/ui/screen/main/progress/item_widgets/breathing_item_widget.dart';
import 'package:totalfit/ui/screen/main/progress/item_widgets/habit_item_widget.dart';
import 'package:totalfit/ui/screen/main/progress/item_widgets/wisdom_item_widget.dart';

class MindOnBoardingWidget extends StatelessWidget {
  const MindOnBoardingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WisdomListItemWidget(
            item: WisdomListItem(
              wisdomModel: WisdomModel(
                id: '5891',
                name: 'No Time for The Gym, No Problem. Just Get Moving',
                text: '',
                image: 'https://totalfit-app-images.s3-eu-west-1.amazonaws.com/w005.jpg',
                estimatedReadingTime: 22,
                isRead: false
              ),
            ),
          ),
          BreathingItemWidget(
            item: BreathingListItem(
              breathingModel: BreathingModel(
                id: "1",
                video: "https://totalfit-workout-videos.s3.eu-west-1.amazonaws.com/Breathing/TotalfitBreathing.mp4",
                done: false
              ),
            ),
          ),
          HabitListItemWidget(
            openHabitPicker: null,
            onUpdateHabit: null,
            isToday: true,
            item: HabitListItem(
              habits: [
                HabitDto(
                  id: '2538',
                  chosen: true,
                  habit: Habit(
                    id: '8',
                    name: 'Measure body weight every morning',
                    tag: 'FOOD'
                  ),
                  recommended: false,
                  completed: false
                ),
                HabitDto(
                    id: '2537',
                    chosen: true,
                    habit: Habit(
                      id: '29',
                      name: 'Eat healthy snacks between the meals',
                      tag: 'FOOD'
                    ),
                    recommended: false,
                    completed: false
                ),
                HabitDto(
                  id: '2536',
                  chosen: true,
                  habit: Habit(
                    id: '11',
                    name: 'Eat colorful vegetables everyday',
                    tag: 'FOOD'
                  ),
                  recommended: false,
                  completed: false
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}

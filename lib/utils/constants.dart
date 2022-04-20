import 'package:totalfit/model/inner_pages/workouts/workouts_filter_model.dart';

//TODO: добавить локализацию
final Map<String, List<ChipData>> constWorkoutFilters = {
  'difficulty': [
    ChipData(
      value: 'Beginner',
      label: 'Beginner',
      isSelected: false,
      filter: 'difficulty',
    ),
    ChipData(
      value: 'Intermediate',
      label: 'Intermediate',
      isSelected: false,
      filter: 'difficulty',
    ),
    ChipData(
      value: 'Advanced',
      label: 'Advanced',
      isSelected: false,
      filter: 'difficulty',
    ),
  ],
  'estimatedTime': [
    ChipData(
      value: '1,19',
      label: '< 20 min',
      isSelected: false,
      filter: 'estimatedTime',
    ),
    ChipData(
      value: '20,40',
      label: '20-40 min',
      isSelected: false,
      filter: 'estimatedTime',
    ),
    ChipData(
      value: '40,50',
      label: '40-50 min',
      isSelected: false,
      filter: 'estimatedTime',
    ),
  ],
  'equipment': [
    ChipData(
      value: 'No equipment',
      label: 'No equipment',
      isSelected: false,
      filter: 'equipment',
    ),
    ChipData(
      value: 'Kettlebell',
      label: 'Kettlebell',
      isSelected: false,
      filter: 'equipment',
    ),
    ChipData(
      value: 'Barbell',
      label: 'Barbell',
      isSelected: false,
      filter: 'equipment',
    ),
    ChipData(
      value: 'Air Bike',
      label: 'Air Bike',
      isSelected: false,
      filter: 'equipment',
    ),
    ChipData(
      value: 'Rowing Machine',
      label: 'Rowing Machine',
      isSelected: false,
      filter: 'equipment',
    ),
    ChipData(
      value: 'Pull-up Bar',
      label: 'Pull-up Bar',
      isSelected: false,
      filter: 'equipment',
    ),
    ChipData(
      value: 'Dumbbells',
      label: 'Dumbbells',
      isSelected: false,
      filter: 'equipment',
    ),
  ],
};

import 'package:workout_data/data.dart';
import 'package:workout_use_case/use_case.dart';

class WorkoutListUseCaseImpl implements WorkoutListUseCase {
  final WorkoutRepository repository;

  WorkoutListUseCaseImpl(this.repository);

  @override
  Future<List<WorkoutModel>> getWorkouts() {
    return repository.fetchWorkouts().then((dtoList) => dtoList.map((e) =>
      _convertWorkoutDto(e)).toList());
  }

  @override
  Future<WorkoutModel> getWorkoutById(int id) {
    return repository.fetchWorkoutById(id).then((e) => _convertWorkoutDto(e));
  }

  WorkoutModel _convertWorkoutDto(WorkoutDto dto) {
    final workout = WorkoutModel(
      id: dto.id,
      plan: dto.plan,
      image: dto.image,
      badge: dto.badge,
      estimatedTime: dto.estimatedTime,
      priorityStage: fromStringToWorkoutStageEnum(dto.priorityStage),
      equipment: dto.equipment,
      stages: dto.stages.map((stageDto) => _convertWorkoutStageDto(stageDto)).toList(),
      difficultyLevel: dto.difficultyLevel,
      theme: dto.theme,
    );

    return workout;
  }

  WorkoutStageModel _convertWorkoutStageDto(WorkoutStageDto dto) {
    final workoutStage = WorkoutStageModel(
      stageName: fromStringToWorkoutStageEnum(dto.stageName),
      stageType: fromStringToWorkoutStageTypeEnum(dto.stageType),
      stageOption: _convertStageOptionDto(dto.stageOption),
      exercises: dto.exercises.map((e) => _convertExerciseDto(e)).toList(),
    );
    return workoutStage;
  }

  StageOption _convertStageOptionDto(StageOptionDto dto) {
    final stageOption = StageOption(
      metricType: dto.metricType,
      metricQuantity: dto.metricQuantity,
      rests: dto.rests.map((e) => _convertRestDto(e)).toList(),
    );
    return stageOption;
  }

  Rest _convertRestDto(RestDto dto) {
    final rest = Rest(order: dto.order, quantity: dto.quantity);
    return rest;
  }

  ExerciseModel _convertExerciseDto(ExerciseDto dto) {
    final exercise = ExerciseModel(
      type: dto.type,
      video480: dto.video480,
      video720: dto.video720,
      video1080: dto.video1080,
      tag: dto.tag,
      metrics: dto.metrics,
      name: dto.name,
      quantity: dto.quantity,
      image: dto.image,
      videoVertical: dto.videoVertical,
    );
    return exercise;
  }
}

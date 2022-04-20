import '../program_progress_dto.dart';
import 'feed_program_list_item_response.dart';

class CurrentProgramLimitedResponse {
  final String id;
  final String name;
  final String image;
  final String session;
  final String goal;
  final List<LevelType> levels;
  final List<String> equipment;
  final ProgramProgressDto programProgress;

  CurrentProgramLimitedResponse({
    this.equipment,
    this.goal,
    this.id,
    this.session,
    this.levels,
    this.name,
    this.image,
    this.programProgress,
  });

  CurrentProgramLimitedResponse.fromJson(json)
      : equipment = (json["equipment"] as List).map((e) => e.toString()).toList(),
        programProgress = ProgramProgressDto.fromJson(json["workoutsProgress"]),
        goal = json["goal"],
        name = json["name"],
        image = json["image"],
        id = json["id"],
        levels = (json["levels"] as List).map((e) => LevelType.fromJson(e)).toList(),
        session = json["session"];
}

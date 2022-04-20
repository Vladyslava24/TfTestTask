class WorkoutSettingsItem {
  final WorkoutSettingsIds id;
  final String label;
  bool value;

  WorkoutSettingsItem({
    required this.id,
    required this.label,
    this.value = false
  });

  static WorkoutSettingsIds convertToEnum(String id) {
    switch(id) {
      case 'WorkoutSettingsIds.turnOffWarmUp':
        return WorkoutSettingsIds.turnOffWarmUp;
      case 'WorkoutSettingsIds.turnOffCoolDown':
        return WorkoutSettingsIds.turnOffCoolDown;
      case 'WorkoutSettingsIds.voiceAndSound':
        return WorkoutSettingsIds.voiceAndSound;
      case 'WorkoutSettingsIds.voiceAndMusic':
        return WorkoutSettingsIds.voiceAndMusic;
      case 'WorkoutSettingsIds.onlyMusic':
        return WorkoutSettingsIds.onlyMusic;
      default:
        return WorkoutSettingsIds.unknown;
    }
  }
}

enum WorkoutSettingsIds {
  turnOffWarmUp, turnOffCoolDown, voiceAndSound, voiceAndMusic, onlyMusic, unknown
}
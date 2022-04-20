class PushNotificationsSettingsResponse {
  final bool wod;
  final bool dailyReading;
  final bool updatesAndNews;

  PushNotificationsSettingsResponse({
    this.wod,
    this.dailyReading,
    this.updatesAndNews
  });

  PushNotificationsSettingsResponse.fromJson(jsonMap) :
    wod = jsonMap['wod'],
    dailyReading = jsonMap['dailyReading'],
    updatesAndNews = jsonMap['updatesAndNews'];
}
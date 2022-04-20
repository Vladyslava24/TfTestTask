class Country {
  final String name;
  final String countryCode;
  final String languageCode;

  Country({this.name, this.countryCode, this.languageCode});

  Country.fromJson(Map json)
      : name = json["name"],
        countryCode = json["code"],
        languageCode = json["languageCode"];
}

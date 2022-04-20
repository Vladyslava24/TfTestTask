class UpdateProfileRequest {
  final int height;
  final int weight;
  final int goalWeight;
  final String birthday;
  final String firstName;
  final String lastName;
  final String gender;
  final String photo;
  final String preferredHighMetric;
  final String preferredWeightMetric;
  final Location location;

  UpdateProfileRequest({
    this.height,
    this.weight,
    this.birthday,
    this.firstName,
    this.lastName,
    this.gender,
    this.photo,
    this.location,
    this.goalWeight,
    this.preferredHighMetric,
    this.preferredWeightMetric,
  });

  Map<String, dynamic> toMap() => {
        "height": height,
        "weight": weight,
        "birthday": birthday,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "goalWeight": goalWeight,
        "preferredHighMetric": preferredHighMetric,
        "preferredWeightMetric": preferredWeightMetric,
        "location": location != null ? location.toMap() : null,
        "photo": photo,
      };
}

class Location {
  final String city;
  final String country;

  Location({this.city, this.country});

  Map<String, dynamic> toMap() => {
        "city": city,
        "country": country,
      };

  Location.fromJson(json)
      : country = json["country"],
        city = json["city"];
}

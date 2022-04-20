/*
class Role {
  RoleName name;

  Role({this.name});

  static const String table_name = "role";

  static const String field_name = "roleName";

  Role.fromJson(json) : name = RoleName.fromString(json[field_name]);

  Map<String, dynamic> toJson() => {field_name: name.toString()};

  int get hashCode => name.hashCode;

  @override
  bool operator ==(other) {
    final Role otherRole = other;
    return name == otherRole.name;
  }

  Role copyWith({String name}) {
    return Role(name: name ?? this.name);
  }
}

class RoleName {
  static const ATHLETE = RoleName("ATHLETE");

  final String _name;

  const RoleName(this._name);

  @override
  String toString() {
    return _name;
  }

  static List<RoleName> _swatch = <RoleName>[ATHLETE];

  static RoleName fromString(String requestedRoleName) {
    for (final roleName in _swatch) {
      if (roleName._name == requestedRoleName) {
        return roleName;
      }
    }
    throw Exception("No Status for $requestedRoleName");
  }

  int get hashCode => _name.hashCode;

  @override
  bool operator ==(other) {
    final RoleName otherRoleName = other;
    return _name == otherRoleName._name;
  }
}
*/

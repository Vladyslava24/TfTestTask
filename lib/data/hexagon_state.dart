class HexagonState {
  final int body;
  final int mind;
  final int spirit;

  HexagonState({this.body = 0, this.mind = 0, this.spirit = 0});

  HexagonState.fromMap(jsonMap)
      : body = jsonMap["body"] ?? 0,
        mind = jsonMap["mind"] ?? 0,
        spirit = jsonMap["spirit"] ?? 0;

  int get hashCode => body.hashCode ^ mind.hashCode ^ spirit.hashCode;

  bool isFilled() => body == 100 && mind == 100 && spirit == 100;

  @override
  bool operator ==(Object other) =>
      other is HexagonState &&
      runtimeType == other.runtimeType &&
      body == other.body &&
      mind == other.mind &&
      spirit == other.spirit;

  @override
  String toString() => "body: $body, mind: $mind, spirit: $spirit";
}

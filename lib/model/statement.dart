class Statement {
  final String id;
  final String statement;
  bool completed;

  Statement({this.id, this.statement, this.completed});

  Statement.fromMap(json)
      : id = json['id'],
        statement = json['statement'],
        completed = json['completed'];

  Statement copyWith({
    String id,
    String statement,
    bool completed,
  }) {
    return Statement(
      id: id ?? this.id,
      statement: statement ?? this.statement,
      completed: completed ?? this.completed,
    );
  }

  int get hashCode => id.hashCode ^ statement.hashCode ^ completed.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Statement && id == other.id && statement == other.statement && completed == other.completed;
}

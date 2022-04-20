class StatementResponse {
  String id;
  bool completed;
  String statement;

  StatementResponse.fromMap(jsonMap)
      : id = jsonMap["id"],
        completed = jsonMap["completed"],
        statement = jsonMap["statement"];
}

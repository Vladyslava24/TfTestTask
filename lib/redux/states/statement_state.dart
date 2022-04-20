import 'package:totalfit/model/statement.dart';
import 'package:totalfit/ui/utils/utils.dart';

class StatementState {
  List<Statement> statements;

  StatementState({this.statements});

  StatementState copyWith({List<StatementState> statements}) {
    return StatementState(
      statements: statements ?? this.statements,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatementState && runtimeType == other.runtimeType && deepEquals(statements, other.statements);

  @override
  int get hashCode => deepHash(statements);
}

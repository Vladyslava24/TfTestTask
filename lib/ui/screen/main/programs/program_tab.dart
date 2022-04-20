import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/programs/progress/program_progress_page.dart';
import 'package:totalfit/ui/screen/main/programs/setup/choose_program/choose_program_screen.dart';

class ProgramTab extends StatefulWidget {
  const ProgramTab({Key key}) : super(key: key);

  @override
  _ProgramTabState createState() => _ProgramTabState();
}

class _ProgramTabState extends State<ProgramTab> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ProgramPageViewModel>(
      distinct: true,
      converter: _ProgramPageViewModel.fromStore,
      builder: (context, vm) => vm.hasActiveProgram == null
          ? Container()
          : vm.hasActiveProgram
              ? const ProgramProgressPage()
              : const ChooseProgramScreen(),
    );
  }
}

class _ProgramPageViewModel {
  bool hasActiveProgram;

  _ProgramPageViewModel({
    @required this.hasActiveProgram,
  });

  // ProgramRequestException
  static _ProgramPageViewModel fromStore(Store<AppState> store) {
    return _ProgramPageViewModel(hasActiveProgram: store.state.mainPageState.hasActiveProgram);
  }
}

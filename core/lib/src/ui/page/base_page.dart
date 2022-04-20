import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BasePage<S, T extends BlocBase<S>> extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  T createBloc();

  initBloc(T bloc) {}

  bool buildWhen(S previous, S current, BuildContext context) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) {
          final bloc = createBloc();
          initBloc(bloc);
          return bloc;
        },
        child: Builder(
          builder: (cubitContext) => BlocBuilder<T, S>(
              buildWhen: (previous, current) =>
                  buildWhen(previous, current, cubitContext),
              builder: (cubitContext, state) {
                final bloc = getBloc(cubitContext);
                return Stack(children: [
                  buildPage(cubitContext, bloc, state),
                ]);
              }),
        ));
  }

  Widget buildPage(BuildContext context, T bloc, S state);

  T getBloc(BuildContext context) {
    return context.read<T>();
  }
}

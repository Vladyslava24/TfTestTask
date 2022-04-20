import 'package:core/core.dart';
import 'package:core/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_ui/l10n/mood_localizations.dart';
import 'package:mood_ui/src/bloc/mood_bloc.dart';
import 'package:mood_ui/src/utils/ui_utils.dart';
import 'package:mood_ui/src/widget/empty/empty_widget.dart';
import 'package:mood_ui/src/widget/loader/category_mood_skeleton.dart';
import 'package:mood_ui/src/widget/step/category_widget.dart';
import 'package:mood_ui/src/widget/step/reason_selection_widget.dart';
import 'package:mood_ui/src/widget/step/selection_widget.dart';
import 'package:mood_usecase/mood_usecase.dart';
import 'package:ui_kit/ui_kit.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({Key? key}) : super(key: key);

  @override
  _MoodScreenState createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> with AutomaticKeepAliveClientMixin {

  static const int _pageAnimationDuration = 450;

  int _currentPage = 0;

  RadialGradient? _gradient;

  final PageController _pageController = PageController();

  late MoodBloc _moodBloc;

  final MoodLocalizations _moodLocalizations =
    DependencyProvider.get<MoodLocalizations>();

  @override
  void initState() {
    super.initState();
    _moodBloc = MoodBloc(
      moodUseCase: DependencyProvider.get<MoodUseCase>()
    )..add(FetchMoodData());
  }

  @override
  void dispose() {
    _moodBloc.close();
    super.dispose();
  }

  void enableGradient() {
    setState(() {
      _gradient = RadialGradient(
        radius: cardBorderRadius,
        center: const Alignment(0.0, -1.6),
        colors: <Color>[
          getGradientColor(),
          getGradientColor().withOpacity(0),
          AppColorScheme.colorBlack2.withOpacity(0.1),
        ],
        stops: const <double>[0.025, .125, 0.0],
      );
    });
  }

  void nextPage() {
    final nextPage = _pageController.page!.toInt() + 1;
    animateToPage(nextPage);
  }

  void prevPage() {
    final nextPage = _pageController.page!.toInt() - 1;
    animateToPage(nextPage);
  }

  void animateToPage(int nextPage) {
    setState(() {
      _currentPage = nextPage;
    });
    _pageController.animateToPage(nextPage,
        duration: const Duration(milliseconds: _pageAnimationDuration),
        curve: Curves.easeInOut
    );
  }

  Color getGradientColor() {
    return Color(convertColor(_moodBloc.state.moodData!.feelingsGroups.singleWhere((e) =>
    e.id == _moodBloc.state.feelingsGroupId).color));
  }

  String getTitle(BuildContext context) {
    final category = _currentPage != 0 ?
      _moodBloc.state.moodData!.feelingsGroups.singleWhere((e) =>
        e.id == _moodBloc.state.feelingsGroupId).name : '';

    return _currentPage == 0 ?
      _moodLocalizations.moodScreenTitle :
      '${_moodLocalizations.moodScreenStepTitle} $category';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: _moodBloc,
      child: Container(
        color: AppColorScheme.colorBlack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: _gradient,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: SimpleAppBar(
              leadingAction: () => _currentPage == 0 ?
              Navigator.of(context).pop() : prevPage(),
              leadingType: LeadingType.back,
              title: getTitle(context),
            ),
            body: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    if (index == 0) {
                      setState(() {
                        _gradient = null;
                      });
                    } else if (index == 1) {
                      Future.delayed(const Duration(milliseconds: 150), enableGradient);
                    }
                  },
                  children: [
                    BlocBuilder<MoodBloc, MoodState>(
                      builder: (_, state) {
                        if (state.statusMoodData == MoodLoadingStatus.notLoaded) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.error!,
                                  style: textRegular16.copyWith(
                                    color: AppColorScheme.colorPrimaryWhite
                                  )
                                ),
                                const SizedBox(height: 32.0),
                                BaseElevatedButton(
                                  width: 120.0,
                                  text: S.of(context).all__retry,
                                  onPressed: () => _moodBloc.add(FetchMoodData())
                                )
                              ],
                            ),
                          );
                        }

                        if (state.statusMoodData == MoodLoadingStatus.loaded &&
                            state.moodData != null &&
                            state.moodData!.feelingsGroups.isNotEmpty) {

                          return CategoryWidget(
                            groups: state.moodData!.feelingsGroups,
                            onSelect: (id) {
                              print('selected mood category: $id');
                              _moodBloc.add(
                                ChangeFeelingsGroupId(
                                  id: id,
                                  moodState: state
                                )
                              );
                              nextPage();
                            }
                          );
                        }

                        if (state.moodData != null &&
                        state.moodData!.feelingsGroups.isEmpty) {
                          EmptyWidget(
                            text: _moodLocalizations.moodScreenEmptyCategory
                          );
                        }

                        return const SizedBox();
                      }
                    ),
                    BlocBuilder<MoodBloc, MoodState>(
                      builder: (_, state) {
                        if (state.moodData != null &&
                            state.moodData!.feelingsGroups.isNotEmpty) {
                          final currentFeelingsGroup =
                          state.moodData!.feelingsGroups.singleWhere((e) =>
                          e.id == state.feelingsGroupId);

                          return SelectionWidget(
                            image: currentFeelingsGroup.image,
                            title: _moodLocalizations.moodScreenSelectionDescription,
                            items: currentFeelingsGroup.feelings,
                            onSelect: (id) {
                              print('selected mood item: $id');
                              _moodBloc.add(
                                ChangeFeelingId(id: id, moodState: state));
                              nextPage();
                            },
                          );
                        }
                        return EmptyWidget(
                          text: _moodLocalizations.moodScreenEmptySelection
                        );
                      }
                    ),
                    BlocConsumer<MoodBloc, MoodState>(
                      listener: (context, state) {
                        if (state.sendStatus == SendStatus.success &&
                            state.moodResponse != null) {
                          Navigator.of(context).pop(state.moodResponse!.toJson());
                        } else if (state.sendStatus == SendStatus.success &&
                            state.moodResponse == null) {
                          Navigator.of(context).pop();
                        }

                        if (state.sendStatus == SendStatus.failure) {
                          final result = TfDialog.show(context, TfDialogAttributes(
                            title: _moodLocalizations.moodDialogErrorTitle,
                            description: state.sendError!.toString(),
                            positiveText: S.of(context).all__retry,
                            negativeText: S.of(context).all__cancel,
                          ));

                          result.then((data) {
                           if (data is Confirm) {
                             _moodBloc.add(ChangeMoodReasonsIds(
                               ids: List<int>.of(state.moodReasonsIds!),
                               moodState: state
                             ));
                           }
                          });
                        }
                      },
                      builder: (_, state) {

                        if (state.sendStatus == SendStatus.sending) {

                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColorScheme.colorYellow, strokeWidth: 2.0
                            ),
                          );
                        }

                        if (state.moodData != null &&
                            state.moodData!.reasons.isNotEmpty) {

                          final currentFeelingsGroup =
                          state.moodData!.feelingsGroups.singleWhere((e) =>
                          e.id == state.feelingsGroupId);

                          return ReasonSelectionWidget(
                            image: currentFeelingsGroup.image,
                            title: _moodLocalizations.moodScreenReasonDescription,
                            reasons: state.moodData!.reasons,
                            changeReason: (id) {
                              print('selected reason: $id');
                              _moodBloc.add(ChangeReason(id: id, moodState: state));
                            },
                            onSave: (list) async {
                              _moodBloc.add(
                                ChangeMoodReasonsIds(
                                  ids: List<int>.of(list),
                                  moodState: state
                                )
                              );
                            },
                          );
                        }

                        return EmptyWidget(
                          text: _moodLocalizations.moodScreenEmptyReason
                        );
                      }
                    ),
                  ],
                ),
                BlocBuilder<MoodBloc, MoodState>(
                  builder: (_, state) {
                    if (state.statusMoodData == MoodLoadingStatus.loading) {
                      return Positioned.fill(
                        child: CategoryMoodSkeleton()
                      );
                    }
                    return const SizedBox();
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/model/statement.dart';
import 'package:totalfit/ui/widgets/measure_size.dart';
import 'package:ui_kit/ui_kit.dart';

class StoryAndStatementsListItemWidget extends StatefulWidget {
  final StoryAndStatementListItem item;
  final VoidCallback onStorySelected;
  final Function(Statement) onStatementChanged;
  final bool isClickable;
  final Key key;

  StoryAndStatementsListItemWidget({
    @required this.item,
    @required this.onStorySelected,
    @required this.onStatementChanged,
    @required this.isClickable,
    @required this.key,
  }) : super(key: key);

  @override
  _StoryAndStatementsListItemWidgetState createState() =>
      _StoryAndStatementsListItemWidgetState();
}

class _StoryAndStatementsListItemWidgetState
    extends State<StoryAndStatementsListItemWidget> {
  double _imageHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildTitle(), _buildContent()],
    );
  }

  Widget _buildTitle() =>
    widget.item.storyModel.id != null ||
    widget.item.storyModel.isRead ||
    widget.item.storyModel.statements.isNotEmpty ? Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 11),
    child: Row(
      children: <Widget>[
        SvgPicture.asset(
          spiritHexIc,
          width: 18,
          height: 18,
        ),
        const SizedBox(width: 11),
        Text(
          S.of(context).develop_your_spirit,
          textAlign: TextAlign.left,
          style: title20.copyWith(
            color: AppColorScheme.colorPrimaryWhite,
            letterSpacing: 0.015,
          ),
        ),
      ],
    ),
  ) : Container();

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 16, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.item.storyModel.id != null ? Row(
            children: [
              Container(
                width: 16,
                height: 16,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: widget.item.storyModel.isRead
                            ? AppColorScheme.colorBlue2
                            : Colors.transparent,
                        border: Border.all(
                          color: AppColorScheme.colorBlue2,
                          width: 2,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 2.5,
                      child: Opacity(
                        opacity: widget.item.storyModel.isRead ? 1.0 : 0.0,
                        child: SvgPicture.asset(
                          checkIc,
                          width: 12,
                          height: 9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        if (widget.isClickable &&
                            widget.item.storyModel != null) {
                          widget.onStorySelected();
                        }
                      },
                      child: MeasureSize(
                        onChange: (size) {
                          setState(() {
                            _imageHeight = size.height;
                          });
                        },
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(cardBorderRadius),
                            child: Stack(
                              children: <Widget>[
                                widget.item.storyModel == null
                                    ? Container()
                                    : Align(
                                        alignment: Alignment.centerRight,
                                        child: _imageHeight != null
                                            ? ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                  widget.item.storyModel.isRead
                                                      ? AppColorScheme
                                                          .colorPrimaryBlack
                                                      : Colors.transparent,
                                                  BlendMode.saturation,
                                                ),
                                                child: TfImage(
                                                  url: widget
                                                      .item.storyModel.image,
                                                  fit: BoxFit.cover,
                                                  height: _imageHeight,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                ),
                                              )
                                            : Container(),
                                      ),
                                Container(
                                  height: 178,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0, -1),
                                      end: Alignment(0, 0),
                                      stops: [
                                        0.28,
                                        1,
                                      ],
                                      colors: [
                                        AppColorScheme.colorBlack2
                                            .withOpacity(0),
                                        AppColorScheme.colorBlack2
                                            .withOpacity(0.3),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 178,
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        widget.item.storyModel == null
                                            ? ""
                                            : "${S.of(context).story} • ${widget.item.storyModel.estimatedReadingTime} ${S.of(context).min_read}"
                                                .toUpperCase(),
                                        textAlign: TextAlign.left,
                                        style: textRegular10.copyWith(
                                          letterSpacing: 0.05,
                                          color:
                                              AppColorScheme.colorPrimaryWhite,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        widget.item.storyModel == null
                                            ? ""
                                            : widget.item.storyModel.name,
                                        textAlign: TextAlign.left,
                                        style: title16.copyWith(
                                          color:
                                              AppColorScheme.colorPrimaryWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ) : Container(),
          widget.item.storyModel.isRead &&
                  widget.item.storyModel.statements.isNotEmpty
              ? Container(
                  padding: EdgeInsets.only(top: 20, left: 28),
                  child: Text(
                    S.of(context).statements,
                    textAlign: TextAlign.left,
                    style: title16.copyWith(
                      color: AppColorScheme.colorPrimaryWhite,
                    ),
                  ),
                )
              : Container(),
          widget.item.storyModel.statements.isNotEmpty
              ? _buildStatements()
              : Container(),
        ],
      ),
    );
  }

  Widget _buildStatements() {
    List<Widget> items = [];
    items.add(Container(
      height: 12,
    ));
    items.addAll(widget.item.storyModel.statements
        .map((e) => _buildStatement(e))
        .toList());
    return Column(children: items);
  }

  Widget _buildStatement(Statement statement) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          child: GestureDetector(
            onTap: () {
              if (widget.isClickable && !statement.completed) {
                widget.onStatementChanged(
                    statement.copyWith(completed: !statement.completed));
              }
            },
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: statement.completed
                              ? AppColorScheme.colorBlue2
                              : Colors.transparent,
                          border: Border.all(
                            color: AppColorScheme.colorBlue2,
                            width: 2,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        left: 2.5,
                        child: Opacity(
                          opacity: statement.completed ? 1.0 : 0.0,
                          child: SvgPicture.asset(
                            checkIc,
                            width: 12,
                            height: 9,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                    child: Container(
                      color: AppColorScheme.colorBlack2,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text(
                        statement.statement,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: textRegular16.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

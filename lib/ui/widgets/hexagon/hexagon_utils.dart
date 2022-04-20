import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:ui_kit/ui_kit.dart';

///    Cистема измерений для самой первой тренировки:
///    1 Разминка = 10% от Физической
///    1 Вопросы
///    - How are you feel today?  = 40% от эмоциональной
///    - What are you thankful for? = 30% от эмоциональной
///    - What is stressing you out? = 30%  от эмоциональной
///    2 Skill
///    Прошел навык и оценил технику
///    = 10% от физической
///    = 30% от интеллектуальной
///    3 WOD = 70% от физической
///    Заполнил результат = 10% интеллектуальной
///    4 Cooldown = 10% от физической
///    5 Story
///    Прочтение истории 70% от духовной
///    Написал I will statement 30%
///
///

class MetaHexSegment {
  final int index;
  final String name;
  final Color color;
  final IconData icon;

  const MetaHexSegment._({
    @required this.index,
    @required this.name,
    @required this.color,
    @required this.icon
  });

  static const BODY = MetaHexSegment._(
    index: 0,
    name: "Body",
    color: AppColorScheme.colorYellow,
    icon: HexagonIcons.ic_body
  );

  static const MIND = MetaHexSegment._(
    index: 1,
    name: "Mind",
    color: AppColorScheme.colorPurple2,
    icon: HexagonIcons.ic_brain
  );

  static const SPIRIT = MetaHexSegment._(
    index: 2,
    name: "Spirit",
    color: AppColorScheme.colorBlue2,
    icon: HexagonIcons.ic_spirit
  );
}

Map<MetaHexSegment, double> emptySegments() => {
  MetaHexSegment.BODY: 0,
  MetaHexSegment.MIND: 0,
  MetaHexSegment.SPIRIT: 0
};

enum HexagonParam { bodyEnvironment, socialIntellectual, spiritualEmotional }

Map<HexagonParam, int> toRiveHexagonParam(Map<MetaHexSegment, double> rateMap) {

  Map<HexagonParam, int> map = {
    HexagonParam.bodyEnvironment: rateMap[MetaHexSegment.BODY].toInt(),
    HexagonParam.socialIntellectual: rateMap[MetaHexSegment.MIND].toInt(),
    HexagonParam.spiritualEmotional: rateMap[MetaHexSegment.SPIRIT].toInt(),
  };
  return map;
}
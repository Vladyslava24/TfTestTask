import 'package:flutter/material.dart';
import 'package:totalfit/model/explore/explore_feature_model.dart';
import 'package:totalfit/ui/widgets/explore/explore_feature_widget.dart';

class ExploreFeaturesWidget extends StatelessWidget {
  final List<ExploreFeatureModel> features;

  const ExploreFeaturesWidget({
    this.features = const [],
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Expanded(
                child: ExploreFeatureWidget(
                  featureIcon: FeatureIcon.top,
                  icon: features.first.getIcon(features.first.type),
                  title: features.first.title,
                  description: features.first.description,
                  action: features.first.action,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: ExploreFeatureWidget(
                  featureIcon: FeatureIcon.top,
                  icon: features[1].getIcon(features[1].type),
                  title: features[1].title,
                  description: features[1].description,
                  action: features[1].action,
                ),
              )
            ],
          ),
        ),
        ExploreFeatureWidget(
          featureIcon: FeatureIcon.left,
          icon: features.last.getIcon(features.last.type),
          title: features.last.title,
          description: features.last.description,
          action: features.last.action,
        ),
      ],
    );
  }
}

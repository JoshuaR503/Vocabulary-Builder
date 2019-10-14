import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/widgets/text/styles.dart';

class CommonSubtitle extends StatelessWidget {

  final String subTitle;

  CommonSubtitle(this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, bottom: 10),
      child: Text(
        subTitle,
        style: TextStyles.commonSubtitleStyle
      ),
    );
  }
}

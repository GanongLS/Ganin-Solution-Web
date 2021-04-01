import 'package:flutter/material.dart';

import 'widgets.dart';

class BasicHeading extends StatelessWidget {
  const BasicHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    final String title = "Basic Competence";
    final String subtitle = "Everyone need basic skill";
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize.height * 0.06,
        left: screenSize.width / 15,
        right: screenSize.width / 15,
      ),
      child: ResponsiveWidget.isSmallScreen(context)
          ? SmallBasicHeading(title: title, subtitle: subtitle)
          : MedBasicHeading(title: title, subtitle: subtitle),
    );
  }
}

class MedBasicHeading extends StatelessWidget {
  final String title;
  final String subtitle;
  const MedBasicHeading({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            subtitle,
            textAlign: TextAlign.end,
            style: Theme.of(context).primaryTextTheme.subtitle1,
          ),
        ),
      ],
    );
  }
}

class SmallBasicHeading extends StatelessWidget {
  final String title;
  final String subtitle;
  const SmallBasicHeading({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          subtitle,
          textAlign: TextAlign.end,
          style: Theme.of(context).primaryTextTheme.subtitle1,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

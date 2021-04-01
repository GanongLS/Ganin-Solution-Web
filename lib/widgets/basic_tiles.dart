import 'package:flutter/material.dart';

import 'widgets.dart';

class BasicTiles extends StatelessWidget {
  BasicTiles({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  final List<String> assets = [
    'assets/images/wol_20p.jpg',
    'assets/images/self_dev.jpeg',
    'assets/images/communication.jpg',
    'assets/images/presentation.jpg',
  ];

  // final List<String> title = ['Trekking', 'Animals', 'Photography'];
  final List<String> title = [
    'Way of Life',
    'Self Development',
    'Communication',
    'Marketing & Presentation',
    'Products & Services',
    'Financial & Invesation',
    'Law & Legal',
    'Streng, Authority & Power',
    'Politics, Scheme & Strategies',
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? SmallBasicFormation(
            screenSize: screenSize, assets: assets, title: title)
        : MedBasicFormation(
            screenSize: screenSize, assets: assets, title: title);
  }
}

class MedBasicFormation extends StatelessWidget {
  const MedBasicFormation({
    Key? key,
    required this.screenSize,
    required this.assets,
    required this.title,
  }) : super(key: key);

  final Size screenSize;
  final List<String> assets;
  final List<String> title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize.height * 0.06,
        // left: screenSize.width * 0.05,
        // right: screenSize.width * 0.05,
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: screenSize.width * 0.025,
        runAlignment: WrapAlignment.spaceBetween,
        runSpacing: screenSize.width * 0.04,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...Iterable<int>.generate(assets.length).map(
            (int pageIndex) => Column(
              children: [
                SizedBox(
                  height: screenSize.width * 0.16,
                  width: screenSize.width * 0.25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset(
                      assets[pageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenSize.height * 0.014,
                  ),
                  child: Text(
                    title[pageIndex],
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color:
                          Theme.of(context).primaryTextTheme.subtitle1!.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SmallBasicFormation extends StatelessWidget {
  const SmallBasicFormation({
    Key? key,
    required this.screenSize,
    required this.assets,
    required this.title,
  }) : super(key: key);

  final Size screenSize;
  final List<String> assets;
  final List<String> title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: screenSize.height / 50),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: screenSize.width / 15),
              ...assets
                  .map((item) {
                    final int index = assets.indexOf(item);
                    return BasicCard(
                        screenSize: screenSize,
                        image: assets[index],
                        title: title[index]);
                  })
                  .toList()
                  .cast<Widget>()
            ]),
      ),
    );
  }
}

class BasicCard extends StatelessWidget {
  const BasicCard({
    Key? key,
    required this.screenSize,
    required this.image,
    required this.title,
  }) : super(key: key);

  final Size screenSize;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenSize.width / 2.5,
              width: screenSize.width / 1.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenSize.height / 70,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryTextTheme.subtitle1!.color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: screenSize.width / 15),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'widgets.dart';

class FloatingQuickAccessBar extends StatefulWidget {
  const FloatingQuickAccessBar({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  _FloatingQuickAccessBarState createState() => _FloatingQuickAccessBarState();
}

class _FloatingQuickAccessBarState extends State<FloatingQuickAccessBar> {
  List<Widget> rowElements = [];

  List<String> items = [
    'Vision',
    'Data',
    'Information',
    'Knowlegde',
    'Experience',
    'Skill',
    'Competence'
  ];
  List<IconData> icons = [
    Icons.policy,
    Icons.analytics_outlined,
    Icons.addchart,
    Icons.library_books,
    Icons.date_range,
    Icons.engineering,
    Icons.api
  ];

  List<Widget> generateRowElements() {
    rowElements.clear();
    for (int i = 0; i < items.length; i++) {
      Widget elementTile = TileMenu(title: items[i]);
      Widget spacer = SizedBox(
        height: widget.screenSize.height / 20,
        child: VerticalDivider(
          width: 1,
          color: Colors.blueGrey[100],
          thickness: 1,
        ),
      );
      rowElements.add(elementTile);
      if (i < items.length - 1) {
        rowElements.add(spacer);
      }
    }

    return rowElements;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.screenSize.height * 0.40,
          left: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width * 0.04
              : widget.screenSize.width * 0.1,
          right: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width * 0.04
              : widget.screenSize.width * 0.1,
        ),
        child: ResponsiveWidget.isSmallScreen(context)
            ? generateColumnElements(context)
            : Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: widget.screenSize.height / 50,
                    bottom: widget.screenSize.height / 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: generateRowElements(),
                  ),
                ),
              ),
      ),
    );
  }

  Column generateColumnElements(BuildContext context) {
    return Column(
      children: [
        ...Iterable<int>.generate(items.length).map(
          (int pageIndex) => Padding(
            padding: EdgeInsets.only(top: widget.screenSize.height / 80),
            child: Card(
              color: Theme.of(context).cardColor,
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.only(
                    top: widget.screenSize.height * 0.022,
                    bottom: widget.screenSize.height * 0.022,
                    left: widget.screenSize.width * 0.05),
                child: Row(
                  children: [
                    Icon(
                      icons[pageIndex],
                      color: Theme.of(context).iconTheme.color,
                    ),
                    SizedBox(width: widget.screenSize.width / 20),
                    TileMenu(title: items[pageIndex])
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TileMenu extends StatefulWidget {
  final String title;
  TileMenu({Key? key, required this.title}) : super(key: key);

  @override
  _TileMenuState createState() => _TileMenuState();
}

class _TileMenuState extends State<TileMenu> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onHover: (value) {
        setState(() {
          _isHovering = value;
        });
      },
      onTap: () {},
      child: Text(
        widget.title,
        style: TextStyle(color: _isHovering ? Colors.blue : Colors.black),
      ),
    );
  }
}

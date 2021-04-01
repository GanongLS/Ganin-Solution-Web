// main.dart

import 'package:flutter/material.dart';
import 'package:web_02/widgets/widgets.dart';

class HomePage00 extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage00> {
  late ScrollController _scrollController;
  // ignore: unused_field
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: SmallAppBar00(opacity: _opacity))
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: MedTopBar00(
                opacity: _opacity,
              ),
            ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  // image below the top bar
                  child: SizedBox(
                    height: screenSize.height * 0.45,
                    width: screenSize.width,
                    child: Image.asset(
                      'assets/images/blue.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    FloatingQuickAccessBar(screenSize: screenSize),
                    Container(
                      child: Column(
                        children: [
                          BasicHeading(screenSize: screenSize),
                          BasicTiles(screenSize: screenSize)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MedTopBar00 extends StatefulWidget {
  final double opacity;
  MedTopBar00({Key? key, required this.opacity}) : super(key: key);

  @override
  _MedTopBarState createState() => _MedTopBarState();
}

class _MedTopBarState extends State<MedTopBar00> {
  // List _isHovering = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).bottomAppBarColor.withOpacity(widget.opacity),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Text(
              'Ganin Solution',
              style: TextStyle(
                color: Colors.blueGrey[50],
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HoverLineButton00(
                    title: "Discover",
                    onPress: () {
                      Navigator.of(context).pushNamed("/00");
                    },
                  ),
                  SizedBox(width: screenSize.width / 20),
                  HoverLineButton00(
                    title: "Contact Us",
                    onPress: () {
                      Navigator.of(context).pushNamed("/");
                    },
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.brightness_6),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Colors.white,
              hoverColor: Colors.blue[200],
              onPressed: () {
                // EasyDynamicTheme.of(context).changeTheme();
              },
            ),
            SizedBox(width: screenSize.width * 0.02),
            HoveredButton00(title: "Sign Up"),
            SizedBox(width: screenSize.width / 50),
            HoveredButton00(title: "Sign In"),
          ],
        ),
      ),
    );
  }
}

class SmallAppBar00 extends StatelessWidget {
  const SmallAppBar00({
    Key? key,
    required double opacity,
  })   : _opacity = opacity,
        super(key: key);

  final double _opacity;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
      elevation: 0,
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.brightness_6),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            // EasyDynamicTheme.of(context).changeTheme();
          },
        ),
      ],
      title: Text(
        'Ganin Solution',
        style: TextStyle(
          color: Colors.blueGrey[100],
          fontSize: 20,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class HoverLineButton00 extends StatefulWidget {
  final String title;
  final VoidCallback onPress;
  HoverLineButton00({Key? key, required this.title, required this.onPress})
      : super(key: key);

  @override
  _HoverLineButtonState createState() => _HoverLineButtonState();
}

class _HoverLineButtonState extends State<HoverLineButton00> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          _isHovering = value;
        });
      },
      onTap: widget.onPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: _isHovering ? Colors.blue[200] : Colors.white,
            ),
          ),
          SizedBox(height: 5),
          // For showing an underline on hover
          Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: _isHovering,
            child: Container(
              height: 2,
              width: 30,
              // color: Colors.white,
              color: Colors.blue[200],
            ),
          )
        ],
      ),
    );
  }
}

class HoveredButton00 extends StatefulWidget {
  final String title;
  HoveredButton00({Key? key, required this.title}) : super(key: key);

  @override
  _HoveredButtonState createState() => _HoveredButtonState();
}

class _HoveredButtonState extends State<HoveredButton00> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          _isHovering = value;
        });
      },
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: _isHovering ? Colors.blue[200] : Colors.white,
            ),
          ),
          // SizedBox(height: 5),
          // // For showing an underline on hover
          // Visibility(
          //   maintainAnimation: true,
          //   maintainState: true,
          //   maintainSize: true,
          //   visible: _isHovering,
          //   child: Container(
          //     height: 2,
          //     width: 30,
          //     color: Colors.white,
          //   ),
          // )
        ],
      ),
    );
  }
}

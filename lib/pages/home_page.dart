// main.dart

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:web_02/widgets/widgets.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            margin: EdgeInsets.all(5.0),
            width: 700.0,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(item, fit: BoxFit.cover, width: 700.0),
                  ),
                ),
                ImageTextInfo(item: item)
              ],
            ),
          ))
      .toList();

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
              child: SmallAppBar(opacity: _opacity))
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: MedTopBar(
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
                      // height: screenSize.height * 0.4,
                      child: Column(
                        children: [
                          BasicHeading(screenSize: screenSize),
                          Container(
                            width: screenSize.width * 0.8,
                            height: screenSize.height * 0.6,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: screenSize.height * 0.6,
                                viewportFraction: 0.6,
                                aspectRatio: 1.5,
                                enlargeCenterPage: true,
                                pageViewKey:
                                    PageStorageKey<String>('carousel_slider'),
                              ),
                              items: imageSliders,
                            ),
                          ),
                          // BasicTiles(screenSize: screenSize)
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

class ImageTextInfo extends StatelessWidget {
  final String item;
  const ImageTextInfo({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Text(
        'No. ${imgList.indexOf(item)} image',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MedTopBar extends StatefulWidget {
  final double opacity;
  MedTopBar({Key? key, required this.opacity}) : super(key: key);

  @override
  _MedTopBarState createState() => _MedTopBarState();
}

class _MedTopBarState extends State<MedTopBar> {
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
                  HoverLineButton(
                    title: "Discover",
                    onPress: () {
                      Navigator.of(context).pushNamed("/00");
                    },
                  ),
                  SizedBox(width: screenSize.width / 20),
                  HoverLineButton(
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
            HoveredButton(title: "Sign Up"),
            SizedBox(width: screenSize.width / 50),
            HoveredButton(title: "Sign In"),
          ],
        ),
      ),
    );
  }
}

class SmallAppBar extends StatelessWidget {
  const SmallAppBar({
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

class HoverLineButton extends StatefulWidget {
  final String title;
  final VoidCallback onPress;
  HoverLineButton({Key? key, required this.title, required this.onPress})
      : super(key: key);

  @override
  _HoverLineButtonState createState() => _HoverLineButtonState();
}

class _HoverLineButtonState extends State<HoverLineButton> {
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

class HoveredButton extends StatefulWidget {
  final String title;
  HoveredButton({Key? key, required this.title}) : super(key: key);

  @override
  _HoveredButtonState createState() => _HoveredButtonState();
}

class _HoveredButtonState extends State<HoveredButton> {
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

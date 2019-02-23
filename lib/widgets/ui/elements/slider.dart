import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/settings.dart';

class IntroSlider extends StatefulWidget {
  /// An array of Slide object
  final List<Slide> slides;

  // SKIP button
  /// Render your own SKIP button
  final Widget renderSkipBtn;

  /// Fire when press SKIP button
  final Function onSkipPress;

  /// Show or hide SKIP button
  final bool isShowSkipBtn;

  /// Rounded SKIP button
  final double borderRadiusSkipBtn;

  // NEXT, DONE button
  /// Render your own NEXT button
  final Widget renderNextBtn;

  /// Render your own DONE button
  final Widget renderDoneBtn;

  /// Fire when press DONE button
  final Function onDonePress;

  /// Rounded NEXT button
  final double borderRadiusNextBtn;

  /// Rounded DONE button
  final double borderRadiusDoneBtn;

  // Dot indicator
  /// Show or hide dot indicator
  final bool isShowDotIndicator;

  IntroSlider({
    @required this.slides,
    this.renderSkipBtn,
    this.onSkipPress,
    this.isShowSkipBtn,
    this.borderRadiusSkipBtn,
    this.renderNextBtn,
    this.renderDoneBtn,
    this.onDonePress,
    this.borderRadiusNextBtn,
    this.borderRadiusDoneBtn,
    this.isShowDotIndicator,
  });

  @override
  IntroSliderState createState() => new IntroSliderState(
    slides: this.slides,
    renderSkipBtn: this.renderSkipBtn,
    onSkipPress: this.onSkipPress,
    isShowSkipBtn: this.isShowSkipBtn,
    borderRadiusSkipBtn: this.borderRadiusSkipBtn,
    renderNextBtn: this.renderNextBtn,
    renderDoneBtn: this.renderDoneBtn,
    onDonePress: this.onDonePress,
    borderRadiusDoneBtn: this.borderRadiusDoneBtn,
    isShowDotIndicator: this.isShowDotIndicator,
  );
}

class IntroSliderState extends State<IntroSlider> with SingleTickerProviderStateMixin {
  /// An array of Slide object
  final List<Slide> slides;

  // SKIP button
  /// Render your own SKIP button
  Widget renderSkipBtn;

  /// Fire when press SKIP button
  Function onSkipPress;

  /// Show or hide SKIP button
  bool isShowSkipBtn;

  /// Rounded SKIP button
  double borderRadiusSkipBtn;

  // DONE, NEXT button
  /// Render your own NEXT button
  Widget renderNextBtn;

  /// Render your own DONE button
  Widget renderDoneBtn;

  /// Fire when press DONE button
  Function onDonePress;

  /// Rounded NEXT button
  double borderRadiusNextBtn;

  /// Rounded DONE button
  double borderRadiusDoneBtn;

  // Dot indicator
  /// Show or hide dot indicator
  bool isShowDotIndicator = true;

  /// Color for dot when passive
  Color colorDot;

  /// Color for dot when active
  Color colorActiveDot;

  /// Size of each dot
  double sizeDot = 8.0;

  IntroSliderState({
    // List slides
    @required this.slides,

    // Skip button
    @required this.renderSkipBtn,
    @required this.onSkipPress,
    @required this.isShowSkipBtn,
    @required this.borderRadiusSkipBtn,

    // Done button
    @required this.renderNextBtn,
    @required this.renderDoneBtn,
    @required this.onDonePress,
    @required this.borderRadiusDoneBtn,

    // Dot indicator
    @required this.isShowDotIndicator,
    this.colorDot,
    this.colorActiveDot,
    this.sizeDot,
  });

  TabController tabController;

  List<Widget> tabs = List();
  List<Widget> dots = List();
  double fontSize = 14;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: slides.length, vsync: this);
    tabController.addListener(() {
      this.setState(() {});
    });

    // Skip button
    if (onSkipPress == null) {
      onSkipPress = () {};
    }
    if (isShowSkipBtn == null) {
      isShowSkipBtn = true;
    }

    // Done button
    if (onDonePress == null) {
      onDonePress = () {};
    }

    // Dot indicator
    if (isShowDotIndicator == null) {
      isShowDotIndicator = true;
    }
    if (colorDot == null) {
      colorDot = Color(0x80000000);
    }
    if (colorActiveDot == null) {
      colorActiveDot = Color(0xffffffff);
    }
    if (sizeDot == null) {
      sizeDot = 8.0;
    }

    renderListTabs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
      ),
      title: appname,
      home: DefaultTabController(
        length: slides.length,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              TabBarView(
                children: tabs,
                controller: tabController,
              ),
              renderBottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderBottom() {
    return Positioned(
      child: Row(
        children: <Widget>[
          // Skip button
          (tabController.index + 1 != slides.length && isShowSkipBtn)
              ? Container(
                child: FlatButton(
                    onPressed: onSkipPress,
                    child: Text( "SALTAR",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize
                      ),
                    ),
                    color: Colors.transparent,
                    highlightColor: Colors.white.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular( 30.0)
                    ),
                ),

                width: 130.0,
                height: 70.0,
              )
              : Container(
                width: 130.0,
                height: 70.0,
              ),

          // Dot indicator
          Flexible(
            child: isShowDotIndicator
                ? Row(
                    children: renderListDots(),
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                : Container(),
          ),

          // Next, Done button
          Container(

            child: tabController.index + 1 == slides.length
              ? FlatButton(
                onPressed: onDonePress,
                child: Text("LISTO",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize
                  ),
                ),
                color: Colors.transparent,
                highlightColor: Colors.white.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
              )

              : FlatButton(
                onPressed: () => tabController.animateTo(tabController.index + 1),
                child: Text("SIGUIENTE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize
                  ),
                ),
                color: Colors.transparent,
                highlightColor: Colors.white.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
              ),
            width: 130.0,
            height: 70.0,
          ),

        ],
      ),
      bottom: 10.0,
      left: 10.0,
      right: 10.0,
      height: 50.0,
    );
  }

  List<Widget> renderListTabs() {
    for (int i = 0; i < slides.length; i++) {
      tabs.add(
        renderTab(
          slides[i].title,
          slides[i].description,
          slides[i].pathImage,
          slides[i].backgroundColor,
        ),
      );
    }
    return tabs;
  }

  Widget renderTab(
    String title,
    String description,
    String pathImage,
    Color backgroundColor,
  ) {
    return Container(
      width: double.infinity,
      height: double.infinity,

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [backgroundColor, backgroundColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: ListView(
        children: <Widget>[
          Container(
            // Title
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),

              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(top: 70.0, bottom: 70.0, left: 20, right: 20),
          ),

          GestureDetector(
            child: Image.asset(
              pathImage,
              width: 200.0,
              height: 200.0,
              fit: BoxFit.contain,
            )
          ),

          // Description
          Container(
            child: Text(
              description,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          ),
        ],
      ),
    );
  }

  List<Widget> renderListDots() {
    dots.clear();
    for (int i = 0; i < slides.length; i++) {
      Color currentColor;
      if (tabController.index == i) {
        currentColor = colorActiveDot;
      } else {
        currentColor = colorDot;
      }
      dots.add(renderDot(sizeDot, currentColor));
    }
    return dots;
  }

  Widget renderDot(double radius, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(radius / 2)
      ),
      width: radius,
      height: radius,
      margin: EdgeInsets.all(radius / 2),
    );
  }
}

class Slide {
  String title;
  String pathImage;
  String description;
  Color backgroundColor;

  Slide({
    String title,
    String pathImage,
    String description,
    Color backgroundColor,
  }) {
    this.title = title;
    this.pathImage = pathImage;
    this.description = description;
    this.backgroundColor = backgroundColor;
  }
}
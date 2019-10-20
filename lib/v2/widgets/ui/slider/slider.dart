import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/blocs/config/bloc.dart';

class IntroSlider extends StatefulWidget {

  final List<Slide> slides;
  final Widget renderSkipBtn;
  final Function onSkipPress;
  final bool isShowSkipBtn;
  final double borderRadiusSkipBtn;

  final Widget renderNextBtn;
  final Widget renderDoneBtn;
  final Function onDonePress;

  final double borderRadiusNextBtn;
  final double borderRadiusDoneBtn;

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
  IntroSliderState createState() => IntroSliderState(
    slides: this.slides,
    renderSkipBtn: this.renderSkipBtn,
    isShowSkipBtn: this.isShowSkipBtn,
    borderRadiusSkipBtn: this.borderRadiusSkipBtn,
    renderNextBtn: this.renderNextBtn,
    renderDoneBtn: this.renderDoneBtn,
    borderRadiusDoneBtn: this.borderRadiusDoneBtn,
    isShowDotIndicator: this.isShowDotIndicator,
  );
}

class IntroSliderState extends State<IntroSlider> with SingleTickerProviderStateMixin {

  final List<Slide> slides;

  Widget renderSkipBtn;

  bool isShowSkipBtn;
  double borderRadiusSkipBtn;

  Widget renderNextBtn;
  Widget renderDoneBtn;

  double borderRadiusNextBtn;
  double borderRadiusDoneBtn;

  bool isShowDotIndicator = true;

  Color colorDot;
  Color colorActiveDot;

  double sizeDot = 8.0;

  IntroSliderState({
    // List slides
    @required this.slides,

    // Skip button
    @required this.renderSkipBtn,
    @required this.isShowSkipBtn,
    @required this.borderRadiusSkipBtn,

    // Done button
    @required this.renderNextBtn,
    @required this.renderDoneBtn,
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

  void _onTap() {
    BlocProvider
      .of<ConfigBloc>(context)
      .add(SliderSeenEvent());

    Navigator
      .of(context)
      .pushNamed('/');
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: slides.length, vsync: this);
    tabController.addListener(() {
      this.setState(() {});
    });


    if (isShowSkipBtn == null) {
      isShowSkipBtn = true;
    }

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
    return Scaffold(
      body: DefaultTabController(
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
                    onPressed: () {
                      print('Hello');

                      _onTap();
                    },
                    child: Text(FlutterI18n.translate(context, 'slide_show.options.skip'),
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
                onPressed: () {
                  _onTap();
                },
                child: Text(FlutterI18n.translate(context, 'slide_show.options.done'),
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
                child: Text(FlutterI18n.translate(context, 'slide_show.options.next'),
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

  Widget renderTab(String title, String description, String pathImage, Color backgroundColor) {

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

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            margin: EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20, right: 20),
          ),

          GestureDetector(
            child: Container(
              child: Image.asset(
                pathImage,
                width: 230.0,
                height: 230.0,
                fit: BoxFit.contain,
              ),
              margin: EdgeInsets.only(top: 10.0, bottom: 40.0, left: 40, right: 40),
            )
          ),

          // Description
          Container(
            child: Text(
              description,
              style: TextStyle(
                color: Colors.white, 
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(top: 00.0, bottom: 70.0, left: 20, right: 20),
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
        color: color, 
        borderRadius: BorderRadius.circular(radius / 2)
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
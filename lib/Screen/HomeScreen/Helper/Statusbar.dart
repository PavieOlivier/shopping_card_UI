import 'package:flutter/material.dart';
import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/Helpers/Styles.dart';
import 'package:shoppingcard/Screen/HomeScreen/Helper/StatusBarItem.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

///Use it to control the animation of the statu bar intro
class StatusBarController {

  ///The index the status bar is currently
  int currentIndex;
  ///This will hide the status bar by animating it
  Function hideStatusBar;

  ///This will reveal the statusBar by animating it
  Function revealStatusBar;

  ///THis will hide the icons by changing their opacity to 0
  Function hideOpacity;

  ///THis will reveal the icons by changing their opacity to 1
  Function revealOpacity;
}

class StatusBar extends StatefulWidget {
  final Function(int) onIconTapped;
  final StatusBarController controller;
  const StatusBar({
    Key key,
    @required this.onIconTapped,
    @required this.controller,
  }) : super(key: key);

  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  bool isAllSelected;
  bool isNewSelected;
  bool isPopularSelected;
  bool isVisible = false;
  double width = 10;
  double opacity = 0;
  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller.currentIndex = 0;
      widget.controller.hideStatusBar = hideStatusBar;
      widget.controller.revealStatusBar = revealStatusBar;
      widget.controller.revealOpacity = revealStatusBarOpacity;
      widget.controller.hideOpacity = hideStatusBarOpacity;
    }

    isAllSelected = true;
    isNewSelected = false;
    isPopularSelected = false;
    Future.delayed(Duration(milliseconds: 200), () {
      revealStatusBar();
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: SizeConfig.safeBlockVertical * 18,
        left: 0,
        child: Hero(
          tag:statusBar ,
                  child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1750),
            height: SizeConfig.safeBlockVertical * 9,
            width: width,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 3.1,
                  offset: Offset(0, 1.4),
                  color: Colors.black12,
                  spreadRadius: 1)
            ]),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: SizeConfig.safeBlockVertical * 9,
                    width: SizeConfig.safeBlockHorizontal * 2,
                    color: Colors.red,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: SizeConfig.safeBlockHorizontal * 70,
                    height: SizeConfig.safeBlockVertical * 9,
                    // color: Colors.green,
                    child: AnimatedOpacity(
                      opacity: opacity,
                      duration: isVisible?Duration(milliseconds: 2000) : Duration(milliseconds: 500),
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          StatusBarItem(
                            title: all,
                            style: isAllSelected
                                ? statusBarTextStyleEnabled
                                : statusBarTextStyleDisabled,
                            underlinedColor: isAllSelected
                                ? underlinedColor
                                : transparentColor,
                            onTap: () {
                              isAllSelected = true;
                              isNewSelected = false;
                              isPopularSelected = false;
                              widget.controller.currentIndex = 0;
                              widget.onIconTapped(0);
                              if (mounted) setState(() {});
                            },
                          ),
                          StatusBarItem(
                            title: newC,
                            style: isNewSelected
                                ? statusBarTextStyleEnabled
                                : statusBarTextStyleDisabled,
                            underlinedColor: isNewSelected
                                ? underlinedColor
                                : transparentColor,
                            onTap: () {
                              isAllSelected = false;
                              isNewSelected = true;
                              isPopularSelected = false;
                              widget.controller.currentIndex = 1;
                              widget.onIconTapped(1);
                              if (mounted) setState(() {});
                            },
                          ),
                          StatusBarItem(
                            title: popular,
                            style: isPopularSelected
                                ? statusBarTextStyleEnabled
                                : statusBarTextStyleDisabled,
                            underlinedColor: isPopularSelected
                                ? underlinedColor
                                : transparentColor,
                            onTap: () {
                              isAllSelected = false;
                              isNewSelected = false;
                              isPopularSelected = true;
                              widget.controller.currentIndex = 2;
                              widget.onIconTapped(2);
                              if (mounted) setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> revealStatusBar() async {
    setState(() {
      width = SizeConfig.screenWidth;
      opacity = 1;
      isVisible = true;
    });
  }

  Future<void> hideStatusBar() async {
    setState(() {
      width = SizeConfig.safeBlockHorizontal * 5;
      opacity = 0;
      isVisible = false;
    });
  }

  Future<void> hideStatusBarOpacity() async {
    setState(() {
      opacity = 0;
      isVisible = false;
    });
  }

  Future<void> revealStatusBarOpacity() async {
    setState(() {
      opacity = 1;
      isVisible = true;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:shoppingcard/Helpers/Styles.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

///Use this to control the animation of the header
class HeaderController {
  ///This will reveal the header
  Function revealHeader;

  ///This will dismiss the header
  Function hideHeader;
}

class Header extends StatefulWidget {

  final HeaderController controller;
  final String title;
  final Color titleColor;
  final double topPosition;
  final double inclineMultiplier;
  const Header({
    Key key,
    @required this.controller,
    @required this.title,
    this.titleColor = Colors.black,
    this.topPosition = 0,
    this.inclineMultiplier =4,
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  AnimationController translationAnimatorController;
  Animation translatiionAnimation;
  CurvedAnimation translationAnimationCurve;


  @override
  void initState() {
    super.initState();
    //First we handle the controller
    if(widget.controller != null)
    {
      widget.controller.revealHeader = revealHeader;
      widget.controller.hideHeader = hideHeader;
    }
    translationAnimatorController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4500),reverseDuration: Duration(milliseconds: 700));
    
    translationAnimationCurve = CurvedAnimation(
        parent: translationAnimatorController,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.easeIn
        );
    translatiionAnimation = Tween<double>(
            begin: SizeConfig.safeBlockHorizontal * 130,
            end: SizeConfig.safeBlockHorizontal * widget.inclineMultiplier)
        .animate(translationAnimationCurve);
    translatiionAnimation.addListener(() {
      if (mounted) setState(() {});
    });
    translationAnimatorController.forward();
  }
  Future<void> revealHeader() async
  {
    translationAnimatorController.forward();
  }

  Future<void> hideHeader() async
  {
    translationAnimatorController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        top: widget.topPosition,
        child: Container(
          height: SizeConfig.safeBlockVertical * 25,
          width: SizeConfig.screenWidth,
         // color: Colors.yellow,
          child: Transform.rotate(
              angle: 5.95,
              //TODO: animate offset from 400 to 10
              child: Transform.translate(
                offset: Offset(translatiionAnimation.value, 0),
                child: Center(
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.fade,
                    style: headerTextStyle.copyWith(
                      color: widget.titleColor
                    )
                  ),
                ),
              )),
        ));
  }
}

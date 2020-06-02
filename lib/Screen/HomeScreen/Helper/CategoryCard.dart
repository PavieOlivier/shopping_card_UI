import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/Helpers/Styles.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

///Use this to control the animation on the card
class CategoryCardController {
  ///This will make the card invisible
  Function dismissCard;

  ///This will make the card visible
  Function revealCard;
}

class CategoryCard extends StatefulWidget {
  final CategoryCardController controller;
  final String categoryName;
  final String tag;
  final String backgroundLink;
  final Function onTap;
  const CategoryCard(
      {Key key,
      @required this.controller,
      @required this.categoryName,
      @required this.tag,
      @required this.backgroundLink,
      @required this.onTap})
      : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with TickerProviderStateMixin {
  double opacityValue = 0;
  bool isLoaded = false;
  AnimationController scaleAnimationController;
  AnimationController translateAnimationController;
  AnimationController borderRadiusAnimationController;
  Animation scaleAnimation, translateAnimation, borderRadiusAnimation;
  CurvedAnimation scaleAnimationCurve,
      borderRadiusAnimationCurve,
      scaleAnimation2Curve;
  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      //This is if we give a conroller to the widget
      widget.controller.dismissCard = dismissCard;
      widget.controller.revealCard = revealCard;
    }

    //now the boiler plates for the animation controller
    scaleAnimationController = AnimationController(
      reverseDuration: Duration(milliseconds:350),
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    translateAnimationController = AnimationController(
      reverseDuration: Duration(milliseconds:200),
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    borderRadiusAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 900));

    //Now lets create the curves animations
    //and give them to the simple animations
    borderRadiusAnimationCurve = CurvedAnimation(
        parent: borderRadiusAnimationController,
        curve: Curves.fastLinearToSlowEaseIn);
    scaleAnimationCurve = CurvedAnimation(
        parent: scaleAnimationController, curve: Curves.ease);
    scaleAnimation2Curve = CurvedAnimation(
        parent: translateAnimationController, curve: Curves.easeOut);
    borderRadiusAnimation =
        Tween<double>(begin: 95, end: 35).animate(borderRadiusAnimationCurve);

    scaleAnimation =
        Tween<double>(begin: 0, end: 1).animate(scaleAnimationCurve)
          ..addListener(() {
            setState(() {});
          });

    translateAnimation =
        Tween<double>(begin: -30, end: 0).animate(scaleAnimation2Curve)
          ..addListener(() {
            setState(() {});
          });
    //the opacity value here is because we use Animated opacity
    opacityValue = 1;
    //Lets play the animations
    scaleAnimationController.forward();
    borderRadiusAnimationController.forward();
    isLoaded = true;
    translateAnimationController.forward();
  }

  Future<void> dismissCard() async {
    opacityValue = 0;
    scaleAnimationController.reverse();
    borderRadiusAnimationController.reverse();
    translateAnimationController.reverse();
  }

  Future<void> revealCard() async {
    opacityValue = 1;
    scaleAnimationController.forward();
    borderRadiusAnimationController.forward();
    translateAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    scaleAnimationController.dispose();
    borderRadiusAnimationController.dispose();
    translateAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 60,
      height: SizeConfig.safeBlockVertical * 40,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: Card(
                  elevation: 0.3,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(borderRadiusAnimation.value)),
                  child: Container(
                    decoration: BoxDecoration(
                       boxShadow: [BoxShadow(
                         offset: Offset(0, 1.1),
                         blurRadius: 0.9,
                         spreadRadius: -1.2,
                         color: Colors.redAccent

                       )],
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(borderRadiusAnimation.value)),
                    width: SizeConfig.safeBlockHorizontal * 54,
                    height: SizeConfig.safeBlockVertical * 40,
                    child: CachedNetworkImage(
                      imageUrl: widget.backgroundLink,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              borderRadiusAnimation.value),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      placeholder: (context, url) => Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 14),
                        child: Image.asset(
                          pathToplaceHolder,
                        ),
                      ),
                      errorWidget: (context, url, error) => Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.safeBlockVertical * 25),
                          child: Icon(
                            Icons.warning,
                            color: Colors.red,
                            size: SizeConfig.safeBlockHorizontal * 9,
                          )),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Transform.translate(
                offset: Offset(translateAnimation.value, 0),
                child: AnimatedOpacity(
                  duration: isLoaded? Duration(milliseconds:200): Duration(milliseconds: 900),
                  opacity: opacityValue,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: SizeConfig.safeBlockHorizontal * 4),
                    child: Card(
                      elevation: 0.3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        width: SizeConfig.safeBlockHorizontal * 33,
                        height: SizeConfig.safeBlockVertical * 8,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.safeBlockHorizontal * 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      widget.categoryName,
                                      style: categoryNameTextStyle,
                                    ),
                                    Text(
                                      widget.tag,
                                      style: categoryTagTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Transform.translate(
                offset: Offset(translateAnimation.value, 0),
                child: AnimatedOpacity(
                  duration: isLoaded? Duration(milliseconds:200): Duration(milliseconds: 900),
                  opacity: opacityValue,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3),
                    child: Card(
                      elevation: 0.3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: SizeConfig.safeBlockHorizontal * 9,
                        height: SizeConfig.safeBlockVertical * 5,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: SizeConfig.safeBlockHorizontal * 7,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      //color: Colors.yellow,
    );
  }
}

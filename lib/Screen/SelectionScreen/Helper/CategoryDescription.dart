import 'package:flutter/material.dart';
import 'package:shoppingcard/Helpers/Styles.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';


class CategoryDescriptionController {
  ///Use this to slide in the text
  Function slideIn;

  /// Use this to slide out the text
  Function slideOut;
 
 /// this is used to hide the opacity of the title on the parent screen
 Function hideOpacity, revealOpacity;
  
}
///Handle the reveal of the description of the chosen category
class CategoryDescription extends StatefulWidget {
  final CategoryDescriptionController controller;
  final String description;
  const CategoryDescription({
    Key key,
    @required this.controller,
    @required this.description,
  }) : super(key: key);

  @override
  _CategoryDescriptionState createState() => _CategoryDescriptionState();
}

class _CategoryDescriptionState extends State<CategoryDescription>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  CurvedAnimation animationCurve;
  Animation animation;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller.slideIn = slideIn;
      widget.controller.slideOut = slideOut;
    }
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    animationCurve =
        CurvedAnimation(parent: animationController, curve: Curves.ease);
    animation = Tween<double>(begin: SizeConfig.screenWidth, end: 0).animate(animationCurve)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    slideIn();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //alignment: Alignment.centerLeft,
        width: SizeConfig.safeBlockHorizontal * 75,
        //color: Colors.red,
        child: Transform.translate(
          offset: Offset(animation.value, 0),
          child: AnimatedOpacity(
            opacity: opacity,
            duration: Duration(milliseconds: 4500),
            child: Text(
              widget.description,
              style: categoryDescriptionTextStyle ,
            ),
          ),
        ));
  }

  void slideIn() {
    opacity = 1;
    animationController.forward();
  }

  void slideOut() {
    opacity = 0;
    animationController.reverse();
  }
}

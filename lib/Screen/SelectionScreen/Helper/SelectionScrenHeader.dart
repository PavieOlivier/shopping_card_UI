import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shoppingcard/Screen/CardScreen/CardScreen.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';
import 'package:shoppingcard/unreleasedPackage/WidgetAnimator.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectionScreenHeader extends StatefulWidget {
  ///Use this controller to animate in or out the header
  final WidgetAnimatorController widgetAnimatorController;
  final Function onCloseTapped;
  final Duration animationDuration;
  final bool animateEntry;
  const SelectionScreenHeader({
    Key key,
    @required this.widgetAnimatorController,
    @required this.onCloseTapped,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.animateEntry = true,
  }) : super(key: key);

  @override
  _SelectionScreenHeaderState createState() => _SelectionScreenHeaderState();
}

class _SelectionScreenHeaderState extends State<SelectionScreenHeader> {
  Widget body;

  @override
  void initState() {
    super.initState();
    body = Row(
      children: <Widget>[
        Container(
          //color: Colors.yellow,
          height: SizeConfig.safeBlockVertical * 10,
          width: SizeConfig.safeBlockHorizontal * 50,
          child: Padding(
            padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal),
            child: Row(
              children: <Widget>[
                SelectionScreenHeaderItem(
                  underGroundColor: Colors.red[50],
                  icon: Icon(
                    Icons.close,
                    color: Colors.black38,
                    size: SizeConfig.safeBlockHorizontal * 7,
                  ),
                  onTap: widget.onCloseTapped,
                )
              ],
            ),
          ),
        ),
        Container(
          //color: Colors.blue,
          height: SizeConfig.safeBlockVertical * 10,
          width: SizeConfig.safeBlockHorizontal * 50,
          child: Padding(
            padding: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SelectionScreenHeaderItem(
                  icon: Icon(
                    Icons.bubble_chart,
                    color: Colors.black45,
                    size: SizeConfig.safeBlockHorizontal * 8,
                  ),
                  onTap: () async {
                    const url = 'https://www.instagram.com/emilecode/';
                    if(await canLaunch(url))
                    {
                      await launch(url);

                    }
                    else{
                      print('no internet');
                    }

                  },
                ),
                SelectionScreenHeaderItem(
                  icon: Icon(Icons.shopping_basket,
                      color: Colors.black54,
                      size: SizeConfig.safeBlockHorizontal * 7),
                  onTap: () {
                    if(widget.animateEntry == false)
                    {
                      Navigator.of(context).pushReplacement(PageTransition( child: CardScreen(), type: PageTransitionType.fade));
                    }
                    else{
                      Navigator.of(context).push(PageTransition( child: CardScreen(), type: PageTransitionType.fade));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: widget.animateEntry
          ? WidgetAnimator(
              controller: widget.widgetAnimatorController,
              duration: widget.animationDuration,
              child: body)
          : body,
    );
  }
}

class SelectionScreenHeaderItem extends StatelessWidget {
  ///Defines what will happen if you tap the icon
  final Function onTap;

  ///The Icon to display
  final Icon icon;

  ///the background color of the card
  final Color underGroundColor;
  const SelectionScreenHeaderItem(
      {Key key,
      @required this.onTap,
      @required this.icon,
      this.underGroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 13,
          height: SizeConfig.safeBlockVertical * 7,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: underGroundColor,
                    spreadRadius: -1,
                    offset: Offset(0, 1.1),
                    blurRadius: 0.5)
              ]),
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}

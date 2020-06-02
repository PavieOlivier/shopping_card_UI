import 'package:flutter/material.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

///This contain the Itm of the status bar
class StatusBarItem extends StatelessWidget {
  final TextStyle style;
  final Color underlinedColor;
  final String title;

  ///The method to be called when you tap the status bar Item
  final Function onTap;
  const StatusBarItem(
      {Key key,
      @required this.style,
      @required this.underlinedColor,
      @required this.title,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.safeBlockVertical * 9,

        //color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: underlinedColor, width: 3))),
              height: SizeConfig.safeBlockVertical * 3.5,
              child: Center(
                child: Text(
                  title,
                  style: style,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

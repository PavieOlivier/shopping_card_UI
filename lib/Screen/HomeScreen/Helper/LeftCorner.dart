import 'package:flutter/material.dart';
import 'package:shoppingcard/Helpers/Styles.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

///Use this to control the Icons on the left side of the screen
class LeftCornerController
{
  ///This will hide all the Icons present on the left side
  Function revealIcons;
  ///This will reveal all the icons present on the left side
  Function hideIcons;
}
class LeftCorner extends StatefulWidget {
  final LeftCornerController controller;
  const LeftCorner({
    Key key,@required  this.controller,
  }) : super(key: key);

  @override
  _LeftCornerState createState() => _LeftCornerState();
}

class _LeftCornerState extends State<LeftCorner> {
  bool isRevealed = false;

void revealIcons()
{
 setState(() {
   isRevealed = true;
 });
}

void hideIcons()
{
  setState(() {
    isRevealed = false;
  });
}
@override
  void initState() {
    if(widget.controller != null)
    {
      widget.controller.hideIcons = hideIcons;
      widget.controller.revealIcons = revealIcons;
    }
    super.initState();
   Future.delayed(Duration(milliseconds:250),(){
     revealIcons();
   }); 
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.safeBlockHorizontal * 25,
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: Duration(milliseconds: 450),
              top: isRevealed? SizeConfig.safeBlockVertical * 40:SizeConfig.safeBlockVertical * 35,
              left: isRevealed? 0:-21,
              right: 0,
              child: AnimatedOpacity(
                opacity:isRevealed?1:0,
                duration: Duration(milliseconds: 500),
                              child: Container(
                  //color: Colors.red,
                  child: Center(
                      child: Text(
                    DateTime.now().hour.toString() +
                        'h' +
                        DateTime.now().minute.toString(),
                    style: timeTextStyle,
                  )),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 490),
                top: isRevealed? SizeConfig.safeBlockVertical * 45:SizeConfig.safeBlockVertical * 40,
                left: 0,
                right: isRevealed? 0:-21,
                child: AnimatedOpacity(
                  opacity: isRevealed?1:0,
                  duration: Duration(milliseconds: 500),
                                  child: Icon(
                    Icons.search,
                    color: Colors.red,
                    size: SizeConfig.safeBlockHorizontal*9,
                  ),
                )),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              bottom: isRevealed? SizeConfig.safeBlockVertical * 15:SizeConfig.safeBlockVertical * 10,
              left: isRevealed? 0:-21,
              child: Container(
                //color: Colors.red,
                height: SizeConfig.safeBlockVertical * 15,
                width: SizeConfig.safeBlockHorizontal * 25,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        AnimatedOpacity(
                          opacity: isRevealed?1:0,
                          duration: Duration(milliseconds: 500),
                          child: Container(
                            width: SizeConfig.safeBlockHorizontal * 13,
                            height: SizeConfig.safeBlockVertical * 7.5,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.signal_wifi_4_bar,
                                  color: Colors.white,
                                ),
                                SizedBox(height:2),
                                Text('Connected',style: wifitextStyle )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        AnimatedOpacity(
                          opacity: isRevealed?1:0,
                          duration: Duration(milliseconds: 500),
                          child: Container(
                            width: SizeConfig.safeBlockHorizontal * 14,
                            height: SizeConfig.safeBlockVertical * 7.5,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            //TODO: Get platform channel code here to display battery (use the battery plugin)
                            child: Center(child: Text('60%', style: batteryTextStyle ,)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

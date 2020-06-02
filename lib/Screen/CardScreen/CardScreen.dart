import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/Screen/CardScreen/Helper/BoughtElementCard.dart';
import 'package:shoppingcard/Screen/HomeScreen/Helper/Header.dart';

import 'package:shoppingcard/Screen/SelectionScreen/Helper/SelectionScrenHeader.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';
import 'package:shoppingcard/unreleasedPackage/WidgetAnimator.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  HeaderController headerController ;
  double opacity =1;
  bool showCard = false;
  @override
  void initState() {
    
    super.initState();
    headerController = HeaderController();
    Future.delayed(Duration(milliseconds:300), (){
      showPriceTag();
    });
  }
  void showPriceTag()
  {
    if(mounted)
    setState(() {
      showCard = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: WillPopScope(
        onWillPop: ()async{
          setState(() {
                                opacity = 0;
                              });
                              await headerController.hideHeader();
                              
                              Future.delayed(Duration(milliseconds: 500),(){
                                 return Navigator.of(context).pop();
                              });
                              return false;
        },
              child: Stack(
          children: <Widget>[
            Positioned(
              top: -100,left: 0,right: 0,bottom: 0,
              child: Hero(
                tag: animatedBackground,
                child: Container(decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(130))),))),
            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastLinearToSlowEaseIn,
              top: SizeConfig.safeBlockVertical * 20,
              right: showCard? SizeConfig.safeBlockHorizontal*3:-SizeConfig.safeBlockHorizontal * 50,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds:350),
                            child: Container(
                  width: SizeConfig.safeBlockHorizontal * 30,
                  color: Colors.transparent,
                  child: Card(
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Total',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                          ),
                          Text(
                            '\$70',
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 8,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: SizeConfig.safeBlockVertical,
              left: SizeConfig.safeBlockHorizontal,
              child: AnimatedOpacity(
                opacity:opacity,
                  duration: Duration(milliseconds: 350),
                            child: Container(
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
                            onTap: () async{
                              setState(() {
                                opacity = 0;
                              });
                              await headerController.hideHeader();
                              
                              Future.delayed(Duration(milliseconds: 700),(){
                                 Navigator.of(context).pop();
                              });
                             
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Header(
              controller: headerController,
              title: 'Interior',
              titleColor: Colors.red,
              topPosition: SizeConfig.safeBlockVertical * 2,
              inclineMultiplier: 3,
            ),
            AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                left: 0,
                right: 0,
                bottom: 0,
                child: Hero(
                  tag: animatedBackground2,
                  child: AnimatedOpacity(
                    opacity:opacity,
                  duration: Duration(milliseconds: 350),
                                    child: Container(
                      // width: SizeConfig.safeBlockHorizontal*2,
                      height: SizeConfig.safeBlockVertical * 70,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(130))),
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedOpacity(
                  opacity:opacity,
                  duration: Duration(milliseconds: 350),
                                child: Container(
                    width: SizeConfig.safeBlockHorizontal * 90,
                    height: SizeConfig.safeBlockVertical * 70,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(130))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.safeBlockHorizontal * 5,
                              top: SizeConfig.safeBlockHorizontal * 15),
                          child: WidgetAnimator(
                            animateFromTop: true,
                            duration: Duration(seconds:1),
                                                    child: Text('Your Orders (not implemented)',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.safeBlockHorizontal * 6,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Expanded(
                          
                          child: AnimationLimiter(
                          child: ListView.builder(
                            itemCount: 10,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                delay: Duration(milliseconds:300),
                                  position: index,
                                  duration: Duration(milliseconds: 900),
                                  child: SlideAnimation(
                                    
                                    verticalOffset: 90,
                                    horizontalOffset: 90,
                                    child: FadeInAnimation(child: BoughtElementCard())),);}),)
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}


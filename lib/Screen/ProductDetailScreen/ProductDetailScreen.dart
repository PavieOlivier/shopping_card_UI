
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/Helpers/Styles.dart';
import 'package:shoppingcard/Model/Objects.dart';
import 'package:shoppingcard/Screen/CardScreen/CardScreen.dart';
import 'package:shoppingcard/Screen/ProductDetailScreen/Helpers/ButtomOptionCard.dart';

import 'package:shoppingcard/Screen/SelectionScreen/Helper/SelectionScrenHeader.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';
import 'package:shoppingcard/unreleasedPackage/WidgetAnimator.dart';

import 'Helpers/BigObjectImage.dart';
import 'Helpers/SmallImageIcon.dart';

class ProductDetailScreen extends StatefulWidget {
  final Item itemToDisplay;
  final Object heroTag;

  const ProductDetailScreen(
      {Key key, @required this.itemToDisplay, @required this.heroTag})
      : super(key: key);
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isFromCard = false;
  String linkToBigImage;
  double bottomCardLeftOffset;
  double bigImageLeftOffset;
  double opacitity;
  PageController bigImagePageController;
  WidgetAnimatorController widgetAnimController1,
      widgetAnimController2,
      widgetAnimController3;
  @override
  void initState() {
    super.initState();
    opacitity = 1;
    widgetAnimController1 = WidgetAnimatorController();
    widgetAnimController2 = WidgetAnimatorController();
    widgetAnimController3 = WidgetAnimatorController();
    bigImagePageController = PageController();
    bigImageLeftOffset = SizeConfig.safeBlockHorizontal;
    linkToBigImage = widget.itemToDisplay.imageLinkList[0];
    bottomCardLeftOffset = -SizeConfig.safeBlockHorizontal * 70;
    Future.delayed(Duration(milliseconds: 150), () {
      revealBottomCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
         await bigImagePageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.fastLinearToSlowEaseIn);
          return await hideAllElements(
              hideBottomCard: true, hideTopImage: false);
        },
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              color: Colors.white,
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              //THE HEADER
              child: AnimatedOpacity(
                opacity: opacitity,
                duration: Duration(milliseconds:350),
                              child: SelectionScreenHeader(
                  animateEntry: false,
                  onCloseTapped: () async {
                    await bigImagePageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.fastLinearToSlowEaseIn);
                    await hideAllElements(
                hideBottomCard: true, hideTopImage: false);
                    Navigator.of(context).pop();
                  }, widgetAnimatorController: null,
                  //widgetAnimatorController: widgetAnimatorController,
                ),
              ),
            ),
            AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                left: 0,
                right: 0,
                bottom: 0,
                child: Hero(
                  tag: animatedBackground,
                                  child: Container(
                    // width: SizeConfig.safeBlockHorizontal*2,
                    height: SizeConfig.safeBlockVertical * 80,
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(130))),
                  ),
                )),
            AnimatedPositioned(
                //TODO: add the same curve as the Interor curve
                duration:isFromCard?  Duration(milliseconds: 300) : Duration(milliseconds: 900),
                top: SizeConfig.safeBlockVertical * 16,
                left: bigImageLeftOffset,
                child: Hero(
                  tag: widget.heroTag,
                  child: BigObjectImage(
                    pageController: bigImagePageController,
                    linkToImages: widget.itemToDisplay.imageLinkList,
                  ),
                )),
            Positioned(
                top: SizeConfig.safeBlockVertical * 51,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: opacitity,
                  duration: isFromCard?Duration(milliseconds:150) :Duration(milliseconds: 350),
                  child: Container(
                    height: SizeConfig.safeBlockVertical * 12,
                    decoration: BoxDecoration(
                        //   color: Colors.red,
                        ),
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount: widget.itemToDisplay.imageLinkList.length,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: Duration(milliseconds: 1000),
                              child: SlideAnimation(
                                horizontalOffset: 50,
                                child: FadeInAnimation(
                                    child: SmallImageIcon(
                                        itemImageLink: widget
                                            .itemToDisplay.imageLinkList[index],
                                        onTap: () {
                                          //TODO: do something here about set state or maybe change the image
                                          bigImagePageController.animateToPage(
                                              index,
                                              duration:
                                                  Duration(milliseconds: 350),
                                              curve: Curves.linear);
                                        })),
                              ));
                        },
                      ),
                    ),
                  ),
                )),
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: 0,
              duration: Duration(milliseconds: 100),
              child: Container(
                height: SizeConfig.safeBlockVertical * 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    if (details.delta.dy < 0) {
                      print('swiping up');
                      hideBottomCard();
                    } else if (details.delta.dy > 0) {
                      print('Siping down');

                      revealBottomCard();
                    }
                  },
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding:
                          EdgeInsets.all(SizeConfig.safeBlockHorizontal * 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          WidgetAnimator(
                              controller: widgetAnimController1,
                              animateFromTop: false,
                              child: Text(
                                widget.itemToDisplay.itemName,
                                style: productDescriptionTitleTextStyle,
                              )),
                          WidgetAnimator(
                            controller: widgetAnimController2,
                            animateFromTop: false,
                            child: Container(
                              //color: Colors.orange,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    '\$${widget.itemToDisplay.itemPrice}',
                                    style: productDescriptionPriceTextStyle,
                                  )),
                                  Container(
                                    //color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            size:
                                                SizeConfig.safeBlockHorizontal *
                                                    7,
                                          ),
                                          onPressed: () {
                                            print('changing price');
                                          },
                                        ),
                                        AnimatedOpacity(
                                          opacity: 1,
                                          duration: Duration(milliseconds: 100),
                                          child: ClipOval(
                                            child: Container(
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  6,
                                              color: Colors.grey[50],
                                              child: Text(
                                                widget
                                                    .itemToDisplay.itemQuantity
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: counterTextStyle,
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add,
                                              size: SizeConfig
                                                      .safeBlockHorizontal *
                                                  7),
                                          onPressed: () {
                                            print('updating');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          WidgetAnimator(
                              controller: widgetAnimController3,
                              animateFromTop: false,
                              child: Text(
                                widget.itemToDisplay.itemDescription,
                                style: productDescriptionTextStyle,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              left: bottomCardLeftOffset,
              bottom: SizeConfig.safeBlockVertical * 5,
              duration: Duration(milliseconds: 500),
              child: BottomOptionCard(
                onTap: ()async{
                  print('botttom card tapped do something here');
                  isFromCard = true;
                  await hideAllElements(hideBottomCard: false, hideTopImage: true).then((value) async =>  Navigator.pushReplacement(context, PageTransition(
                  duration: Duration(milliseconds:500),
                  child: CardScreen(), type: PageTransitionType.fade)) );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> revealBottomCard() async {
    setState(() {
      bottomCardLeftOffset = 0;
    });
    return true;
  }

  Future<bool> revealGalleryList() {}
  Future<bool> revealFocussedGalery() {}
  Future<bool> hideAll() {}

  Future<bool> hideBottomCard() async {
    setState(() {
      bottomCardLeftOffset = -SizeConfig.safeBlockHorizontal * 76;
    });
    return true;
  }

  Future<bool> hideAllElements(
      {@required bool hideBottomCard, @required bool hideTopImage}) async {
    setState(() {
      opacitity = 0;
      if (hideBottomCard == true) {
        bottomCardLeftOffset = -SizeConfig.safeBlockHorizontal * 90;
      }
      if (hideTopImage == true) {
        bigImageLeftOffset = -SizeConfig.safeBlockHorizontal * 80;
      }
    });
    widgetAnimController1.reverseAnimation();
    widgetAnimController2.reverseAnimation();
    await widgetAnimController3.reverseAnimation();

    return true;
  }

  Future<bool> hideFocussedGalery() {}
}

import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:shoppingcard/Helpers/Styles.dart';
import 'package:shoppingcard/Model/LocalStoreManager.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

///this is to control the bottom card that contain the price
class PriceCardController {
  ///This will hide the list by changing
  ///its opacity to 0
  Function hideCard;

  ///This will reveal the list by changing
  ///its opacity to 1
  Function revealCard;

  ///The price of the current displayed item
  int itemPrice;

  Function({@required String price}) changeItemPrice;
}


class PriceCard extends StatefulWidget {
  ///An instance of the curently active Local store manager (or API)
  final LocalStoreManager localStoreManager;

  ///Use this controller to control the opacity on the widget
  final PriceCardController controller;

  ///Called when the red arrow is pressed
  final Function onArrowPressed;

  const PriceCard({
    @required this.onArrowPressed,
    @required this.controller,
    @required this.localStoreManager,
    Key key,
  }) : super(key: key);

  @override
  _PriceCardState createState() => _PriceCardState();
}

class _PriceCardState extends State<PriceCard>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  CurvedAnimation curvedAnimation;
  double opacity, opacity2;
  String itemPrice;
  int numberOfItemsToAdd = 1;
  bool isInitial;
  @override
  void initState() {
    super.initState();
    isInitial = true;
    opacity = 1;
    opacity2 = 1;
    if (widget.controller != null) {
      widget.controller.hideCard = hideCard;
      widget.controller.revealCard = revealCard;
      widget.controller.changeItemPrice = changeItemPrice;
      itemPrice = widget.controller.itemPrice.toString();
    }

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animationController.forward();
    isInitial = false;
    //changeItemPrice(price: 400);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: opacity,
      child: CircularRevealAnimation(
        animation: curvedAnimation,
        centerOffset: Offset(0, 0),
        child: Container(
          // color: Colors.orange,
          width: SizeConfig.safeBlockHorizontal * 82,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 75,
                  height: SizeConfig.safeBlockVertical * 9.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 1.3),
                        blurRadius: 2,
                        spreadRadius: -2,
                      )
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          //color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  size: SizeConfig.safeBlockHorizontal * 7,
                                ),
                                onPressed: () {
                                  print('changing price');
                                  _updateItemPrice(quantityAdded: false);
                                },
                              ),
                              AnimatedOpacity(
                                opacity: isInitial ? opacity : opacity2,
                                duration: isInitial
                                    ? Duration(milliseconds: 750)
                                    : Duration(milliseconds: 150),
                                child: ClipOval(
                                  child: Container(
                                    color: Colors.grey[50],
                                    child: Text(
                                      numberOfItemsToAdd.toString(),
                                      style: counterTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add,
                                    size: SizeConfig.safeBlockHorizontal * 7),
                                onPressed: () {
                                  print('updating');
                                  _updateItemPrice(quantityAdded: true);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          //color: Colors.green,
                          height: SizeConfig.safeBlockVertical * 8,
                          child: Padding(
                            padding: EdgeInsets.only(right:SizeConfig.safeBlockHorizontal*9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '\$',
                                  style: priceTextStyle,
                                ),
                                AnimatedOpacity(
                                    opacity: isInitial ? opacity : opacity2,
                                    duration: isInitial
                                        ? Duration(milliseconds: 750)
                                        : Duration(milliseconds: 150),
                                    child:
                                        Text(itemPrice, style: priceTextStyle)),
                                AnimatedOpacity(
                                  opacity: isInitial ? opacity : opacity2,
                                  duration: isInitial
                                      ? Duration(milliseconds: 750)
                                      : Duration(milliseconds: 150),
                                  child: Text(
                                    ',',
                                    style: priceTextStyle,
                                  ),
                                ),
                                AnimatedOpacity(
                                  opacity: isInitial ? opacity : opacity2,
                                  duration: isInitial
                                      ? Duration(milliseconds: 750)
                                      : Duration(milliseconds: 150),
                                  child: Text('00', style: priceTextStyle),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeConfig.safeBlockVertical,
                      right: SizeConfig.safeBlockHorizontal),
                  child: ArrowButton(
                    onPressed: widget.onArrowPressed,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateItemPrice({@required bool quantityAdded}) {
    {
      setState(() {
        opacity2 = 0;
      });

      if (quantityAdded == true) {
        numberOfItemsToAdd = numberOfItemsToAdd + 1;
        itemPrice =
            (int.parse(itemPrice) + widget.controller.itemPrice).toString();
      } else {
        numberOfItemsToAdd = numberOfItemsToAdd - 1;
        itemPrice =
            (int.parse(itemPrice) - widget.controller.itemPrice).toString();
      }

      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          opacity2 = 1;
        });
      });
    }
  }

  void changeItemPrice({String price}) {
    setState(() {
      opacity2 = 0;
    });
    numberOfItemsToAdd = 1;
    itemPrice = price;
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        opacity2 = 1;
      });
    });
  }

  void hideCard() {
    if (mounted) {
      setState(() {
        opacity = 0;
      });
    }
  }

  void revealCard() {
    if (mounted) {
      setState(() {
        opacity = 1;
      });
    }
  }
}

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 13,
      height: SizeConfig.safeBlockVertical * 6,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: SizeConfig.safeBlockHorizontal * 7,
            ),
            onPressed: onPressed),
      ),
    );
  }
}

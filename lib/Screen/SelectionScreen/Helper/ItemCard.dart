import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/Helpers/Styles.dart';
import 'package:shoppingcard/Model/Objects.dart';
import 'package:shoppingcard/Screen/ProductDetailScreen/ProductDetailScreen.dart';
import 'package:shoppingcard/Screen/SelectionScreen/Helper/ItemList.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

class ItemCard extends StatefulWidget {
  ///will be called once the card is tapped
  final Function onTap;

  ///Will be called once the plus icon of the card is typed
  final Function onPlusTap;

  final Item selectedItem;

  final ItemListController itemListController;

  const ItemCard({
    Key key,
    @required this.onTap,
    @required this.onPlusTap,
    @required this.selectedItem,
    @required this.itemListController
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard>
    with SingleTickerProviderStateMixin {
      String heroTag;
  AnimationController animationController;
  CurvedAnimation curvedAnimation;
  double opacity = 1;
  @override
  void initState() {
    super.initState();
    heroTag = ( 1+ Random().nextInt(543) +Random().nextInt(3000)).toString();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CircularRevealAnimation(
      animation: curvedAnimation,
      centerOffset: Offset(SizeConfig.safeBlockHorizontal * 40,
          SizeConfig.safeBlockHorizontal * 40),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            opacity = 0;
          });
          await widget.itemListController.hideSelectionScreen();
          await Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.fade,
                  child: ProductDetailScreen(
                    heroTag: heroTag,
                    itemToDisplay: widget.selectedItem,
                  )));
          
          widget.itemListController.revealSelectionScreen();
          Future.delayed(Duration(milliseconds: 500),(){
            setState(() {
            opacity = 1;
          });
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40)),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: heroTag,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: CachedNetworkImage(
                      imageUrl: widget.selectedItem.imageLinkList[0],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
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
              AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds:500),
                              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds:500),
                              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 5,
                        left: SizeConfig.safeBlockHorizontal * 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.selectedItem.itemName,
                          style: upperTitleTextStyle,
                        ),
                        Text(
                          'Insta: emilecode',
                          style: lowerTitleTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds:500),
                              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.safeBlockVertical * 1.5,
                        right: SizeConfig.safeBlockHorizontal * 4),
                    child: GestureDetector(
                      onTap: widget.onPlusTap,
                      child: ClipOval(
                        child: Container(
                          color: Colors.black,
                          width: SizeConfig.safeBlockHorizontal * 15,
                          height: SizeConfig.safeBlockVertical * 7,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //width: SizeConfig.safeBlockHorizontal*70,
        ),
      ),
    );
  }
}

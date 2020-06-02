


import 'package:flutter/material.dart';

import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/Helpers/Styles.dart';

import 'package:shoppingcard/Screen/SelectionScreen/Helper/PriceCard.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

///the back card located on the bottom of the screen that lead to the shopping card
class BottomOptionCard extends StatelessWidget {
  final Function onTap;
  const BottomOptionCard({
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 80,
      height: SizeConfig.safeBlockVertical * 11,
      decoration: BoxDecoration(
          // color: Colors.blue,
          ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onTap,
              child: Hero(
                tag:animatedBackground2 ,
                              child: Container(
                  width: SizeConfig.safeBlockHorizontal * 75,
                  height: SizeConfig.safeBlockVertical * 9.8,
                  decoration: BoxDecoration(
                    color: Colors.black,
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
                  child: Center(
                    child: Text(
                      'Add to Card',
                      textAlign: TextAlign.center,
                      style: productDescriptionAddCardTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 0.5),
              child: ArrowButton(),
            ),
          )
        ],
      ),
    );
  }
}

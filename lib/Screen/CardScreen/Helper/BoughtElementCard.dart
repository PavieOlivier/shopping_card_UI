import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

class BoughtElementCard extends StatelessWidget {
  const BoughtElementCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: SizeConfig.safeBlockVertical * 20,
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: CachedNetworkImageProvider(lampImageLink4[0]),fit: BoxFit.cover)
                    ),
                height: SizeConfig.safeBlockVertical * 15,
                width: SizeConfig.safeBlockHorizontal * 30,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                    right: SizeConfig.safeBlockHorizontal * 3.0),
                child: Text(
                  '\$70',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 33.0,
                      top: SizeConfig.safeBlockHorizontal * 6.0),
                  child: RichText(
                      text: TextSpan(
                          text: 'Drazzo Table Lamp',
                          
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 5,
                          ),
                          children: [
                        TextSpan(
                            text: '\nLamps',
                            style: TextStyle(
                                color: Colors.white38,
                                fontSize: SizeConfig.safeBlockHorizontal * 4))
                      ]))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:  EdgeInsets.only(top:SizeConfig.safeBlockVertical*5),
                child: Divider(
                  color: Colors.white24,
                  indent: SizeConfig.safeBlockHorizontal * 16.0,
                  endIndent: SizeConfig.safeBlockHorizontal * 16.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

///This contains small icon image
class SmallImageIcon extends StatelessWidget {
  ///What happens when the picture is tapped
  final Function onTap;
  final String itemImageLink;
  const SmallImageIcon({
    @required this.onTap,
    @required this.itemImageLink,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 1.5),
        child: Container(
          decoration: BoxDecoration(
             // color: Colors.pink,
               borderRadius: BorderRadius.circular(20),
               border: Border.all(
                 color: Colors.redAccent.withOpacity(0.15)
               )
               ),
          height: SizeConfig.safeBlockVertical * 10,
          width: SizeConfig.safeBlockHorizontal * 20,
          child: CachedNetworkImage(
            imageUrl: itemImageLink,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Padding(
              padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 14),
              child: Image.asset(
                pathToplaceHolder,
              ),
            ),
            errorWidget: (context, url, error) => Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.safeBlockVertical * 25),
                child: Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: SizeConfig.safeBlockHorizontal * 9,
                )),
          ),
        ),
      ),
    );
  }
}

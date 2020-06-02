import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

class BigObjectImage extends StatelessWidget {

  const BigObjectImage({
    Key key,
    @required this.linkToImages, @required this.pageController
  }) : super(key: key);

  final List<String> linkToImages;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 75,
      height: SizeConfig.safeBlockVertical * 34,
      decoration: BoxDecoration(
          //color: Colors.yellow,
          borderRadius: BorderRadius.circular(50)),
      child: PageView.builder(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: linkToImages.length,
        itemBuilder: (BuildContext context, int index) {  

        return CachedNetworkImage(
            
            imageUrl: linkToImages[index],
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                
                boxShadow: [BoxShadow(
                  color: Colors.redAccent.withOpacity(0.2),
                  offset: Offset(0, .5)
                )],
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
          );
      },

        
       ),
    );
  }
}

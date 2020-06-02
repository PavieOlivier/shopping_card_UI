import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/Model/LocalStoreManager.dart';
import 'package:shoppingcard/Screen/HomeScreen/Helper/CategoryCard.dart';
import 'package:shoppingcard/Screen/HomeScreen/Helper/Header.dart';
import 'package:shoppingcard/Screen/HomeScreen/Helper/LeftCorner.dart';
import 'package:shoppingcard/Screen/HomeScreen/Helper/Statusbar.dart';
import 'package:shoppingcard/Screen/SelectionScreen/SelectionScreen.dart';

import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

///This controller helps you when you want to animate the cards it contains
class RightCornerController {
  ///this will hide allt he cards that exist in the home screen
  Function dismissAllCards;

  ///this will reveal allt he cards that exist in the home screen
  Function revealAllCards;

  ///this will refresh the list
  Function refreshList;
}

class RightCorner extends StatefulWidget {
  final LocalStoreManager localStoreManager;
  final RightCornerController controller;
  final HeaderController headerController;
  final StatusBarController statusBarController;
  final LeftCornerController leftCornerController;
  const RightCorner(
      {Key key,
      @required this.controller,
      @required this.headerController,
      @required this.statusBarController,
      @required this.localStoreManager,
      @required this.leftCornerController})
      : super(key: key);

  @override
  _RightCornerState createState() => _RightCornerState();
}

class _RightCornerState extends State<RightCorner> {
  List<CategoryCardController> categoryCardControllerList;

  bool isRightLoaded = false;
  bool shallDisplayList = false;
  bool isFisrtLaunch = true;
  @override
  void initState() {
    categoryCardControllerList = [];
    super.initState();
    if (widget.controller != null) {
      widget.controller.dismissAllCards = dismissAllCard;
      widget.controller.revealAllCards = revealAllCard;
      widget.controller.refreshList = refreshList;
    }
    bounceIn();
    isFisrtLaunch = false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 1200),
      curve: Curves.fastLinearToSlowEaseIn,
      top: isRightLoaded ? 0 : SizeConfig.safeBlockVertical * 20,
      bottom: 0,
      right: isRightLoaded ? 0 : -SizeConfig.screenWidth,
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.safeBlockHorizontal * 75,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(110))),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: SizeConfig.safeBlockVertical * 27,
              left: 0,
              right: 0,
              child: Container(
                //color: Colors.green,
                width: SizeConfig.screenWidth,
                height: SizeConfig.safeBlockVertical * 78,
                child: shallDisplayList
                    ? ListView.builder(
                      primary: true,
                      addAutomaticKeepAlives: true,
                        itemCount:
                            widget.localStoreManager.itemCategoryList.length,
                        //scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          //If we are choosing to display all result
                          if (widget.statusBarController.currentIndex == 0) {
                            return populateList(index);
                          }
                          //Here we will display only results with the New tag
                          else if (widget.statusBarController.currentIndex ==1) {
                            if (widget.localStoreManager.itemCategoryList[index].tag ==newC) {
                              return populateList(index);
                            }
                            else
                            {
                              return SizedBox();
                            }
                          }
                          //Here we will display only the results with the popular tag
                          else if (widget.statusBarController.currentIndex == 2)
                          {
                            if (widget.localStoreManager.itemCategoryList[index].tag ==popular) {
                              return populateList(index);
                            }
                            else 
                            {
                              return SizedBox();
                            }
                          }
                          print('Not supposed to print');
                          return SizedBox();
                        },
                      )
                    : SizedBox(),
              ),
            )
          ],
        ),
      ),
    );
  }


  void refreshList()
  {
    //We MUST clear the list because it is being 
    //rebuilt by the list view thus we get a lot of instances and some 
    //of them had their AnimationController call the dispose method
    //This was generating an exception
    categoryCardControllerList.clear();
    if(mounted){
      setState(() {});
    }
  }
  Widget populateList(int index) {
    CategoryCardController tempControl = CategoryCardController();
    categoryCardControllerList.add(tempControl);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CategoryCard(
        backgroundLink: widget
            .localStoreManager.itemCategoryList[index].backgroundImageLink,
        controller: tempControl,
        tag: widget.localStoreManager.itemCategoryList[index].tag,
        categoryName:
            widget.localStoreManager.itemCategoryList[index].categoryName,
        onTap: () async {
          bounceOut();
          widget.statusBarController.hideOpacity();
         
          widget.leftCornerController.hideIcons();
           await widget.headerController.hideHeader();
          await Navigator.push(context, PageTransition(type: PageTransitionType.fade,
          duration: Duration(milliseconds:750),
           child: SelectionScreen(
             subCategories: widget.localStoreManager.itemCategoryList[index].subCategoryValues,
             subCategoryLength: widget.localStoreManager.itemCategoryList[index].subCategoryLength,
             localStoreManager: widget.localStoreManager,
             categoryName: widget.localStoreManager.itemCategoryList[index].categoryName,
             categoryDescription: widget.localStoreManager.itemCategoryList[index].description,
           ),));
            bounceIn();
            widget.statusBarController.revealOpacity();
            widget.headerController.revealHeader();
            widget.leftCornerController.revealIcons();
          
        },
      ),
    );
  }

  Future<void> dismissAllCard() async {
    if (categoryCardControllerList != null) {
      for (CategoryCardController xl in categoryCardControllerList) {
        if (xl != null) {
          if (xl.dismissCard != null) {
            xl.dismissCard();
          }
        }
      }
    }
  }

  Future<void> revealAllCard() async {
    if (categoryCardControllerList != null) {
      for (CategoryCardController xl in categoryCardControllerList) {
        if (xl != null) {
          if (xl.revealCard != null) {
            xl.revealCard();
          }
        }
      }
    }
  }

  ///This method is used to make the right corner
  ///animate in
  void bounceIn() async {
    await bounceInDependancy();
    Future.delayed(Duration(milliseconds: 150), () {
      setState(() {
        shallDisplayList = true;
      });
    });
  }

  //This method is made to support the orignial Bounce in
  Future<void> bounceInDependancy() async {
    if (isFisrtLaunch == false) {
      await revealAllCard();
    }
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        isRightLoaded = true;
      });
    });
  }

  ///This method is used to make the right corner
  ///animate out
  void bounceOut() async {
    await dismissAllCard();
    Future.delayed(Duration(milliseconds: 350), () {
      setState(() {
        isRightLoaded = false;
       // print('Sucessfully set to false by bouncing out');
      });
    });
  }
}

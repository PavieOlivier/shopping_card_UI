import 'package:flutter/material.dart';
import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/Model/LocalStoreManager.dart';
import 'package:shoppingcard/Model/Objects.dart';
import 'package:shoppingcard/Screen/SelectionScreen/Helper/CategoryDescription.dart';
import 'package:shoppingcard/Screen/SelectionScreen/Helper/ItemList.dart';
import 'package:shoppingcard/Screen/SelectionScreen/Helper/ItemTypeList.dart';
import 'package:shoppingcard/Screen/SelectionScreen/Helper/PriceCard.dart';
import 'package:shoppingcard/Screen/SelectionScreen/Helper/SelectionScrenHeader.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';
import 'package:shoppingcard/unreleasedPackage/SlidingText.dart';
import 'package:shoppingcard/unreleasedPackage/WidgetAnimator.dart';

class SelectionScreen extends StatefulWidget {
  ///This will be the name of the category to be displayed on top
  final String categoryName;

  ///This will be the description of the category
  final String categoryDescription;

  ///The store Manager instance that will call app Apis(if network)
  final LocalStoreManager localStoreManager;

  ///Item sub category Lenth
  final int subCategoryLength;

  ///This is the list of sub categories availiable
  final List<String> subCategories;

  const SelectionScreen(
      {Key key,
      @required this.categoryName,
      @required this.categoryDescription,
      @required this.localStoreManager,
      @required this.subCategories,
      @required this.subCategoryLength})
      : super(key: key);
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen>
    with SingleTickerProviderStateMixin {
  bool isLoaded;
  double opacity, opacityTitle = 1;
  bool isPoping = false;
  AnimationController backgroundColorAnimationController;
  Animation backgroundColorAnimation;
  CategoryDescriptionController categoryDescriptionController;
  WidgetAnimatorController widgetAnimatorController;
  SlidingTextController slidingTextController;
  ItemTypeListController itemTypeListController;
  PriceCardController priceCardController;
  ItemListController itemListController;
  @override
  void initState() {
    super.initState();
    isLoaded = false;
    opacity = 1;
    categoryDescriptionController = CategoryDescriptionController();
    categoryDescriptionController.hideOpacity = hideTitleOpacity;
    categoryDescriptionController.revealOpacity = revealTitleOpacity;
    widgetAnimatorController = WidgetAnimatorController();
    slidingTextController = SlidingTextController();
    itemTypeListController = ItemTypeListController();
    priceCardController = PriceCardController();
    itemListController = ItemListController();
    backgroundColorAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    backgroundColorAnimation =
        ColorTween(begin: Colors.grey[50], end: Colors.white)
            .animate(backgroundColorAnimationController)
              ..addListener(() {
                if (mounted) setState(() {});
              });
    initPage();
    widget.localStoreManager
        .convertEnumToList(enumValuesAsString: ChairType.values.toString());
  }

  @override
  void dispose() {
    super.dispose();
    backgroundColorAnimationController.dispose();
  }

  //This method will put all elements on the page
  void initPage() async {
    await widget.localStoreManager
        .populateItemList(withCategoryNamed: widget.categoryName)
        .then((onValue) {
      // for (Item anItem in widget.localStoreManager.itemList)
      // {
      //   print(anItem.itemName);
      // }
      if (onValue == true) {
        setState(() {
          opacity = 0;
        });
        Future.delayed(Duration(milliseconds: 800), () {
          setState(() {
            isLoaded = true;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: () async {
        return await prepareForPop();
      },
      child: Scaffold(
        body: isLoaded
            ? Stack(
                children: <Widget>[
                  Hero(
                    tag: statusBar,
                    child: Container(
                      alignment: Alignment.topCenter,
                      color: Colors.white,
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      //THE HEADER
                      child: SelectionScreenHeader(
                        onCloseTapped: () async {
                          await prepareForPop();
                          Navigator.of(context).pop();
                        },
                        widgetAnimatorController: widgetAnimatorController,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    duration: Duration(milliseconds: 300),
                    child: Hero(
                      tag: animatedBackground,
                      child: Container(
                        height: SizeConfig.safeBlockVertical * 90,
                        decoration: BoxDecoration(
                            color: backgroundColorAnimation.value,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(130))),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    //TODO: maybe animate this position we will see if not just remove the animation
                    duration: Duration(milliseconds: 100),
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      // width: SizeConfig.safeBlockHorizontal*2,
                      height: SizeConfig.safeBlockVertical * 90,
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          //color: Colors.green,
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.safeBlockVertical * 85,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: SizeConfig.safeBlockVertical*10,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          SizeConfig.safeBlockHorizontal * 7),
                                  child: AnimatedOpacity(
                                    opacity: opacityTitle,
                                    duration: Duration(milliseconds: 900),
                                    child: SlidingText(
                                      animationDuration:
                                          Duration(milliseconds: 800),
                                      controller: slidingTextController,
                                      text: widget.categoryName,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  17,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: SizeConfig.safeBlockVertical*16,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          SizeConfig.safeBlockHorizontal * 7),
                                  child: CategoryDescription(
                                    description: widget.categoryDescription,
                                    controller: categoryDescriptionController,
                                  ),
                                ),
                              ),

                              //TODO: use the list of lamp or whatever is generated gere AND
                              //GIVE ALLL CONTROLERS HERE FOR ANIMATION
                              Container(
                                //color: Colors.red,
                                height: SizeConfig.safeBlockVertical*36,

                                child: ItemList(
                                  controller: itemListController,
                                  categoryDescriptionController:
                                      categoryDescriptionController,
                                  slidingTextController:
                                      slidingTextController,
                                  widgetAnimatorController:
                                      widgetAnimatorController,
                                  localStoreManager: widget.localStoreManager,
                                  itemTypeListController:
                                      itemTypeListController,
                                  priceCardController: priceCardController,
                                ),
                              ),

                              Container(
                                height: SizeConfig.safeBlockHorizontal*20,

                                child: ItemTypeList(
                                  subCategoryString: widget.subCategories,
                                  itemListController: itemListController,
                                  controller: itemTypeListController,
                                  localStoreManager: widget.localStoreManager,
                                ),
                              ),
                              Container(
                                width: SizeConfig.safeBlockHorizontal*80,
                                height: SizeConfig.safeBlockVertical*10,
                                child: PriceCard(
                                  controller: priceCardController,
                                  localStoreManager: widget.localStoreManager,
                                  onArrowPressed: () {
                                    print('arrow pressed');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Hero(
                tag: statusBar,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: opacity,
                  child: Container(
                    width: SizeConfig.screenHeight,
                    height: SizeConfig.screenHeight,
                    color: Colors.white,
                    child: Center(child: Image.asset(pathToplaceHolder)),
                  ),
                ),
              ),
      ),
    );
  }

  void hideTitleOpacity() {
    if (mounted)
      setState(() {
        opacityTitle = 0;
      });
  }

  void revealTitleOpacity() {
    if (mounted)
      setState(() {
        opacityTitle = 1;
      });
  }

  Future<bool> prepareForPop() async {
    slidingTextController.animateDismiss();

    await categoryDescriptionController.slideOut();
    await itemTypeListController.hideList();
    await itemListController.hideCard();
    await priceCardController.hideCard();
    await widgetAnimatorController.reverseAnimation();
    await backgroundColorAnimationController.forward();
    await Future.delayed(Duration(milliseconds: 250), () {});
    return true;
  }
}

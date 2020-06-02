import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shoppingcard/Model/LocalStoreManager.dart';
import 'package:shoppingcard/Model/Objects.dart';
import 'package:shoppingcard/Screen/SelectionScreen/Helper/CategoryDescription.dart';
import 'package:shoppingcard/Screen/SelectionScreen/Helper/ItemCard.dart';
import 'package:shoppingcard/Screen/SelectionScreen/Helper/ItemTypeList.dart';
import 'package:shoppingcard/Screen/SelectionScreen/Helper/PriceCard.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';
import 'package:shoppingcard/unreleasedPackage/SlidingText.dart';
import 'package:shoppingcard/unreleasedPackage/WidgetAnimator.dart';

///Used to control the opacity of the list
///and the reconstruction of the list
///pass this controller to the listType widget
class ItemListController {
  ///This will hide the card by changing
  ///its opacity to 0
  Future<void> hideCard() async {
    await _hideCard();
  }

  ///This will reveal the card by changing
  ///its opacity to 1
  Future<void> revealCard() async {
    await _revealCard();
  }

  ///This function will rebuild the list of Item depending
  ///on the list card
  Future<void> rebuildList({@required String objectOfcategory}) async {
    _rebuildList(objectOfcategory);
  }

  ///This is to be initialized [ONLY] inside the selection screen
  ///Use this to make element of the screen invisible
  Future<void> hideSelectionScreen() async {
    await _hideSelectionScreen();
  }

  ///This is to be initialized [ONLY] inside the selection screen
  ///Use this to make element of the screen invisible
  Future<void> revealSelectionScreen() async {
    await _revealSelectionScreen();
  }

  ///The item being displayed as list are actually pages
  ///use this to control them from outside of the widget
  PageController pageControllerReference;

  Function _hideCard;

  Function _revealCard;

  Function _hideSelectionScreen;

  Function _revealSelectionScreen;

  Function(String) _rebuildList;
}

class ItemList extends StatefulWidget {
  ///Use this to control the opacty of the list
  final ItemListController controller;

  ///The actual local store manager
  final LocalStoreManager localStoreManager;

  ///Use this to anime the category name
  final SlidingTextController slidingTextController;

  ///Use this to control the animation of the Header of the page
  final WidgetAnimatorController widgetAnimatorController;

  ///Use this to animate the description of the category
  final CategoryDescriptionController categoryDescriptionController;

  ///Use this to control the opacity of the category list
  final ItemTypeListController itemTypeListController;

  ///Use this to control the opacity of the bottom price card
  final PriceCardController priceCardController;

  const ItemList({
    @required this.localStoreManager,
    @required this.widgetAnimatorController,
    @required this.slidingTextController,
    @required this.categoryDescriptionController,
    @required this.itemTypeListController,
    @required this.priceCardController,
    @required this.controller,
    Key key,
  }) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  double opacity = 1;
  PageController pageController;
  List<Item> itemsToDisplay = [];
  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.9);
    if (widget.controller != null) {
      widget.controller._hideCard = hideCard;
      widget.controller._revealCard = revealCard;
      widget.controller._rebuildList = rebuildList;
      widget.controller.pageControllerReference = pageController;
      widget.controller._hideSelectionScreen = hideSelectionScreen;
      widget.controller._revealSelectionScreen = revealSelectionScreen;
    }
    populateListToDisplay(widget.localStoreManager.itemList[0].itemSubCategory);
    widget.priceCardController.itemPrice =
        int.parse(widget.localStoreManager.itemList[0].itemPrice);
    //print(widget.controller.categoryToDisplay);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 500),
      child: AnimationLimiter(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemsToDisplay.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: Duration(milliseconds: 1000),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: Container(
                    //color: Colors.red,

                    width: SizeConfig.screenWidth,
                    child: PageView.builder(
                      onPageChanged: (index) {
                        print('Trying');
                        widget.priceCardController.itemPrice =
                            int.parse(itemsToDisplay[index].itemPrice);
                        widget.priceCardController.changeItemPrice(
                            price: itemsToDisplay[index].itemPrice);
                      },
                      physics: BouncingScrollPhysics(),
                      controller: pageController,
                      itemCount: itemsToDisplay.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ItemCard(
                            itemListController: widget.controller,
                            selectedItem: itemsToDisplay[index],
                            onPlusTap: () {
                              //TODO: use this for the page transition , the method shall be asyc
                              print('The plus item is tapped');
                            },
                            onTap: () async {},
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void hideSelectionScreen() async {
    widget.categoryDescriptionController.slideOut();
    widget.itemTypeListController.hideList();
    widget.priceCardController.hideCard();
    widget.categoryDescriptionController.hideOpacity();
    await widget.slidingTextController.animateDismiss(forceAwait: true);
  }

  void revealSelectionScreen() async {
    widget.slidingTextController.animateReveal();
    widget.categoryDescriptionController.slideIn();
    widget.categoryDescriptionController.revealOpacity();
    widget.itemTypeListController.revealList();
    widget.priceCardController.revealCard();
  }

  Future<void> populateListToDisplay(String ofCategory) async {
    // widget.controller.itemsBeingDisplaed.clear();
    for (Item anItem in widget.localStoreManager.itemList) {
      if (anItem.itemSubCategory == ofCategory) {
        itemsToDisplay.add(anItem);
      }
    }
    // widget.controller.itemsBeingDisplaed = itemsToDisplay;
  }

  ///This function will rebuild the list by type
  void rebuildList(String ofSubCategory) async {
    //TODO: implement this function
    itemsToDisplay.clear();

    await populateListToDisplay(ofSubCategory).then((value) {
      if (mounted)
        setState(() {
          widget.priceCardController
              .changeItemPrice(price: itemsToDisplay[0].itemPrice);
        });
      pageController.jumpTo(0);
    });
  }

  void hideCard() {
    if (mounted)
      setState(() {
        opacity = 0;
      });
  }

  void revealCard() {
    if (mounted)
      setState(() {
        opacity = 1;
      });
  }
}

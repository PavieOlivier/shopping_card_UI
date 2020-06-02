import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shoppingcard/Model/LocalStoreManager.dart';
import 'package:shoppingcard/Screen/SelectionScreen/Helper/ItemList.dart';
import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

class ItemTypeListController {
  ///This will hide the list by changing
  ///its opacity to 0
  Future<void> hideList() async {
    await _hideList();
  }
 ///This will reveal the list by changing
  ///its opacity to 1
  Future<void> revealList() async {
    await _revealList();
  }

 
  Function _hideList;

  Function _revealList;
}


class ItemTypeList extends StatefulWidget {
  ///The instance of the curently active local store manager
  final LocalStoreManager localStoreManager;



  ///The controller to make the list invisible
  final ItemTypeListController controller;

  ///The item list controller mostly it will request the list
  ///to display the proper category
  final ItemListController itemListController;

  ///The list of subCategory availiable 
  final List<String> subCategoryString;

  const ItemTypeList({
    Key key,
    @required this.localStoreManager,
    @required this.controller,
   
    @required this.itemListController,
    @required this.subCategoryString,
  }) : super(key: key);

  @override
  _ItemTypeListState createState() => _ItemTypeListState();
}

class _ItemTypeListState extends State<ItemTypeList> {
  double opacity = 1;
  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller._hideList = hideList;
      widget.controller._revealList = revealList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: opacity,
      child: Padding(
          padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 7),
          child: AnimationLimiter(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 900),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Container(
                        //  color: Colors.red,

                        width: SizeConfig.safeBlockHorizontal * 92,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: widget.subCategoryString.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return TypeCard(
                              name: widget.subCategoryString[index].toString(),
                              onTap: (){
                                print('name is ${widget.subCategoryString[index].toString()}');

                                widget.itemListController.rebuildList(objectOfcategory: widget.subCategoryString[index]);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }

  Future<void> hideList() async {
    if (mounted) {
      setState(() {
        opacity = 0;
      });
    }
  }

  Future<void> revealList() async {
    if (mounted) {
      setState(() {
        opacity = 1;
      });
    }
  }
}


///This is the small card that contain the type of the button
class TypeCard extends StatelessWidget {
  final Function onTap;
  final String name;
  const TypeCard({ @required this.onTap, this.name,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
                                  child: Padding(
        padding: const EdgeInsets.only(
            right: 9, top: 9, bottom: 9),
        
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 15,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 1.1),
                  blurRadius: 2,
                  spreadRadius: -2,
                )
              ]),
         child: Center(child: Text(name.substring(0,1),style: TextStyle(
           fontSize: SizeConfig.safeBlockHorizontal*9,
           color: Colors.black38
         ),)),
        ),
      ),
    );
  }
}

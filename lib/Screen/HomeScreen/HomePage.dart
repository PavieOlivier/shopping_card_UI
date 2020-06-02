import 'package:flutter/material.dart';
import 'package:shoppingcard/Helpers/Strings.dart';
import 'package:shoppingcard/Model/LocalStoreManager.dart';
import 'package:shoppingcard/Screen/HomeScreen/Helper/Header.dart';
import 'package:shoppingcard/Screen/HomeScreen/Helper/LeftCorner.dart';
import 'package:shoppingcard/Screen/HomeScreen/Helper/RightCorner.dart';
import 'package:shoppingcard/Screen/HomeScreen/Helper/Statusbar.dart';

import 'package:shoppingcard/SizeConfig/sizeConfig.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocalStoreManager localStoreManager;
  bool areCategoriesReady = false;
  HeaderController headerController;
  StatusBarController statusBarController;
  RightCornerController rightCornerController;
  LeftCornerController leftCornerController;
  @override
  void initState() {
    super.initState();
    localStoreManager = LocalStoreManager();
    headerController = HeaderController();
    statusBarController = StatusBarController();
    rightCornerController = RightCornerController();
    leftCornerController = LeftCornerController();
    getCategoriesFromApi();
  }

  void getCategoriesFromApi() async {
    await localStoreManager.getInteriorCategories();
    setState(() {
      areCategoriesReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: areCategoriesReady
            ? Container(
                color: Colors.grey[100],
                child: Stack(
                  children: <Widget>[

                    RightCorner(
                      localStoreManager: localStoreManager,
                      leftCornerController: leftCornerController,
                      controller: rightCornerController,
                      headerController: headerController,
                      statusBarController: statusBarController,
                    ),
                    LeftCorner(
                      controller: leftCornerController,
                    ),
                    Header(
                      title: headerTitle,
                      controller: headerController,
                    ),
                    StatusBar(
                      controller: statusBarController,
                      onIconTapped: (iconNumber) async {
                        print(iconNumber);

                        await rightCornerController.refreshList();
                      },
                    )
                  ],
                ),
              )
            : Center(
                child: Image.asset(pathToplaceHolder),
              ));
  }
}

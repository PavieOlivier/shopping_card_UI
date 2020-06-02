import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shoppingcard/Helpers/Strings.dart' as HelperStrings;
import 'Objects.dart';

class LocalStoreManager {
  ShoppingCard shoppingCard;
  List<_InteriorCategory> itemCategoryList;
  List<Item> itemList;
  List<Lamp> _lampList;
  List<Chair> _chairList;
  List<Table> _tableList;

  ///This item will initialize a new shopping card
  void initializeShoppingCard(dynamic shopingItem) {
    shoppingCard = new ShoppingCard();
    shoppingCard.numberOfItems = 1;
    if (shopingItem is Table) {
      shoppingCard.totalPrice = int.parse(shopingItem.tablePrice);
    } else if (shopingItem is Chair) {
      shoppingCard.totalPrice = int.parse(shopingItem.chairPrice);
    } else if (shopingItem is Lamp) {
      shoppingCard.totalPrice = int.parse(shopingItem.lampPrice);
    } else {
      throw {
        print('The element added in the shopping card cannot be identified')
      };
    }
  }

  ///This will trim the enumaration string to the name
  ///````
  /// Exemple: Will change LampType.wallLamp to wallLamp
  ///````
  static String enumarationValueToString(String enumNameToString) {
    //First we get the index of the point "."
    int trucatureValue = enumNameToString.indexOf('.');
    return enumNameToString.substring(trucatureValue + 1);
  }

  ///This will convert an enumaration to a list
  ///`````
  /// Exemple: enum anEnum {a,b,c} will return a stinf list as follow ['a','b',''c]
  ///````
  List<String> convertEnumToList({@required String enumValuesAsString}) {
    String simplifiedList =
        enumValuesAsString.replaceAll(new RegExp(r"\s\b|\b\s"), "");
    simplifiedList = simplifiedList.substring(1, simplifiedList.length - 1);
    print(simplifiedList);
    List<int> commaListIndex = [];
    List<String> finalList = [];
    //print(ChairType.values.toString());
    for (int i = 0; i < simplifiedList.length; i++) {
      if (simplifiedList[i] == ',') {
        commaListIndex.add(i);
      }
    }
    //print('The list of coma is of leghtn ${commaListIndex.length.toString()}');
    //The list of comma means number of item+1
    for (int i = 0; i < commaListIndex.length; i++) {
      //if we are in the 1st element
      if (i == 0) {
        //print(simplifiedList.substring(0, commaListIndex[i]));
        finalList.add(enumarationValueToString(
            simplifiedList.substring(0, commaListIndex[i])));
        //We need to make sure that enumarations of 2 values are considered
        if (commaListIndex.length == 1) {
          finalList.add(enumarationValueToString(
              simplifiedList.substring(commaListIndex[i] + 1)));
        } else {
          finalList.add(enumarationValueToString(simplifiedList.substring(
              commaListIndex[i] + 1, commaListIndex[i + 1])));
        }
      } else if (i + 1 != commaListIndex.length) {
        finalList.add(enumarationValueToString(simplifiedList.substring(
            commaListIndex[i] + 1, commaListIndex[i + 1])));
      } else {
        finalList.add(enumarationValueToString(
            simplifiedList.substring(commaListIndex[i] + 1)));
      }
    }

    return finalList;
  }

  ///This will delete the shopping card
  void deleteShoppingCard() {
    shoppingCard = null;
  }

  ///Use this to add Items to the shopping card
  void addItemToShoppingCard() {
    //TODO: Make this one later(You will have to do it)

  }

  ///This method will return the availaible categories
  ///present in the store. Typically it shall call an Api
  ///and work with Json but since it is just an UI, data will be
  ///mocked
  Future<void> getInteriorCategories() async {
    List<_InteriorCategory> tempList = [
      _InteriorCategory(
          backgroundImageLink: HelperStrings.chairBackgroundLink,
          categoryName: HelperStrings.chair,
          subCategoryValues: convertEnumToList( enumValuesAsString:  ChairType.values.toString()),
          tag: _generateRandomTag(),
          description: HelperStrings.chairPageDescription,
          subCategoryLength: ChairType.values.length),
      _InteriorCategory(
        backgroundImageLink: HelperStrings.lampBackgroundLink,
        categoryName: HelperStrings.lamp,
        subCategoryValues: convertEnumToList(enumValuesAsString: LampType.values.toString()),
        tag: _generateRandomTag(),
        description: HelperStrings.lampPageDescription,
        subCategoryLength: LampType.values.length,
      ),
      _InteriorCategory(
          backgroundImageLink: HelperStrings.tableBackgrroundLink,
          subCategoryValues: convertEnumToList(enumValuesAsString: TableType.values.toString()),
          categoryName: HelperStrings.table,
          tag: _generateRandomTag(),
          description: HelperStrings.tablePageDescription,
          subCategoryLength: TableType.values.length),
    ];
    itemCategoryList = tempList;
  }

  ///This will return a list of Lamp
  Future<List<Lamp>> _getListOfLamp() async {
    return [
      Lamp(
          lampType: LampType.readingLamp,
          lampPrice: (100 + Random().nextInt(200)).toString(),
          lampName: 'Bola Disk Pendant',
          description: HelperStrings.furnitureDescription,
          imageLinkList: HelperStrings.lampImageLink1),
      Lamp(
          lampType: LampType.ceilingLamp,
          lampPrice:( 100 + Random().nextInt(500)).toString(),
          lampName: 'Swell Pendant',
          description: HelperStrings.furnitureDescription,
          imageLinkList: HelperStrings.lampImageLink2),
      Lamp(
        lampType: LampType.ceilingLamp,
        lampPrice: (100 + Random().nextInt(700)).toString(),
        lampName: 'Soul Dream Pendant',
        description: HelperStrings.furnitureDescription,
        imageLinkList: HelperStrings.lampImageLink3,
      ),
      Lamp(
        lampType: LampType.tableLamp,
        lampPrice: (100 + Random().nextInt(400)).toString(),
        lampName: 'Drazzo Table Lamp',
        description: HelperStrings.furnitureDescription,
        imageLinkList: HelperStrings.lampImageLink4,
      ),
      Lamp(
        lampType: LampType.tableLamp,
        lampPrice: (100 + Random().nextInt(400)).toString(),
        lampName: 'Tube Top Table Lamp',
        description: HelperStrings.furnitureDescription,
        imageLinkList: HelperStrings.lampImageLink5,
      ),
      Lamp(
        lampType: LampType.wallLamp,
        lampPrice: (100 + Random().nextInt(400)).toString(),
        lampName: 'Contour Table Lamp',
        description: HelperStrings.furnitureDescription,
        imageLinkList: HelperStrings.lampImageLink6,
      ),
    ];
  }

  ///This will generate a list of table
  Future<List<Table>> _getListOfTable() async {
    return [
      Table(
          tableName: 'Custom Sqaure Coffee Table',
          tableType: TableType.coffee,
          tablePrice: (100 + Random().nextInt(500)).toString(),
          description: HelperStrings.furnitureDescription,
          imageLinkList: HelperStrings.tableImageLink1),
      Table(
          tableName: 'Plank Sqaure Coffee Table',
          tableType: TableType.coffee,
          tablePrice: (100 + Random().nextInt(700)).toString(),
          description: HelperStrings.furnitureDescription,
          imageLinkList: HelperStrings.tableImageLink2),
      Table(
          tableName: 'Plank Sqaure Coffee Table',
          tableType: TableType.officeDesk,
          tablePrice: (100 + Random().nextInt(700)).toString(),
          description: HelperStrings.furnitureDescription,
          imageLinkList: HelperStrings.tableImageLink3),
    ];
  }

  ///This will generate a list of Chair
  Future<List<Chair>> _getListOfChair() async {
    return [
      Chair(
          chairType: ChairType.sofa,
          chairName: 'Plateau Chair',
          chairPrice: (100 + Random().nextInt(500)).toString(),
          description: HelperStrings.furnitureDescription,
          imageLinkList: HelperStrings.chairImageLink1),
      Chair(
          chairType: ChairType.others,
          chairName: 'Arie Chair',
          chairPrice: (100 + Random().nextInt(700)).toString(),
          description: HelperStrings.furnitureDescription,
          imageLinkList: HelperStrings.chairImageLink2),
    ];
  }

  ///This will populate the proper list based on the category requested
  ///and return a bool if the cathegory is retrieved sucessfully
  Future<bool> populateItemList({@required String withCategoryNamed}) async {
    // We must delete all elements inside the item list before populating it again
    // that is good for reusability
    await clearItemList();
    if (withCategoryNamed == HelperStrings.lamp) {
      _lampList = await _getListOfLamp();

      for (Lamp anItem in _lampList) {
        itemList.add(Item(
            itemName: anItem.lampName,
            itemDescription: anItem.description,
            itemSubCategory: enumarationValueToString(
                LampType.values[anItem.lampType.index].toString()),
            itemPrice: anItem.lampPrice,
            imageLinkList: anItem.imageLinkList));
        //print(enumarationValueToString(LampType.values[anItem.lampType.index].toString()),);
      }
      return true;
    } else if (withCategoryNamed == HelperStrings.chair) {
      _chairList = await _getListOfChair();

      for (Chair anItem in _chairList) {
        itemList.add(Item(
            itemName: anItem.chairName,
            itemDescription: anItem.description,
            itemSubCategory: enumarationValueToString(
                ChairType.values[anItem.chairType.index].toString()),
            itemPrice: anItem.chairPrice,
            imageLinkList: anItem.imageLinkList));
      }
      return true;
    } else if (withCategoryNamed == HelperStrings.table) {
      _tableList = await _getListOfTable();

      for (Table anItem in _tableList) {
        itemList.add(Item(
            itemName: anItem.tableName,
            itemDescription: anItem.description,
            itemSubCategory: enumarationValueToString(
                TableType.values[anItem.tableType.index].toString()),
            itemPrice: anItem.tablePrice,
            imageLinkList: anItem.imageLinkList));
      }
      return true;
    } else {
      throw {
        print(
            'Cannot get proper category, the Api manager does not know about the category ' +
                withCategoryNamed),
        print(
            'This exception i not handled by this app since it is just made for demonstration purpose')
      };
    }
  }

  ///Use this to clear the list
  Future<bool> clearItemList() async {
    if (itemList == null) {
      itemList = [];
    } else if (itemList.isEmpty == false) {
      itemList.clear();
    } else if (itemList.isEmpty == true) {}

    return true;
  }

  //Use this to generate a tag for
  //the interiorCategory object
  String _generateRandomTag() {
    switch (Random().nextInt(2)) {
      case 0:
        return HelperStrings.popular;
        break;
      case 1:
        return HelperStrings.newC;
        break;
      default:
        return HelperStrings.newC;
    }
  }
}

class _InteriorCategory {
  String categoryName;
  String backgroundImageLink;
  String tag;
  String description;
  List<String> subCategoryValues;
  int subCategoryLength;
  _InteriorCategory(
      {@required this.description,
      @required this.subCategoryValues,
      @required this.subCategoryLength,
      @required this.categoryName,
      @required this.backgroundImageLink,
      @required this.tag});
}

class ShoppingCard {
  int numberOfItems;
  int totalPrice;
  //TODO: add a list of widget here for displaying the items needed (You will have to do it)
}

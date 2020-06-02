import 'package:flutter/foundation.dart';

enum ChairType { sofa, others }
enum TableType {
  coffee,
  officeDesk,
}
enum LampType { wallLamp, tableLamp, ceilingLamp, readingLamp }

class Chair {
  Chair({
    @required this.chairName,
    @required this.chairPrice,
    @required this.chairType,
    @required this.imageLinkList,
    @required this.description,
  });
  ChairType chairType;
  String chairName;
  String description;
  String chairPrice;
  List<String> imageLinkList;
}

class Lamp {
  Lamp(
      {@required this.imageLinkList,
      @required this.description,
      @required this.lampName,
      @required this.lampPrice,
      @required this.lampType});
  LampType lampType;
  String lampName;
  String description;
  String lampPrice;
  List<String> imageLinkList;
}

class Table {
  Table(
      {@required this.imageLinkList,
      @required this.tableName,
      @required this.description,
      @required this.tablePrice,
      @required this.tableType});
  TableType tableType;
  String tableName;
  String tablePrice;
  String description;
  List<String> imageLinkList;
}

class Item {
  Item({
    @required this.imageLinkList,
    @required this.itemDescription,
    @required this.itemName,
    @required this.itemPrice,
    @required this.itemSubCategory,
  });

  String itemName;
  String itemPrice;
  String itemDescription;
  String itemSubTypeIconFilePath;
  List<String> imageLinkList;
  String itemSubCategory;

  int itemQuantity = 0;
}

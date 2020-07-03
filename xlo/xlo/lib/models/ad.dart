import 'package:xlo/models/address.dart';

class Ad {

  List<dynamic> images;
  String title;
  String description;
  DateTime dateCreated = DateTime.now();

  Address address;

  num price;
  bool hidePhone;

}
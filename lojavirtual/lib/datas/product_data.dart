import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

  static final String titleColumn = "title";
  static final String descriptionColumn = "description";
  static final String priceColumn = "price";
  static final String imagesColumn = "images";
  static final String sizesColumn = "sizes";


  String id;

  String title;
  String description;

  double price;

  List images;
  List sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data[titleColumn];
    description = snapshot.data[descriptionColumn];
    price = snapshot.data[priceColumn] + 0.0;
    images = snapshot.data[imagesColumn];
    sizes = snapshot.data[sizesColumn];
  }
}
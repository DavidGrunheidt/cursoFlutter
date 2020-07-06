import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("products").getDocuments(),
      builder: _buildProductsList,
    );
  }

  Widget _buildProductsList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return Center(
          child: CircularProgressIndicator(),
        );
      default:
        var dividedTiles = ListTile.divideTiles(
            tiles: snapshot.data.documents.map((doc) => CategoryTile(doc)).toList(),
            color: Colors.grey[500]
        ).toList();

        return ListView(children: dividedTiles);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/product_data.dart';
import 'package:lojavirtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data[ProductData.titleColumn]),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          builder: _buildProductsView,
        )
      ),
    );
  }

  Widget _buildProductsView(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return Center(child: CircularProgressIndicator());
      default:
        return TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            GridView.builder(
                padding: EdgeInsets.all(4),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 0.65
                ), 
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => ProductTile("grid", ProductData.fromDocument(snapshot.data.documents[index]))
            ),
            ListView.builder(
              padding: EdgeInsets.all(4),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => ProductTile("list", ProductData.fromDocument(snapshot.data.documents[index])),
            )
          ],
        );
    }
  }
}

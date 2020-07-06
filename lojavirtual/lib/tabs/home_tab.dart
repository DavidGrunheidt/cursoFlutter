import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {

  static final Widget _buildBodyBack = Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 211, 118, 130),
              Color.fromARGB(255, 253, 181, 168)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
        )
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildBodyBack,
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("home").orderBy("pos").getDocuments(),
              builder: _buildImagesGrid,
            )
          ],
        ),
      ],
    );
  }

  Widget _buildImagesGrid(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    switch(snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return SliverToBoxAdapter(
          child: Container(
            height: 200,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ),
        );
      default:
        return SliverStaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          staggeredTiles: _getStaggeredTilesFromSnapshot(snapshot),
          children: _getImagesFromSnapshot(snapshot)
        );
    }
  }

  List<FadeInImage> _getImagesFromSnapshot(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents.map(
            (doc) => FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: doc.data["image"],
                fit: BoxFit.cover,
            )
    ).toList();
  }

  List<StaggeredTile> _getStaggeredTilesFromSnapshot(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents.map(
        (doc) => StaggeredTile.count(doc.data["x"], doc.data["y"])
    ).toList();
  }


}

import 'package:favoritosyoutube/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataSearch extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<List>(
        future: _suggestions(query),
        builder: _suggestionsBuilder
      );
    }
  }

  Widget _suggestionsBuilder(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return Center(child: CircularProgressIndicator());
      default:
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data[index]),
              leading: Icon(Icons.play_arrow),
              onTap: () {
                close(context, snapshot.data[index]);
              },
            );
          },
          itemCount: snapshot.data.length,
        );
    }
  }

  Future<List> _suggestions(String search) async {
    http.Response response = await http.get(
      "${Api.suggestQueriesEndpoint}&q=$search"
    );
    
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body)[1].map(
                (value) => value[0]
        ).toList();
      default:
        throw Exception("Failed to load suggestions");
    }
  }

}
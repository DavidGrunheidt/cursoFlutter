import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/video.dart';

const API_KEY = "AIzaSyDTvZLfGZKN8YqedR-nMEr0RQrdKsro9vU";

class Api {

  static const String searchEndpoint = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&key=$API_KEY&maxResults=10";
  static const String suggestQueriesEndpoint = "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&format=5&alt=json";

  String _search;
  String _nextToken;

  Future<List<Video>> search(String search) async {
    _search = search;

    http.Response response = await http.get(
      "$searchEndpoint&q=$search"
    );

    return _decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(
        "$searchEndpoint&q=$_search&pageToken=$_nextToken"
    );
    return _decode(response);
  }

  List<Video> _decode(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var decoded = json.decode(response.body);

        _nextToken = decoded["nextPageToken"];

        List<Video> videos = decoded["items"].map<Video>(
            (videoJson) => Video.fromJson(videoJson)
        ).toList();

        return videos;
      default:
        throw Exception("Failed to load videos");
    }
  }

}
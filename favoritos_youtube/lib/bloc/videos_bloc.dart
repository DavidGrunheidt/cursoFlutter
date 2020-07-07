import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritosyoutube/api.dart';
import 'package:favoritosyoutube/models/video.dart';

class VideosBloc implements BlocBase {

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  List<Video> videos;
  Api api;

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  void _search(String search) async {
    if (search != null) {
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }

    _videosController.sink.add(videos);
  }

}
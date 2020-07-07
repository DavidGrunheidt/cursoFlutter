
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritosyoutube/bloc/videos_bloc.dart';
import 'package:favoritosyoutube/screens/home.dart';
import 'package:flutter/material.dart';

import 'bloc/favorite_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
        child: MaterialApp(
            title: 'FlutterTube',
            home: Home()
        ),
      )
    );
  }
}
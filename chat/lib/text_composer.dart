import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {

  TextComposer(this._sendMessageFunction);

  final Function({String text, File imgFile}) _sendMessageFunction;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
         children: <Widget>[
           IconButton(
             icon: Icon(Icons.photo_camera),
             onPressed: () async {
               final File imgFile = await ImagePicker.pickImage(source: ImageSource.camera);
               if (imgFile == null) return;
               _sendMessage(imgFile: imgFile);
             },
           ),
           Expanded(
             child: TextField(
               controller: _controller,
               decoration: InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
               onChanged: (text) {
                 setState(() {
                   _isComposing = text.isNotEmpty;
                 });
               },
               onSubmitted: (text) { _sendMessage(text: text); } ,
             ),
           ),
           IconButton(
             icon: Icon(Icons.send),
             onPressed: _isComposing ? () { _sendMessage(text: _controller.text); } : null
           )
         ],
      ),
    );
  }

  void _sendMessage({String text, File imgFile}) {
    widget._sendMessageFunction(text: text, imgFile: imgFile);
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }
}

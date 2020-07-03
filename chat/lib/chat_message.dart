import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  final Map<String, dynamic> data;
  final bool isMine;

  ChatMessage(this.data, this.isMine);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          !isMine ? _getCircleAvatar(isMine) : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                data['imgUrl'] != null ?
                Image.network(data['imgUrl'], width: 250) :
                Text(
                    data['text'],
                    textAlign: isMine ? TextAlign.end : TextAlign.start,
                    style: TextStyle(fontSize: 16)
                ),

                Text(
                    data['senderName'],
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)
                )
              ],
            ),
          ),
          isMine ? _getCircleAvatar(isMine) : Container(),
        ],
      ),
    );
  }

  Widget _getCircleAvatar(bool isMine) {
    return Padding(
      padding: isMine ? EdgeInsets.only(left: 16) : EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundImage: NetworkImage(data['senderPhotoUrl']),
      ),
    );
  }
}

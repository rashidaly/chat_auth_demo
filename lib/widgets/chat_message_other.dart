import 'package:flutter/material.dart';

class MessageOther extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data ;
   bool showAvatar = true;
   MessageOther({Key? key, required this.index, required this.data, required this.showAvatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 10,
        vertical: 6
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(showAvatar)
          CircleAvatar(
            backgroundImage: NetworkImage(data['photo_url']),
          )
          else SizedBox(width: 40),
          SizedBox(width: 10),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('${data['author']} said',
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
                ),
                SizedBox(height: 5),
                Text(data['value']),
              ],
            ),
          )
        ],
      ),

    );
  }
}

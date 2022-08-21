

import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const MessageForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<MessageForm> createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  final _controller = TextEditingController();
  String? _message;
  void _onPressed() {
    widget.onSubmit(_message!);
    print(_message);
    _controller.clear();
    _message = '';
    setState(() {

    });
     
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
             Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Send a message...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none

                  ),
                  contentPadding: EdgeInsets.all(10)
                ),
                minLines: 1,
                maxLines: 10,
                onChanged: (value){
                  setState(() {
                    _message = value;
                  });

                },
              ),
            ),
            const SizedBox(width: 5),
            RawMaterialButton(
              onPressed: _message == null || _message!.isEmpty ? null :
            _onPressed,
              fillColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Send',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}

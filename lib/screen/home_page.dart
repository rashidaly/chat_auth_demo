
import 'package:chat_app/auth/auth_provider.dart';
import 'package:chat_app/widgets/message_form.dart';
import 'package:chat_app/widgets/message_wall.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';


class MyHomePage extends StatefulWidget {
  final store = FirebaseFirestore.instance.collection('chat_messages');
   MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { @override
void initState() {
  super.initState();
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user is User) {
      _signedIn = true;
    } else {
      _signedIn = false;
    }
    setState(() {});
  });
}

bool _signedIn = false;
  void _signIn() async{
    try{
      final cred = await AuthProvider().siginInWithGoogle();
      print(cred);
      setState(() {
        _signedIn = true;
      });
    }catch(e){
      print('failed: $e');

    }
  }
  void _signOut() async{
    await FirebaseAuth.instance.signOut();
    setState(() {
      _signedIn = false;
    });
  }

  void _addMessage(String value) async{
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      await widget.store.add({
        'author': user.displayName ?? 'Anonymous',
        'author_id': user.uid,
        'photo_url': user.photoURL ?? 'https://placehold.it/100x100',
        'timestamp': Timestamp.now().microsecondsSinceEpoch,
        'value': value,

      });
    }
  }

  void _deleteMessage(String docId) async{
    await widget.store.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('chat app'),
        actions: [
          if(_signedIn)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: _signOut,
                child: const Icon(Icons.logout),
              ),
            )
        ],
      ),
      body: Column(
        children:  [
          Expanded(
          child:  StreamBuilder<QuerySnapshot>(
            stream: widget.store
            .orderBy('timestamp')
            .snapshots(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                if(snapshot.data!.docs.isEmpty){
                  return const Center(child: Text('No Message to Display'),
                  );

                }
                return MessageWall(
                  onDelete: _deleteMessage,

                    messages: snapshot.data!.docs);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
          ),
          if(_signedIn)
             MessageForm(
               onSubmit: _addMessage,
             )
          else
          Container(
            padding: const EdgeInsets.all(5),
            child:  SignInButton(Buttons.Google,
              onPressed: _signIn,
            ),
          )
        ],
      )
    );
  }
}

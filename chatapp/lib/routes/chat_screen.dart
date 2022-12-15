import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Chat'),
      //   centerTitle: true,
      // ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/iLeGDmg2ZxRJ8uwrHL4u/messages')
            .snapshots(),
        builder: (context, snapshot) {
          final documents = snapshot.data?.docs;
          print(documents?.first);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
            case ConnectionState.active:
              if (documents == null) {
                return Text('data');
              }
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(documents[index]['text']),
                  // child: Text(documents.first.id),
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          FirebaseFirestore.instance
              .collection('chats/iLeGDmg2ZxRJ8uwrHL4u/messages')
              .add({'text': 'button click'});
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}

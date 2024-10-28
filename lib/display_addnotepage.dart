import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notepage extends StatefulWidget {
  String id;
  Notepage({super.key, required this.id});

  @override
  State<Notepage> createState() => _NotepageState();
}

class _NotepageState extends State<Notepage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Map<String, dynamic> updates = {};
                if (notesController.text.isNotEmpty) {
                  updates = {'Notes': notesController.text};
                }

                if (titleController.text.isNotEmpty) {
                  updates['Title'] = titleController.text;
                }

                FirebaseFirestore.instance
                    .collection('Notes')
                    .doc(widget.id)
                    .update(updates);
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: notesController,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: 'Note', border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

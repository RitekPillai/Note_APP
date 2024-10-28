import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Addnotepage extends StatefulWidget {
  const Addnotepage({super.key});

  @override
  State<Addnotepage> createState() => _AddnotepageState();
}

class _AddnotepageState extends State<Addnotepage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  void createtask() {
    try {
      FirebaseFirestore.instance.collection('Notes').add({
        "Title": titleController.text.trim(),
        "Notes": notesController.text.trim()
      });
      debugPrint("task add to the data base");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.done,
                size: 35,
              ),
              onPressed: () {
                createtask();
                Navigator.of(context).pop();
              })
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
                maxLength: 30,
                decoration: const InputDecoration(
                    hintText: 'Description', border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

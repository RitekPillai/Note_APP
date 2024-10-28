import 'package:flutter/material.dart';
import 'package:noteapp/addnotepage.dart';
import 'package:noteapp/notecard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepae extends StatefulWidget {
  const Homepae({super.key});

  @override
  State<Homepae> createState() => _HomepaeState();
}

class _HomepaeState extends State<Homepae> {
  @override
  Widget build(BuildContext context) {
    final fb = FirebaseFirestore.instance.collection('Notes').snapshots();

    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: StreamBuilder(
          stream: fb,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Text(
                'No Task Added :)',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ));
            }
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.0,
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                print(index);
                return index < 0
                    ? Center(child: Text("No Notes Added :)"))
                    : Notecard(
                        id: snapshot.data!.docs[index].id,
                        onpressed: () {
                          FirebaseFirestore.instance
                              .collection('Notes')
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        },
                        title: snapshot.data!.docs[index].data()['Title'],
                        notes: snapshot.data!.docs[index].data()['Notes'],
                      );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Addnotepage(),
        )),
        child: const Icon(Icons.add),
      ),
    );
  }
}

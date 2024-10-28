import 'package:flutter/material.dart';
import 'package:noteapp/addnotepage.dart';
import 'package:noteapp/display_addnotepage.dart';

class Notecard extends StatefulWidget {
  String id;
  String title;
  String notes;
  VoidCallback onpressed;

  Notecard({
    super.key,
    required this.title,
    required this.notes,
    required this.onpressed,
    required this.id,
  });

  @override
  State<Notecard> createState() => _NotecardState();
}

class _NotecardState extends State<Notecard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 100,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.grey[500],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: widget.onpressed,
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Notepage(
                                id: widget.id,
                              ),
                            ));
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  )
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: Text(
                  widget.notes,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

final lists = FirebaseFirestore.instance.collection('lists');

class BottomSheat extends StatefulWidget {
  final QueryDocumentSnapshot snapshot;
  BottomSheat({
    this.snapshot,
  });
  @override
  _BottomSheatState createState() => _BottomSheatState();
}

class _BottomSheatState extends State<BottomSheat> {
  String newItemTitle;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          // final data = snapshot.data.docs;

          return Container(
            height: MediaQuery.of(context).size.height / 3,
            color: Color(0xff757575),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: 300,
              decoration: BoxDecoration(
                color: Color(0xFF0A0A0A).withOpacity(0.8),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Add Item',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.3),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          newItemTitle = value;
                        });
                      },
                      autofocus: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(2),
                        hintText: 'title',
                        hintStyle: GoogleFonts.aBeeZee(color: Colors.white),
                        focusColor: Colors.black,
                        hoverColor: Colors.black,
                        // filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 0.3),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: MaterialButton(
                        onPressed: () async {
                          if (widget.snapshot != null) {
                            await FirebaseFirestore.instance
                                .collection('lists')
                                .doc(widget.snapshot.id)
                                .update({'title': newItemTitle})
                                .whenComplete(() => Navigator.pop(context))
                                .catchError((e) {
                                  print(e);
                                });
                          } else {
                            await FirebaseFirestore.instance
                                .collection('lists')
                                .add({
                              newItemTitle.toString(): {},
                              'Created date': DateTime.now(),
                              'Last modified on': '',
                              'title': newItemTitle,
                              'user': FirebaseAuth.instance.currentUser.email
                            }).then((value) {
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

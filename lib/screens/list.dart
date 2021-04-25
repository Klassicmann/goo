import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goo/screens/widgets/botomsheet.dart';
import 'package:google_fonts/google_fonts.dart';

class Lists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Lists',
          style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.w600, fontSize: 17, letterSpacing: .5),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return BottomSheat();
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Color(0xFF0A0A0A),
        child: StreamBuilder<QuerySnapshot>(
            stream: lists.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.orange,
                ));
              }

              List<Dismissible> items = [];

              snapshot.data.docs.map((e) {
                Timestamp time = e.data()['Created date'];

                Map ma = e.data()[e.data()['title']];

                int count;
                if (ma != null) {
                  count = ma.length;
                }
                String user = e.data()['user'];

                if (user == FirebaseAuth.instance.currentUser.email)
                  items.add(Dismissible(
                    background: Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                      
                      ),
                    ),
                    key: Key(e.id),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Confirm',
                                style: GoogleFonts.k2d(color: Colors.black),
                              ),
                              content: Text('Are you sure you want to delete?'),
                              actions: [
                                MaterialButton(
                                  color: Colors.orange,
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text('Delete'),
                                ),
                                MaterialButton(
                                  color: Colors.orange,
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('Cancel'),
                                ),
                              ],
                            );
                          });
                    },
                    onDismissed: (direction) {
                      lists.doc(e.id).delete();
                    },
                    child: GestureDetector(
                      onLongPress: () async {
                        await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return BottomSheat(snapshot:e);
                            });
                      },
                      onTap: () {
                        
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width ,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e['title'],
                              style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.grey[200],
                                  letterSpacing: .5),
                            ),
                            Text(
                              count != null? count <= 1 ? '$count item' : '$count items':'',
                              style: GoogleFonts.lato(fontSize: 15),
                            ),
                            Text(
                              '${time.toDate().day}-${time.toDate().month}-${time.toDate().year}',
                              style: GoogleFonts.lato(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
              }).toList();
              items.reversed;
              return ListView(
                children: items,
              );
            }),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.orange, borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rice',
            style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.grey[200],
                fontWeight: FontWeight.bold),
          ),
          Text(
            '3 items',
            style: GoogleFonts.lato(fontSize: 15),
          ),
          Text(
            'Created on 12/12/2021',
            style: GoogleFonts.lato(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

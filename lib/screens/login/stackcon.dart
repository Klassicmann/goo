
import 'package:flutter/material.dart';

class StackCon extends StatelessWidget {
  final String text;
  StackCon({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      
      child: Stack(alignment: AlignmentDirectional.center, children: [
        ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),

                  child: Image(
            image: AssetImage('assets/images/peppers authentico mexicano.jpg'),
            fit: BoxFit.cover,
            height: 250,
          ),
        ),
        Container(
          width: double.infinity,
          height: 250,
          color: Colors.black26,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
          ),
        ),
      ]),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
      ),
    );
  }
}

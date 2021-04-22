import 'package:flutter/material.dart';

class Card1 extends StatefulWidget {
  final Widget child;
  Card1({Key key, @required this.child}) : super(key: key);
  @override
  
  _Card1State createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  
  @override
  
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.all(20.0),
          
          decoration: BoxDecoration(
           color: Colors.white,
           boxShadow: [BoxShadow(offset: Offset(0,10),blurRadius:30,color: Colors.black38)],
            
            borderRadius : BorderRadius.all(Radius.circular(20))
          ),
          
            padding: EdgeInsets.all(20.0),
            child: widget.child
          ),
      ],
      
    );
  }
}
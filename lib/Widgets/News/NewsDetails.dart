import 'dart:convert';

import 'package:flutter/material.dart';

class NewsDetails extends StatefulWidget {
  var newsList;
  NewsDetails(this.newsList);
  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title:Text("Details"),
      backgroundColor: Colors.red,),

        body:Container(
        // width: 300,
        // height: 300,
       
        child: Container(
          child:ListView(
            children: <Widget>[
               
                Padding(
                padding: EdgeInsets.only(left:20,right:20,bottom:30,top: 30),
                child:Text(widget.newsList['title'],
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              ),
               
                Padding(
          padding: EdgeInsets.only(left:20,right:20,bottom:30),
        child:Container(
          // width:MediaQuery.of(context).size.width/1.5,
          // height:100,
          decoration: BoxDecoration(
            // image:DecorationImage(scale:0.1,image:AssetImage("images/live.png"))
          ),
        child:widget.newsList['image'].toString()=="NULL"||widget.newsList['image'].toString()==null?SizedBox():Image.memory(base64Decode(widget.newsList['image']),fit:BoxFit.cover,height: 100,)
        ),
        ),
         
              Padding(
                padding: EdgeInsets.only(left:20,bottom:30,right:30),

                child:Container(
                  // color: Colors.red,
                  width:MediaQuery.of(context).size.width/1.2,
                  // height:MediaQuery.of(context),
                  child:Text(widget.newsList['detail'],
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  overflow: TextOverflow.clip,
                  ),
                ),
                  
              ),
            
            ],
          ),
        ),
      
    ));
  }
}

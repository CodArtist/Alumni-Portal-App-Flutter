import 'dart:convert';

import 'package:flutter/material.dart';
import 'NewsDetails.dart';




class NewsCard extends StatefulWidget {
  var newsList;
  var name;
  // var batch;
  var image;
  var userDetail;
  var news_time;
  NewsCard(this.newsList,this.userDetail)
  {    news_time=newsList['news_time'].split(" ")[0];
    DateTime current= DateTime.now();
    // news_time="2021-01-08";
    DateTime current_date = new DateTime(current.year, current.month,current.day);
    news_time=DateTime.parse(news_time).difference(current_date).inDays.toString();
    if(news_time=="0")
    {
      news_time="Today";
    }
    else
    {
      var diff=int.parse(news_time)*-1;
      if(diff<30)
      {
        news_time=(diff-(diff%7))/7==0? diff.toString()+(diff.toString()!="1"? " days ago":" day ago"): (((diff-(diff%7))/7).round()).toString() + ((((diff-(diff%7))/7).round()).toString()!="1"? " weeks ago":" week ago");
      }
            if(diff>=30)
      {
        news_time= ((diff-(diff%30))/30).round()!=1?(((diff-(diff%30))/30).round()).toString() + " months ago":(((diff-(diff%30))/30).round()).toString() + " month ago";
      }

    }
     userDetail.forEach((user){
        if(user['enrollmentNo']==newsList['enrollmentNo'])
        {
          this.name=user['Name'];
          this.image=user['image'];
          // this.batch=user['batch'];
        }
    });

  }
  @override
  _NewsCard createState() => _NewsCard();
}

class _NewsCard extends State<NewsCard> {

@override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation:20.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
        (20.0),
      )),
      child: Padding(
        padding:EdgeInsets.only(left:10,top:30),
      child:Container(
        // padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
        // height: MediaQuery.of(context).size.height/4,
        width: MediaQuery.of(context).size.width/2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: widget.image.toString()=="null"?AssetImage('images/noface.png'):MemoryImage(base64Decode(widget.image)),
              ),
              title: Text(widget.name,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  )),
              // subtitle: Text(
              //    "Alumni of " + (int.parse(widget.batch)-4).toString() +"-" +widget.batch +" batch" ,
              //   style: TextStyle(fontSize: 10.0, color: Colors.grey),
              // ),
            ),
        
        Padding(
          padding: EdgeInsets.only(left:20,right:20,bottom:30),
        child:ClipRRect(
          // width:MediaQuery.of(context).size.width/1.5,
          borderRadius: BorderRadius.circular(20),

          // height:100,
          // decoration: BoxDecoration(
          //   // image:DecorationImage(scale:0.1,image:AssetImage("images/live.png"))
          // ),
        // child:Image.asset("images/live.png",fit:BoxFit.fill),
        child:widget.newsList['image'].toString()=="NULL"||widget.newsList['image'].toString()==null||widget.newsList['image'].toString().isEmpty?SizedBox():Image.memory(base64Decode(widget.newsList['image']),fit:BoxFit.cover,height: 100,)
        ),
        ),
        
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left:20,right:20),
                child:Text(widget.newsList['title'],
                  style: TextStyle(fontSize:15.0, color: Colors.black,fontWeight: FontWeight.bold),
                )
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width:20.0,
                    ),
                   SizedBox(
                      width: 95,
                    child:Text(
                      widget.news_time,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                    ),
                    SizedBox(
                      width: 100.0,
                    ),
                    FlatButton(
                        onPressed: () => Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => NewsDetails(widget.newsList))),
                        child: Text(
                          'Read More...',
                          style: TextStyle(fontSize: 16.0, color: Colors.cyan),
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      ),
    );

  }


}
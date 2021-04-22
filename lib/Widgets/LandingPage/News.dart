
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../Widgets/News/NewsDetails.dart';





class NewsCard extends StatefulWidget {
  var newsList;
  var name;
  var batch;
  var image;
  var userDetail;
  var news_time;
  NewsCard(this.newsList,this.userDetail)
  { 
    news_time=newsList['news_time'].split(" ")[0];
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
          this.batch=user['batch'];
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






















// import 'dart:convert';

// import 'package:flutter/material.dart';
// import '../../Widgets/News/NewsCard.dart';

// import 'package:http/http.dart' as http;
// import 'package:shimmer/shimmer.dart';


// class News extends StatefulWidget {
//   var name;
//   News(var name)
//   {
//     this.name=name;
//   }
//   @override
//   _News createState() => _News();
// }

// class _News extends State<News> {
// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// var newsList=[];
// var userList=[];
// var listIsLoading =true;
//   @override
// void initState() {
//     super.initState();
//     loadNews();
// }
// loadNews()async{
// String url="https://alumniportal2001.000webhostapp.com/GetNews.php";
// final response=await http.get(url);
// if(jsonDecode(response.body)!="Not Found")
// {setState(() {
//   newsList=jsonDecode(response.body)[0];
//   userList=jsonDecode(response.body)[1];

//   listIsLoading=false;
// });
// }
// setState(() {
//   listIsLoading=false;
// });
// print(response.body);
// print(newsList);
// print(userList);
// }

// Widget ShimmerLayout(){
  
//   return Shimmer.fromColors( 
//   direction: ShimmerDirection.ttb,
//   baseColor: Colors.white, 
//   highlightColor: Colors.grey[300],
//   child:Container(
//     margin: EdgeInsets.only(left:30,right:30,top:30),
//     width:MediaQuery.of(context).size.width/10,
//     height:MediaQuery.of(context).size.height/2,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
//       color: Colors.grey,
//     ),
//   ),
//   );
// }


// @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//        home: Scaffold(
        

//          body:
//         //  Center(child:Text(newsList.length.toString())),
         
         
//          ListView.builder(
//            physics: BouncingScrollPhysics(),
//           itemCount: listIsLoading?3:newsList.length,
//           itemBuilder:(context,index){
//             return listIsLoading?ShimmerLayout():NewsCard(newsList[index],userList);
//           },
          
       
//        )
//        )
//     );
//   }


// }
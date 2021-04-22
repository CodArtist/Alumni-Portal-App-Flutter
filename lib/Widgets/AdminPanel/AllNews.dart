import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';




class AllNews extends StatefulWidget {
  var newsList;
 var user;
  var name;
  // var batch;
  var image;
  Widget delete;
  var news_time;
  AllNews(newsList,user,@required this.delete)
 { news_time=newsList['news_time'].split(" ")[0];
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
   this.user=user;
   this.newsList=newsList;
    user.forEach((ele){
     if(ele['enrollmentNo']==newsList['enrollmentNo'])
     {
         this.image=ele['image'];
         this.name=ele['Name'];
        //  this.batch=ele['batch'];
     }


    });
  }
  
  @override
  _AllNews createState() => _AllNews();
}

class _AllNews extends State<AllNews> {
verified(var enrollmentNo) async
  {
  var url ="https://alumniportal2001.000webhostapp.com/Verify.php";
  var response = await http.post(url,body:{
    "EnrollmentNo":enrollmentNo,
    "Function":"News",
    "Details":widget.newsList["detail"],
    "Verified":"1",
  });
  print(jsonDecode(response.body).toString());
  if(response.statusCode==200&&jsonDecode(response.body).toString()=="true")
  { setState(() {
    widget.newsList["Allowed"]="1";
  });
    Fluttertoast.showToast(msg:"Verified",
               backgroundColor: Colors.green,
               textColor: Colors.white);
  }
  else
  Fluttertoast.showToast(msg:"Error occured",
               backgroundColor: Colors.red,
               textColor: Colors.white);
  }

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
                backgroundImage:widget.image.toString()=="null"?AssetImage('images/noface.png'):MemoryImage(base64Decode(widget.image)),
              ),
              title: Text(widget.name,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight:FontWeight.bold
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
        child:widget.newsList['image'].toString()=="NULL"? SizedBox():Image.memory(base64Decode(widget.newsList['image']),fit:BoxFit.cover,height: 100,)
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
            ),
        
        //*************************************Verify********************************************** */
      
      Row(
       children:<Widget>[
         Padding(
         padding: EdgeInsets.all(10),
         child:Container(
           width:MediaQuery.of(context).size.width/4,
           height:35,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(50),
             boxShadow: [BoxShadow(color:Colors.black26,blurRadius:10,spreadRadius:0,offset:Offset(0,10))],
             color:widget.newsList["Allowed"]=="1"?Colors.greenAccent[400]:Colors.blue,
           ),
           child:FlatButton(
             onPressed: (()async{
                                         var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                 widget.newsList["Allowed"]!="1"?verified(widget.newsList["enrollmentNo"]):Fluttertoast.showToast(msg:"Already Verified",
               backgroundColor: Colors.green,
               textColor: Colors.white);
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }

               
             }),
             child: Text(widget.newsList["Allowed"]=="1"?"Verified":"Verify",
             style:TextStyle(fontWeight:FontWeight.bold,color:Colors.white),),
             )
         ) ,
         ),
     //***************************************************Delete************************************************** */
              SizedBox(width:100,),

        
        widget.delete,
     
     
     
       ],
      ),
        
        
        
        
        
          ],
        ),
      ),
      ),
    );

  }


}



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
      appBar: AppBar(title:Text("Details"),),

        body:Container(
        // width: 300,
        // height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/1.webp'),
          ),
        ),
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
        child:widget.newsList['image'].toString()=="NULL"? SizedBox():Image.memory(base64Decode(widget.newsList['image']),fit:BoxFit.cover,height: 100,)
        ),
        ),
             
              Padding(
                padding: EdgeInsets.only(left:20,right:20,bottom:30),

                child:Text(widget.newsList['detail'],
                  style: TextStyle(fontSize: 15.0, color: Colors.black)),
              ),
            ],
          ),
        ),
      
    ));
  }
}

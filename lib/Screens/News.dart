import 'dart:convert';

import 'package:flutter/material.dart';
import '../Widgets/Dashboard/drawer.dart';
import '../Widgets/News/NewsCard.dart';

import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../Widgets/News/NewsUpload.dart';


class News extends StatefulWidget {
  var name;
  News(var name)
  {
    this.name=name;
  }
  @override
  _News createState() => _News();
}

class _News extends State<News> {
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

var newsList=[];
var userList=[];
var listIsLoading =true;
  @override
void initState() {
    super.initState();
    loadNews();
}
loadNews()async{
String url="https://alumniportal2001.000webhostapp.com/GetNews.php";
final response=await http.get(url);
if(jsonDecode(response.body)!="Not Found")
{setState(() {
  newsList=jsonDecode(response.body)[0];
  userList=jsonDecode(response.body)[1];

  listIsLoading=false;
});
}
setState(() {
  listIsLoading=false;
});
print(response.body);
print(newsList);
print(userList);
}

Widget ShimmerLayout(){
  
  return Shimmer.fromColors( 
  direction: ShimmerDirection.ttb,
  baseColor: Colors.white, 
  highlightColor: Colors.grey[300],
  child:Container(
    margin: EdgeInsets.only(left:30,right:30,top:30),
    width:MediaQuery.of(context).size.width/10,
    height:MediaQuery.of(context).size.height/2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
      color: Colors.grey,
    ),
  ),
  );
}


@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Scaffold(
         floatingActionButton:Stack(
        children:<Widget>[
      Align(
        alignment: Alignment(-0.8,-0.85),
      child: FloatingActionButton(
      elevation:30,
      backgroundColor: Colors.red,
      onPressed: (){
        _scaffoldKey.currentState.openDrawer();

      },
      child:Center(
        child:Column(
        children: [
         Padding(
           padding: EdgeInsets.only(top:15),
         child: Container(
            height: 5,
            width: 25,
            decoration:BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10),
            )
          )
         ),
        
        Padding(
           padding: EdgeInsets.only(top:5),
         child: Container(
            height: 5,
            width: 25,
            decoration:BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10),
            )
          )
         ),
        
         Padding(
           padding: EdgeInsets.only(top:5),
         child: Container(
            height: 5,
            width: 25,
            decoration:BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10),
            )
          )
         ),
        
        ],
      )
    ),
    ),
      ),
        
        //*************Upload****************** */
        Align(
          alignment: Alignment.bottomRight,
          child:FloatingActionButton(
           child: Icon(Icons.drive_folder_upload,color: Colors.white,),
            backgroundColor: Colors.blue,
            onPressed:((){
                Navigator.of(context).push(
   PageRouteBuilder(
    pageBuilder: (
        BuildContext context, 
        Animation<double> animation, 
        Animation<double> secondaryAnimation) {
      return NewsUpload(widget.name);
    },
    transitionsBuilder: (
        BuildContext context, 
        Animation<double> animation, 
        Animation<double> secondaryAnimation, 
        Widget child) {
     var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds:500),
  ),
);
            }),
            

          ))
        ],
      ),
             key: _scaffoldKey,
         drawer: SafeArea(
    
      child:ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(50)),
      child: Drawer1(widget.name,"News"),),),

         body:newsList.length!=0||listIsLoading?
        //  Center(child:Text(newsList.length.toString())),
         
         
         ListView.builder(
           physics: BouncingScrollPhysics(),
          itemCount: listIsLoading?3:newsList.length,
          itemBuilder:(context,index){
            return listIsLoading?ShimmerLayout():NewsCard(newsList[index],userList);
          },
         
          
       
       ):
       SingleChildScrollView(
physics:AlwaysScrollableScrollPhysics(),
child:Padding(padding:EdgeInsets.only(top:200),child:Column(
            children:<Widget>[
              CircleAvatar(
                radius: 70,
                backgroundImage:AssetImage("images/error.png")
              ),
              Padding(padding: EdgeInsets.only(top:20),
              child:Center(child: Text("Nothing found"),
              ),
              ),
            
            ],
              ),
          ),
),
      
       )
    );
  }


}
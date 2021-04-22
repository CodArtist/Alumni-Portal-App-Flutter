import 'package:AlumniPortal/Screens/Dashboard.dart';
import 'package:flutter/material.dart';
import'../../Screens/Login.dart';
import '../../Screens/Internships.dart';
import '../../Screens/News.dart';
import '../../Screens/EventsHome.dart';
import 'EditProfile.dart';
import '../../User.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';




class Drawer1 extends StatefulWidget {
  var name;
  var currentPage;
  var dashboard=false;
  var internships=false;
  var news=false;
  var events=false;

  Drawer1(var name,this.currentPage)
  {
    this.name=name;
    if(currentPage=="Dashboard")
    this.dashboard=true;
    if(currentPage=="Internships")
    this.internships=true;
        if(currentPage=="News")
    this.news=true;
        if(currentPage=="Events")
    this.events=true;
  }
  @override
  _Drawer1State createState() => _Drawer1State();
}

class _Drawer1State extends State<Drawer1> {
  DateTime current;
  Future<bool> popped(){
    DateTime now=DateTime.now();
    if(current==null||now.difference(current)>Duration(seconds:2))
    {
      current=now;
      Fluttertoast.showToast(msg:"Press Again to exit");
      return Future<bool>.value(false);
    }
    else
    {
      return Future<bool>.value(true);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width:MediaQuery.of(context).size.width/1.6,
      child:Drawer(
      elevation: 16,
      
  child:Column(
  children:<Widget>[
    Container(
      // width:double.infinity,
      // padding: EdgeInsets.all(20),
      // height:MediaQuery.of(context).size.height/3,
      
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.only(topRight:Radius.circular(100)),
        color: Colors.redAccent,
      ),
      child: Center(child: Column(children: [
          Padding(
            padding:EdgeInsets.only(top:30,bottom:10),
            child:CircleAvatar(
                  backgroundImage: User.image.toString()=="null"?AssetImage("images/noface.png"):MemoryImage(base64Decode(User.image)),
                  radius:35,
                
                
                ),
          ),
        
          
            Text(widget.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
         
  //        Padding(
  //          padding: EdgeInsets.only(left:50),
  //          child:Row(
  //          children:<Widget>[
  //  FlatButton(child: Text("Edit Profile",style:TextStyle(color: Colors.white,fontSize: 10),), onPressed:((){
  //         Navigator.pop(context);
  //          Navigator.push(context,MaterialPageRoute(builder:(context)=>EditProfile(),));
  //         }),),
  //          Container(
  //                 height: 30,
  //                 width: 30,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(30),
  //               boxShadow: [BoxShadow(color:Colors.black26,spreadRadius:0,blurRadius:10,offset: Offset(0,10))],
  //               color: Colors.white
  //             ),
                  
  //                 child:Icon(Icons.edit,
  //               color: Colors.greenAccent,
  //               size: 20
  //               )
  //               ),
           
  //          ],
  //        ),
  //        ),

     FlatButton(
                  minWidth:0.1,
                  
                  onPressed: ((){
 Navigator.pop(context);
           Navigator.push(context,MaterialPageRoute(builder:(context)=>EditProfile(),));                  }),
                  child:Container(
                  height: 30,
                  width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color:Colors.black26,spreadRadius:0,blurRadius:10,offset: Offset(0,10))],
                color: Colors.white
              ),
                  
                  child:Icon(Icons.edit,
                color: Colors.greenAccent,
                size: 20
                )
                ),
                )
      ],)
      ,)
    ),
    
   
Expanded(
  child:ListView(      
 children:<Widget>[
   Padding(
  padding: EdgeInsets.only(top:10,left:10,right:10),
    child:Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: widget.dashboard?Color(0xffFFC2AE):Colors.white,
      
      ),
    child:ListTile(
      leading: Icon(Icons.dashboard),
      title: Text("Dashboard",
      style: TextStyle(
        fontSize:18,
      ),),
      onTap: ((){
         
         Navigator.of(context).pop();
         Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) =>WillPopScope(
           onWillPop: ()=>popped(),
           child:Dashboard(widget.name)),
         )
        );
      }),
    ),
    ),
),
  
   Padding(
  padding: EdgeInsets.only(top:10,left:10,right:10),
    child:Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: widget.internships?Color(0xffFFC2AE):Colors.white,
      
      ),
    child:ListTile(
      leading: Icon(Icons.accessibility_new),
      title: Text("Internships",
      style: TextStyle(
        fontSize:18
      ),),
      onTap: (()async{
         var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                  Navigator.of(context).pop();
         Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) =>WillPopScope(
           onWillPop:()=> popped(),
           child:Internships(widget.name)),
         )
         );
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }
       
      }),
    ),
    ),
   ),
    
    Padding(
  padding: EdgeInsets.only(top:10,left:10,right:10),
    child:Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      
      ),
    child:ListTile(
      leading: Icon(Icons.group),
      title: Text("Groups",
      style: TextStyle(
        fontSize:18
      ),),
      onTap:(){ Fluttertoast.showToast(msg:"Comming Soon..",
      backgroundColor: Colors.green,
      textColor: Colors.white);
      }
    ),
    )
    ),
   
      Padding(
  padding: EdgeInsets.only(top:10,left:10,right:10),
    child:Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: widget.news?Color(0xffFFC2AE):Colors.white,
      
      ),
    child:ListTile(
      leading: Icon(Icons.wb_iridescent),
      title: Text("News",
      style: TextStyle(
        fontSize:18
      ),),
      onTap:()async{
          var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                  Navigator.of(context).pop();
         Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) =>WillPopScope(
                     onWillPop:()=> popped(),

           child:News(widget.name)),
         )    
         );
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }
        
      },
    ),
    )
      ),

       Padding(
  padding: EdgeInsets.only(top:10,left:10,right:10),
    child:Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: widget.events?Color(0xffFFC2AE):Colors.white,
      
      ),
    child:ListTile(
      leading: Icon(Icons.event),
      title: Text("Events",
      style: TextStyle(
        fontSize:18
      ),),
      onTap:()async{
          var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                  Navigator.of(context).pop();
         Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) =>WillPopScope(
                     onWillPop:()=> popped(),

           child:EventHomePage(widget.name)),
         )
         );
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }
       
      },
    ),
    )
       ),
    
    
   Padding(
  padding: EdgeInsets.only(top:10,left:10,right:10),
    child:Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color:Colors.white,
      
      ),
    child: ListTile(
      leading: Icon(Icons.face),
      title: Text("Discussion",
      style: TextStyle(
        fontSize:18
      ),),
       onTap:(){ Fluttertoast.showToast(msg:"Comming Soon..",
      backgroundColor: Colors.green,
      textColor: Colors.white);
      }
    ),
    )
   ),

    Padding(
  padding: EdgeInsets.only(top:10,left:10,right:10),
    child:Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color:Colors.white,
      
      ),
    child:ListTile(
      leading: Icon(Icons.fiber_smart_record),
      title: Text("Mentees",
      style: TextStyle(
        fontSize:18
      ),),
      onTap:(){ Fluttertoast.showToast(msg:"Comming Soon..",
      backgroundColor: Colors.green,
      textColor: Colors.white);
      }
    ),
    )
    ),
   
   

 
Padding(
  padding: EdgeInsets.only(top:10,left:10,right:10),
    child:Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color:Colors.white,
      
      ),
    child:ListTile(
      leading: Icon(Icons.laptop_windows),
      title: Text("Logout",
      style: TextStyle(
        fontSize:18
      ),),
      onTap:((){
//        int count = 1;
// Navigator.of(context).popUntil((_) => count-- <= 0);
 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
   builder: (context) =>
    Login()), 
    (Route<dynamic> route) =>false)
    ;    
      }),
    ),
    )
),
 
 
 ],
),
),
   ],),),
    );     
  
  }
}
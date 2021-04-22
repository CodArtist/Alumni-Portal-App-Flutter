import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:connectivity/connectivity.dart';






// import 'package:flutter_app/images.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:async';
import '../Widgets/Events/User.dart';
import '../Widgets/AdminPanel/Services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Widgets/Dashboard/drawer.dart';
import '../Widgets/Events/ReunionUpload.dart';
import '../Widgets/Events/WebinarUpload.dart';
import '../Widgets/AdminPanel/AllAlumni.dart';
import '../Widgets/AdminPanel/AllNews.dart';
import '../Widgets/AdminPanel/AllInternships.dart';

class AdminPanel extends StatefulWidget {
  var token1;
  AdminPanel(this.token1);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}




class _AdminPanelState extends State<AdminPanel> with SingleTickerProviderStateMixin {

  List<User> Events = List();
  List<User> Events_Reunion = List();
  List<User> Events_Webinar = List();
  List<User> Events_Funding = List();
  String state1="1";
  String state2="2";
  String state3="3";

    var table_events=[];

    var reunions=[];
    var webinars=[];
    var fundings=[];

    var table_users=[];
    var table_news=[];
    var table_internships=[];

  var currentState=0;
    var listIsLoading=true;

  GlobalKey<RefreshIndicatorState> refreshKey;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
TabController _controller;

 delete_alumni_from_database(var enrollmentNo, var index) async
 {
    var url ="https://alumniportal2001.000webhostapp.com/Verify.php";
  var response = await http.post(url,body:{
    "EnrollmentNo":enrollmentNo,
    "Function":"Alumni",
    "Verified":"0",
  });
  if(response.statusCode==200&&jsonDecode(response.body).toString()=="true")
  {
    setState(() {
        table_users.removeAt(index);
    });
    Fluttertoast.showToast(msg:"deleted",
               backgroundColor: Colors.green,
               textColor: Colors.white);
  }
  else
  Fluttertoast.showToast(msg:"Error occured",
               backgroundColor: Colors.red,
               textColor: Colors.white);
 }


  delete_internship_from_database(var enrollmentNo, var index,var detail) async
 {
    var url ="https://alumniportal2001.000webhostapp.com/Verify.php";
  var response = await http.post(url,body:{
    "EnrollmentNo":enrollmentNo,
    "Function":"Internships",
    "Details":detail,
    "Verified":"0",
  });

  print(jsonDecode(response.body));
  if(response.statusCode==200&&jsonDecode(response.body).toString()=="true")
  {
    setState(() {
        table_internships.removeAt(index);
    });
    Fluttertoast.showToast(msg:"deleted",
               backgroundColor: Colors.green,
               textColor: Colors.white);
  }
  else
  Fluttertoast.showToast(msg:"Error occured",
               backgroundColor: Colors.red,
               textColor: Colors.white);
 }

 delete_news_from_database(var enrollmentNo, var index,var detail) async
 {
    var url ="https://alumniportal2001.000webhostapp.com/Verify.php";
  var response = await http.post(url,body:{
    "EnrollmentNo":enrollmentNo,
    "Function":"News",
    "Details":detail,
    "Verified":"0",
  });
 print("fnsanflsfnnnnnnnnnnnnn");
  print(jsonDecode(response.body));
  if(response.statusCode==200&&jsonDecode(response.body).toString()=="true")
  {
    setState(() {
        table_news.removeAt(index);
    });
    Fluttertoast.showToast(msg:"deleted",
               backgroundColor: Colors.green,
               textColor: Colors.white);
  }
  else
  Fluttertoast.showToast(msg:"Error occured",
               backgroundColor: Colors.red,
               textColor: Colors.white);
 }

Widget delete_alumni(var enrollmentNo,var index){
  return Padding(
         padding: EdgeInsets.all(10),
         child:Container(
           width:MediaQuery.of(context).size.width/4,
           height:35,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(50),
             boxShadow: [BoxShadow(color:Colors.black26,blurRadius:10,spreadRadius:0,offset:Offset(0,10))],
             color:Colors.red,
           ),
           child:FlatButton(
             onPressed: (()async{
                                          var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
               delete_alumni_from_database(enrollmentNo,index);
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }

             }),
                       child:Icon(Icons.delete_rounded,color:Colors.white)

             )
         ) ,
         );
}

Widget delete_internship(var enrollmentNo,var index,var detail){
  return Padding(
         padding: EdgeInsets.all(10),
         child:Container(
           width:MediaQuery.of(context).size.width/4,
           height:35,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(50),
             boxShadow: [BoxShadow(color:Colors.black26,blurRadius:10,spreadRadius:0,offset:Offset(0,10))],
             color:Colors.red,
           ),
           child:FlatButton(
             onPressed: (()async{
                                          var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
               delete_internship_from_database(enrollmentNo,index,detail);
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }

             }),
         child:Icon(Icons.delete_rounded,color:Colors.white)

             )
         ) ,
         );
}

Widget delete_news(var enrollmentNo,var index,var detail){
  return Padding(
         padding: EdgeInsets.all(10),
         child:Container(
           width:MediaQuery.of(context).size.width/4,
           height:35,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(50),
             boxShadow: [BoxShadow(color:Colors.black26,blurRadius:10,spreadRadius:0,offset:Offset(0,10))],
             color:Colors.red,
           ),
           child:FlatButton(
             onPressed: (()async{
                                          var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
               delete_news_from_database(enrollmentNo,index,detail);
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }

             }),
                       child:Icon(Icons.delete_rounded,color:Colors.white)

             )
         ) ,
         );
}


  @override
  void initState() {
    super.initState();
    setState(() {
      token=widget.token1;
    });
     _controller=new TabController(length:6,vsync: this);
      _controller.addListener(() {
        setState(() {
          currentState=_controller.index;
        });
         _firebaseMessaging.getToken().then((token1){
     print("token is"+ token1);
     setState(() {
       token=token1;
     });
    });
      });


    Services.getAll().then((arr){
     setState(() {
       
      table_events=arr[0];
      table_users=arr[1];
      table_news=arr[2];
      table_internships=arr[3];
      listIsLoading=false;
     });
     table_events.forEach((event) {
       if(event["EventId"]=="1")
        {
          print("event 1");
       setState(() {
         reunions.add(event);
       });

       }
        if(event["EventId"]=="2"){
          print("event 2");
       setState(() {
         webinars.add(event);
       });      
        }
        if(event["EventId"]=="3"){
          print("event 3");
       setState(() {
         fundings.add(event);
       });
        }
     });
    });



  }
  newList(){
    setState(() {
      listIsLoading=true;
    });
 Services.getAll().then((arr){
     setState(() {
       
      table_events=arr[0];
      table_users=arr[1];
      table_news=arr[2];
      table_internships=arr[3];
      listIsLoading=false;
     });
     table_events.forEach((event) {
       if(event["EventId"]=="1")
        {
          print("event 1");
       setState(() {
         reunions.add(event);
       });

       }
        if(event["EventId"]=="2"){
          print("event 2");
       setState(() {
         webinars.add(event);
       });      
        }
        if(event["EventId"]=="3"){
          print("event 3");
       setState(() {
         fundings.add(event);
       });
        }
     });
    });


  }

  Future<Null> refreshList() async{
    await Future.delayed(Duration(seconds: 1));
        }


FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
  String token;

  saveToken()async
  {print("hejgjgjgf");
  print(token);
      
  if(token!=null)
  {
 var url ="https://alumniportal2001.000webhostapp.com/DeviceToken.php";
  var response = await http.post(url,body:{
         'Token':token
  });  
  if(response.statusCode==200)
  { if(response.body.toString()=="token already exists")
  {
     Fluttertoast.showToast(msg:"Already allowed",
    backgroundColor: Colors.green,
    textColor: Colors.white
    );
  }
  else
   { Fluttertoast.showToast(msg:"Allowed",
    backgroundColor: Colors.green,
    textColor: Colors.white
    );
   }
  }
  else
   {Fluttertoast.showToast(msg:"Error occured",
    backgroundColor: Colors.red,
    textColor: Colors.white
    );
   }
  
  
  }
  else
  {print("can");
    Fluttertoast.showToast(msg:"Error occured",
    backgroundColor: Colors.red,
    textColor: Colors.white
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    Size screen=MediaQuery.of(context).size;
    return DefaultTabController(
      length: 6,
      child: Scaffold(
            

//               floatingActionButton:Stack(
//         children:<Widget>[
 
        
//         //*************Upload****************** */
//         Align(
//           alignment: Alignment.bottomRight,
//           child:FloatingActionButton(
//            child: Icon(Icons.drive_folder_upload,color: Colors.white,),
//             backgroundColor: Colors.blue,
//             onPressed: (){
            
//               // print(table_events);
//               print(reunions);
//               print(webinars);
//              Navigator.of(context).push(
//    PageRouteBuilder(
//     pageBuilder: (
//         BuildContext context, 
//         Animation<double> animation, 
//         Animation<double> secondaryAnimation) {
//           if(currentState==0)
//       return ReunionUpload(widget.name);
//                 if(currentState==1)
//       return WebinarUpload(widget.name);
//                 if(currentState==2)
//       return ReunionUpload(widget.name);
//     },
//     transitionsBuilder: (
//         BuildContext context, 
//         Animation<double> animation, 
//         Animation<double> secondaryAnimation, 
//         Widget child) {
//      var begin = Offset(0.0, 1.0);
//       var end = Offset.zero;
//       var curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//     transitionDuration: Duration(milliseconds:500),
//   ),
// );
//             },

//           ))
//         ],
//       ),
      
    // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    key: _scaffoldKey,


        appBar: PreferredSize(
  preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/6),
  child:AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(icon:Icon(Icons.settings,color:Colors.white), onPressed: (){
              print("hhjgb");
                     return showDialog(context: context, builder:(context){     
                       return Dialog(
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                          insetPadding: EdgeInsets.only(top:250,bottom:250,left:50,right:50),
                             elevation: 0,
                             backgroundColor:Colors.white ,
                              child: Column(
                                children:<Widget>[
                                  SizedBox(height: 30,),
                                  Text("Allow Notification?",
                                  style:TextStyle(fontSize:15)
                                  ),
                                SizedBox(height: 10,),
                                 Row(
                                    children:<Widget>[
                                      FlatButton(child: Text("Yes"),onPressed:(){
                                        saveToken();
                                        Navigator.of(context).pop();
                                      },),
                                   SizedBox(width: 70,),
                                   FlatButton(child: Text("No"),onPressed:(){
                                        Navigator.of(context).pop();
                                      },),
                                   
                                    ]
                                  ),
                                ]
                              ),
                      );
                     });
            })
          ],
          // backgroundColor: Color(0xff28D9CE),
          backgroundColor:Colors.blueAccent,
          // title: Text("Events"),
          bottom: TabBar(
            isScrollable: true,
            controller: _controller,

            indicatorColor: Colors.white,
            labelColor: Colors.white,

            tabs: <Widget>[
               Tab(
               icon: Icon(Icons.person),
                child:Text("Alumni",style: TextStyle(fontSize: 15),),
              ),
             Tab(
               icon: Icon(Icons.work),
                child:Text("Internships",style: TextStyle(fontSize: 15),),
              ),
            Tab(
              icon: Icon(Icons.pages),
                child:Text("news",style: TextStyle(fontSize: 15),),
            ),
              Tab(
                icon: Icon(Icons.people),
                child:Text("Reunion",style: TextStyle(fontSize:15),),
              ),
              Tab(
               icon: Icon(Icons.video_call),
                child:Text("Webinars",style: TextStyle(fontSize: 15),),
              ),
              Tab(
                icon: Icon(Icons.money),
                child:Text("Funding",style: TextStyle(fontSize: 15),),
              ),
            
              
            ],
          ),
        ),
        ),
        body:Container(
          color: Colors.grey[10],
          child: TabBarView(
            controller: _controller,

            children: <Widget>[
              tab1(table_users,screen,listIsLoading,delete_alumni),
              tab2(table_internships,table_users,screen,listIsLoading,delete_internship),
              tab3(table_news,table_users,screen,listIsLoading,delete_news),

              tab4(reunions,screen,listIsLoading),
              tab5(webinars,screen,listIsLoading),
              tab6(fundings,screen),


            ],
          ),
        ),
    
      ),
    );
  }



RefreshIndicator tab1(var alumni,Size screen,var listIsLoading,var delete) {
var temp=[];
alumni.forEach((ele){
if(ele["Allowed"]=="0")
temp.add(ele);
});
alumni=temp;
  Widget ShimmerLayout(){
  
  return Shimmer.fromColors( 
  direction: ShimmerDirection.ttb,
  baseColor: Colors.white, 
  highlightColor: Colors.grey[300],
  child:Container(
    margin: EdgeInsets.only(left:30,right:30,top:30),
    width:screen.width/10,
    height:screen.height/2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
      color: Colors.grey,
    ),
  ),
  );
}
 return RefreshIndicator(   onRefresh:((){ 
    return Future.delayed( 
                  
      Duration(seconds: 1), 
      () { 
        setState(() { 
              newList();

        }); 
                  
                });
 }),
child:Padding(
  padding:EdgeInsets.only(top:30),
  child:alumni.length!=0||listIsLoading?
  ListView.builder(
  physics: BouncingScrollPhysics(),
itemCount: listIsLoading?3:alumni.length,
itemBuilder: (BuildContext context,index){
  Widget del;
  if(!listIsLoading)
  del=delete(alumni[index]["enrollmentNo"],index);
  // if(alumni[index]["Allowed"]=="0")
  return listIsLoading?ShimmerLayout():AllAlumni(alumni[index],del);
},
):
SingleChildScrollView(
physics:AlwaysScrollableScrollPhysics(),
child:Padding(padding:EdgeInsets.only(top:50),child:Column(
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

),
);
}

RefreshIndicator tab2(var internships,var users,Size screen,var listIsLoading,var delete) {
  Widget ShimmerLayout(){
  
  return Shimmer.fromColors( 
  direction: ShimmerDirection.ttb,
  baseColor: Colors.white, 
  highlightColor: Colors.grey[300],
  child:Container(
    margin: EdgeInsets.only(left:30,right:30,top:30),
    width:screen.width/10,
    height:screen.height/2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
      color: Colors.grey,
    ),
  ),
  );
}

 return RefreshIndicator(  onRefresh:((){ 
    return Future.delayed( 
                  
      Duration(seconds: 1), 
      () { 
        setState(() { 
              newList();

        }); 
                  
                });
 }),
child:Padding(
  padding:EdgeInsets.only(top:30),
child:internships.length!=0||listIsLoading?
ListView.builder(
  physics: BouncingScrollPhysics(),
itemCount: listIsLoading?3:internships.length,
itemBuilder: (BuildContext context,index){
   Widget del;
  if(!listIsLoading)
  del=delete(internships[index]["enrollmentNo"],index,internships[index]["details"]);
  return listIsLoading?ShimmerLayout():AllInternships(internships[index],users,del);
},
):
SingleChildScrollView(
physics:AlwaysScrollableScrollPhysics(),
child:Padding(padding:EdgeInsets.only(top:50),child:Column(
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
),
);
}

RefreshIndicator tab3(var news,var users,Size screen,var listIsLoading,var delete) {
  Widget ShimmerLayout(){
  
  return Shimmer.fromColors( 
  direction: ShimmerDirection.ttb,
  baseColor: Colors.white, 
  highlightColor: Colors.grey[300],
  child:Container(
    margin: EdgeInsets.only(left:30,right:30,top:30),
    width:screen.width/10,
    height:screen.height/2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
      color: Colors.grey,
    ),
  ),
  );
}

 return RefreshIndicator(  onRefresh:((){ 
    return Future.delayed( 
                  
      Duration(seconds: 1), 
      () { 
        setState(() { 
              newList();

        }); 
                  
                });
 }),
 child:Padding(
  padding:EdgeInsets.only(top:30),
child:news.length!=0||listIsLoading?
ListView.builder(
  physics: BouncingScrollPhysics(),
itemCount: listIsLoading?3:news.length,
itemBuilder: (BuildContext context,index){
  Widget del;
  if(!listIsLoading)
  del=delete(news[index]["enrollmentNo"],index,news[index]["detail"]);
  return listIsLoading?ShimmerLayout():AllNews(news[index],users,del);
},
):
 SingleChildScrollView(
physics:AlwaysScrollableScrollPhysics(),
child:Padding(padding:EdgeInsets.only(top:50),child:Column(
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
 
 ),
);
}

RefreshIndicator tab4(var Events,Size screen,var listIsLoading) {
var image;
var name;
// var batch;

verified(var enrollmentNo,var description,var index) async
  {
  var url ="https://alumniportal2001.000webhostapp.com/Verify.php";
  var response = await http.post(url,body:{
    "EnrollmentNo":enrollmentNo,
    "Function":"Events",
    "EventId":"1",
    "Details":description,
    "Verified":"1",
  });
  if(response.statusCode==200)
  {setState(() {
    reunions[index]['verify']="1";
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

  delete_reunion_from_database(var enrollmentNo ,var description,index)async{
 var url ="https://alumniportal2001.000webhostapp.com/Verify.php";
  var response = await http.post(url,body:{
    "EnrollmentNo":enrollmentNo,
    "Function":"Events",
    "Details":description,
    "EventId":"1",
    "Verified":"0",
  });

  print(jsonDecode(response.body));
  if(response.statusCode==200&&jsonDecode(response.body).toString()=="true")
  {
    setState(() {
        reunions.removeAt(index);
    });
    Fluttertoast.showToast(msg:"deleted",
               backgroundColor: Colors.green,
               textColor: Colors.white);
  }
  else
  Fluttertoast.showToast(msg:"Error occured",
               backgroundColor: Colors.red,
               textColor: Colors.white);
  }
Widget ShimmerLayout(){
  
  return Shimmer.fromColors( 
  direction: ShimmerDirection.ttb,
  baseColor: Colors.white, 
  highlightColor: Colors.grey[300],
  child:Container(
    margin: EdgeInsets.only(left:30,right:30,top:30),
    width:screen.width/10,
    height:screen.height/2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
      color: Colors.grey,
    ),
  ),
  );
}

return RefreshIndicator(
onRefresh:((){ 
    return Future.delayed( 
                  
      Duration(seconds: 1), 
      () { 
        setState(() { 
              newList();

        }); 
                  
                });
 }),  
  child:   Container(
    child: Events.length!=0||listIsLoading?
    ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(4.0),
      itemCount: listIsLoading?3:Events.length,
      itemBuilder: (BuildContext context, int index) {
        if(!listIsLoading){
           table_users.forEach((ele){
     if(ele['enrollmentNo']==Events[index]['enrollmentNo'])
     {
         image=ele['image'];
         name=ele['Name'];
        //  batch=ele['batch'];
     }


    });
        }
        return listIsLoading?ShimmerLayout():Padding(
          padding: const EdgeInsets.symmetric(vertical:4.0),
          child: Card(
            shape: RoundedRectangleBorder(
              // side: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:5.0),
              child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,

                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage:image.toString()=="null"?AssetImage('images/noface.png'):MemoryImage(base64Decode(image)),
              ),
              title: Text(name,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              // subtitle: Text(
              //    "Alumni of " + (int.parse(batch)-4).toString() +"-" +batch +" batch" ,
              //   style: TextStyle(fontSize: 10.0, color: Colors.grey),
              // ),
            ),
                  
                  
                  Events[index]['image']!=null?ClipRRect (
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.memory(base64Decode(Events[index]['image']),fit: BoxFit.cover,height: 100,),
                    // child:
                    //   Image.asset("images/cisco1.png",
                    //  fit: BoxFit.fill,
                    //    width: screen.width,
                    // ),
                    
                  )
                  :SizedBox(
                   height: 10,
                  ),

                  SizedBox(
                    height: 5.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:10,left: 20,right:20),
                    child: Text(
                      Events[index]['title'],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                           fontWeight: FontWeight.w500
                        ),
                    ),
                  ),

                  SizedBox(
                    height: 15.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12.0),
                    child: Row(
                      children: <Widget>[


                         Icon(Icons.calendar_today_rounded,
                           color: Colors.black,
                           
                         ),
                       // Text(Icons.icecream)

                        SizedBox(
                          width: 20,
                        ),

                        Text(
                          Events[index]['date'],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(
                          width: screen.width/6,
                        ),

                        Icon(Icons.location_on_outlined,
                        color: Colors.black,),

                        SizedBox(
                          width: 15,
                        ),


                        Text(
                          Events[index]['location'],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),




                      ],
                    ),
                  ),


                  SizedBox(
                    height: 20.0,
                  ),

                   Padding(
                     padding: const EdgeInsets.only(left:20,right:20),
                     child: Center(
                       child: Text(
                         Events[index]['description'],
                         style: TextStyle(
                           fontSize: 14,
                         ),
                       ),
                     ),
                   ),

                  SizedBox(
                    height: 15.0,
                  ),

                 
                  SizedBox(
                    height: 10.0,
                  ),
                    //******************************************verify*********************************** */
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
             color:Events[index]["verify"]=="1"?Colors.greenAccent[400]:Colors.blue,
           ),
           child:FlatButton(
             onPressed: (()async{
                 var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
              Events[index]["verify"]!="1"?verified(Events[index]["enrollmentNo"],Events[index]["description"],index):Fluttertoast.showToast(msg:"Already Verified",
               backgroundColor: Colors.green,
               textColor: Colors.white);                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }

             }),
             child: Text(Events[index]["verify"]=="1"?"Verified":"Verify",
             style:TextStyle(fontWeight:FontWeight.bold,color:Colors.white),),
             )
         ) ,
         ),
         //*********************remove**************************** */
              SizedBox(width:110,),
              
               Padding(
         padding: EdgeInsets.all(10),
         child:Container(
           width:MediaQuery.of(context).size.width/4,
           height:35,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(50),
             boxShadow: [BoxShadow(color:Colors.black26,blurRadius:10,spreadRadius:0,offset:Offset(0,10))],
             color:Colors.red,
           ),
           child:FlatButton(
             onPressed: (()async{
                 var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
               delete_reunion_from_database(Events[index]['enrollmentNo'] ,Events[index]['description'],index);
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }
             }),
                       child:Icon(Icons.delete_rounded,color:Colors.white)

            //  child: Text("Remove",
            //  style:TextStyle(fontWeight:FontWeight.bold,color:Colors.white),),
             )
         ) ,
         ),
       ],
            ),
             
             
                ],
              ),
            ),
          ),
        );
      },
    ):
 SingleChildScrollView(
physics:AlwaysScrollableScrollPhysics(),
child:Padding(padding:EdgeInsets.only(top:50),child:Column(
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
  
  ),
);
}

















////////////////////////////////



RefreshIndicator tab5(var Events,Size screen,var listIsLoading) {
  var image;
var name;
// var batch;

verified(var enrollmentNo,var description,var index) async
  {
  var url ="https://alumniportal2001.000webhostapp.com/Verify.php";
  var response = await http.post(url,body:{
    "EnrollmentNo":enrollmentNo,
    "Function":"Events",
    "EventId":"2",
    "Details":description,
    "Verified":"1",
  });
  if(response.statusCode==200)
  {        setState(() {
                 webinars[index]["verify"]="1";
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

  delete_webinar_from_database(var enrollmentNo ,var description,index)async{
 var url ="https://alumniportal2001.000webhostapp.com/Verify.php";
  var response = await http.post(url,body:{
    "EnrollmentNo":enrollmentNo,
    "Function":"Events",
    "Details":description,
    "EventId":"2",
    "Verified":"0",
  });

  print(jsonDecode(response.body));
  if(response.statusCode==200&&jsonDecode(response.body).toString()=="true")
  {
    setState(() {
        webinars.removeAt(index);
    });
    Fluttertoast.showToast(msg:"deleted",
               backgroundColor: Colors.green,
               textColor: Colors.white);
  }
  else
  Fluttertoast.showToast(msg:"Error occured",
               backgroundColor: Colors.red,
               textColor: Colors.white);
  }
  launchUrl(var url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
     Fluttertoast.showToast(
                                msg: "inavalid Url",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
  }
}

Widget ShimmerLayout(){
  
  return Shimmer.fromColors( 
  direction: ShimmerDirection.ttb,
  baseColor: Colors.white, 
  highlightColor: Colors.grey[300],
  child:Container(
    margin: EdgeInsets.only(left:30,right:30,top:30),
    width:screen.width/10,
    height:screen.height/2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
      color: Colors.grey,
    ),
  ),
  );
}
  return RefreshIndicator(
onRefresh:((){ 
    return Future.delayed( 
                  
      Duration(seconds: 1), 
      () { 
        setState(() { 
              newList();

        }); 
                  
                });
 }),    child: Container(

      child:Events.length!=0||listIsLoading?
      ListView.builder(
       physics: BouncingScrollPhysics(),

        padding: EdgeInsets.all(4.0),
        itemCount: listIsLoading?3:Events.length,
        itemBuilder: (BuildContext context, int index) {
             if(!listIsLoading){
                table_users.forEach((ele){
     if(ele['enrollmentNo']==Events[index]['enrollmentNo'])
     {
         image=ele['image'];
         name=ele['Name'];
        //  batch=ele['batch'];
     }


    });
             }
          return listIsLoading?ShimmerLayout():Padding(
            padding: const EdgeInsets.symmetric(vertical:4.0),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                 ListTile(
                   
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage:image.toString()=="null"?AssetImage('images/noface.png'):MemoryImage(base64Decode(image)),
              ),
              title: Text(name,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              // subtitle: Text(
              //    "Alumni of " + (int.parse(batch)-4).toString() +"-" +batch +" batch" ,
              //   style: TextStyle(fontSize: 10.0, color: Colors.grey),
              // ),
            ),
                  
                  
                  Events[index]['image']!=null?ClipRRect (
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.memory(base64Decode(Events[index]['image']),fit: BoxFit.cover,height: 100,),
                    // child:
                    //   Image.asset("images/cisco1.png",
                    //  fit: BoxFit.fill,
                    //    width: screen.width,
                    // ),
                    
                  )
                  :SizedBox(
                   height: 10,
                  ),


                  SizedBox(
                    height: 5.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:10,left: 20,right:20),
                    child: Text(
                      Events[index]['title'],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                           fontWeight: FontWeight.w500
                        ),
                    ),
                  ),

                  SizedBox(
                    height: 15.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left:20,right: 20),
                    child: Row(
                      children: <Widget>[


                         Icon(Icons.calendar_today_rounded,
                           color: Colors.black,
                           
                         ),
                       // Text(Icons.icecream)

                        SizedBox(
                          width: 20,
                        ),

                        Text(
                          Events[index]['date'],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(
                          width: screen.width/10,
                        ),

                        Icon(Icons.location_on_outlined,
                        color: Colors.black,),

                        SizedBox(
                          width:0,
                        ),

                        
                      Container(
                        width:80,
                       child:Text(
                          
                          Events[index]['location'],
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),


                      ],
                    ),
                  ),


                  SizedBox(
                    height: 20.0,
                  ),

                   Padding(
                     padding: const EdgeInsets.only(left:20,right:20),
                     child: Center(
                       child: Text(
                         Events[index]['description'],
                         style: TextStyle(
                           fontSize: 14,
                         ),
                       ),
                     ),
                   ),

                  SizedBox(
                    height: 15.0,
                  ),

                  Center(
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [BoxShadow(color:Colors.black26,blurRadius:20,offset: Offset(0,5))],
          
                        color:Colors.blue,
                      ),
                        child: FlatButton(
                          onPressed: () {
                            launchUrl(Events[index]['webinarLink']);
                            // Fluttertoast.showToast(
                            //     msg: "You will be redirected to the registration page",
                            //     toastLength: Toast.LENGTH_SHORT,
                            //     gravity: ToastGravity.CENTER,
                            //     timeInSecForIosWeb: 1,
                            //     backgroundColor: Colors.red,
                            //     textColor: Colors.white,
                            //     fontSize: 16.0
                            // );
                          },
                          child: Text('Join Webinar',
                            style: TextStyle(color:Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                     //******************************************verify*********************************** */
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
             color:Events[index]["verify"]=="1"?Colors.greenAccent[400]:Colors.blue,
           ),
           child:FlatButton(
             onPressed: (()async{
              var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
              Events[index]["verify"]!="1"?verified(Events[index]["enrollmentNo"],Events[index]["description"],index):Fluttertoast.showToast(msg:"Already Verified",
               backgroundColor: Colors.green,
               textColor: Colors.white);                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }

             }),
             child: Text(Events[index]["verify"]=="1"?"Verified":"Verify",
             style:TextStyle(fontWeight:FontWeight.bold,color:Colors.white),),
             )
         ) ,
         ),
    SizedBox(width: 110,),
    
      Padding(
         padding: EdgeInsets.all(10),
         child:Container(
           width:MediaQuery.of(context).size.width/4,
           height:35,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(50),
             boxShadow: [BoxShadow(color:Colors.black12,blurRadius:10,spreadRadius:0,offset:Offset(0,10))],
             color:Colors.red,
           ),
           child:FlatButton(
             onPressed: (()async{
                 var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
               delete_webinar_from_database(Events[index]['enrollmentNo'] ,Events[index]['description'],index);
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }
             }),
            child:Icon(Icons.delete_rounded,color:Colors.white)
            //  child: Text("Remove",
            //  style:TextStyle(fontWeight:FontWeight.bold,color:Colors.white),),
             )
         ) ,
         ),
       ],
            ),
                  
                  
                  
                  
                  
                  ],
                ),
              ),
            ),
          );
        },
      ):
    SingleChildScrollView(
physics:AlwaysScrollableScrollPhysics(),
child:Padding(padding:EdgeInsets.only(top:50),child:Column(
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
    ),
  );
}



//////////////////////////////////////////////



RefreshIndicator tab6(var Events,Size screen) {
 return RefreshIndicator(  onRefresh:((){ 
    return Future.delayed( 
                  
      Duration(seconds: 1), 
      () { 
        setState(() { 
              newList();

        }); 
                  
                });
 }),
child:Center(child:Text("Coming Soon")));
  // retchild(urn RefreshIndicator(
  //   onRefresh: _AdminPanelState().refreshList,
  //   child: Container(

  //     child: ListView.builder(
  //       physics: BouncingScrollPhysics(),

  //       padding: EdgeInsets.all(4.0),
  //       itemCount: Events.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(vertical:4.0),
  //           child: Card(
  //             elevation: 20,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30),
  //             ),
  //             color: Colors.white,
  //             child: Padding(
  //               padding: EdgeInsets.symmetric(horizontal:5.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[


  //                     ListTile(
  //             leading: CircleAvatar(
  //               radius: 30.0,
  //               backgroundImage: AssetImage('images/face23.jpg'),
  //             ),
  //             title: Text('Harshvardhan singh',
  //                 style: TextStyle(
  //                   fontSize: 15.0,
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.bold,
  //                 )),
  //             subtitle: Text(
  //               "Alumni of  2010-2012 batch",
  //               style: TextStyle(fontSize: 10.0, color: Colors.grey),
  //             ),
  //           ),
  //                   ClipRRect (
  //                   borderRadius: BorderRadius.circular(30.0),
  //                   // child: Image.network("http://192.168.43.201/itm_auth/${Events[index].image}",
  //                   child:
  //                     Image.asset("images/cisco1.png",
  //                    fit: BoxFit.fill,
  //                      width: screen.width,
  //                   ),
                    
  //                 ),



  //                   SizedBox(
  //                     height: 5.0,
  //                   ),

  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal:10.0),
  //                     child: Text(
  //                       Events[index].title,
  //                       style: TextStyle(
  //                           fontSize: 20,
  //                           color: Colors.lightBlue,
  //                         fontWeight: FontWeight.w500
  //                       ),
  //                     ),
  //                   ),

  //                   SizedBox(
  //                     height: 15.0,
  //                   ),

  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal:0.0),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal:20.0),
  //                       child: Row(
  //                         children: <Widget>[
  //                           Text("Rs  " +Events[index].budget,
  //                             style: TextStyle(
  //                               color: Colors.black,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),

  //                           SizedBox(
  //                             width: 40,
  //                           ),

  //                           Text(
  //                             Events[index].donors,
  //                             style: TextStyle(
  //                               color: Colors.black,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),


  //                           SizedBox(
  //                             width: 70,
  //                           ),

  //                           Text("Rs  "+
  //                             Events[index].funded,
  //                             style: TextStyle(
  //                               color: Colors.black,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),

  //                         ],
  //                       ),
  //                     ),
  //                   ),

  //                   SizedBox(
  //                     height: 5,
  //                   ),

  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal:0.0),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal:20.0),
  //                       child: Row(
  //                         children: <Widget>[
  //                           Text(
  //                            "Budget",
  //                             style: TextStyle(
  //                               fontSize: 16,
  //                             ),
  //                           ),

  //                           SizedBox(
  //                             width: 40,
  //                           ),

  //                           Text(
  //                             "Donors",
  //                             style: TextStyle(
  //                               fontSize: 16,
  //                             ),
  //                           ),


  //                           SizedBox(
  //                             width: 40,
  //                           ),

  //                           Text(
  //                             "Funded",
  //                             style: TextStyle(
  //                               fontSize: 16,
  //                             ),
  //                           ),

  //                         ],
  //                       ),
  //                     ),
  //                   ),

  //                   SizedBox(
  //                     height: 15,
  //                   ),

  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal:10.0),
  //                     child: Center(
  //                       child: Text(
  //                         Events[index].description,
  //                         style: TextStyle(
  //                           fontSize: 14,
  //                         ),
  //                       ),
  //                     ),
  //                   ),




  //                   SizedBox(
  //                     height: 15.0,
  //                   ),

  //                   Center(
  //                     child: Container(
  //                       height: 40,
  //                       width: 150,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(32),
  //                         color:Colors.lightGreen,
  //                       ),
  //                       child: FlatButton(
  //                         onPressed: () {
  //                           Fluttertoast.showToast(
  //                               msg: "Feature comming soon",
  //                               toastLength: Toast.LENGTH_SHORT,
  //                               gravity: ToastGravity.CENTER,
  //                               timeInSecForIosWeb: 1,
  //                               backgroundColor: Colors.red,
  //                               textColor: Colors.white,
  //                               fontSize: 16.0
  //                           );
  //                         },
  //                         child: Text('Contribute ',
  //                           style: TextStyle(color:Colors.white),
  //                         ),
  //                       ),


  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10.0,
  //                   ),

  //                   Center(child: Text("or pledge to donate later",
  //                   style:TextStyle(fontSize: 13),



  //                   )),

  //                   SizedBox(
  //                     height: 10.0,
  //                   ),

  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   ),
  // );
}


}// end of class
















































// import 'dart:convert';

// import 'package:flutter/material.dart';
// import '../Widgets/Dashboard/drawer.dart';



// import 'package:http/http.dart' as http;
// import 'package:shimmer/shimmer.dart';


// class EventsHome extends StatefulWidget {
//   var name;
//   EventsHome(var name)
//   {
//     this.name=name;
//   }
//   @override
//   _EventsHome createState() => _EventsHome();
// }

// class _EventsHome extends State<EventsHome> {
// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//        home:DefaultTabController(
//          length:3,
//        child:Scaffold(
//          appBar: AppBar(
//           backgroundColor: Colors.blue,
//            bottom: TabBar(
//              isScrollable: true,
//              tabs: <Widget>[
//                Tab(
//                 text:"Reunions",
//                  ),
//                Tab(
//                 text:"Events",
//                  ),
//                Tab(
//                 text:"Funding",
//                  ),
             
//              ],
//            ),
//          ),
//          floatingActionButton:Stack(
//         children:<Widget>[
//       Align(
//         alignment: Alignment(-0.8,-0.85),
//       child: FloatingActionButton(
//       elevation:30,
//       backgroundColor: Colors.cyan,
//       onPressed: (){
//         _scaffoldKey.currentState.openDrawer();

//       },
//       child:Center(
//         child:Column(
//         children: [
//          Padding(
//            padding: EdgeInsets.only(top:15),
//          child: Container(
//             height: 5,
//             width: 25,
//             decoration:BoxDecoration(
//               color:Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             )
//           )
//          ),
        
//         Padding(
//            padding: EdgeInsets.only(top:5),
//          child: Container(
//             height: 5,
//             width: 25,
//             decoration:BoxDecoration(
//               color:Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             )
//           )
//          ),
        
//          Padding(
//            padding: EdgeInsets.only(top:5),
//          child: Container(
//             height: 5,
//             width: 25,
//             decoration:BoxDecoration(
//               color:Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             )
//           )
//          ),
        
//         ],
//       )
//     ),
//     ),
//       ),
        
//         //*************Upload****************** */
//         Align(
//           alignment: Alignment.bottomRight,
//           child:FloatingActionButton(
//            child: Icon(Icons.drive_folder_upload,color: Colors.white,),
//             backgroundColor: Colors.blue,
            
            

//           ))
//         ],
//       ),
//              key: _scaffoldKey,
//          drawer: SafeArea(
    
//       child:ClipRRect(
//       borderRadius: BorderRadius.only(
//           topRight: Radius.circular(50), bottomRight: Radius.circular(35)),
//       child: Drawer1(widget.name),),),

//          body:Center(child: Text("Events"),)
//        )
//        ),
//     );
//   }
// }
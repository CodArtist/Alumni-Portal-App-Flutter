import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';



// import 'package:flutter_app/images.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:async';
import '../Widgets/Events/User.dart';
import '../Widgets/Events/Services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Widgets/Dashboard/drawer.dart';
import '../Widgets/Events/ReunionUpload.dart';
import '../Widgets/Events/WebinarUpload.dart';
import '../Widgets/Events/FundingUpload.dart';

class EventHomePage extends StatefulWidget {
  var name;
  EventHomePage(this.name);
  @override
  _EventHomePageState createState() => _EventHomePageState();
}




class _EventHomePageState extends State<EventHomePage> with SingleTickerProviderStateMixin {

  List<User> Events = List();
  List<User> Events_Reunion = List();
  List<User> Events_Webinar = List();
  List<User> Events_Funding = List();
  String state1="1";
  String state2="2";
  String state3="3";
  var currentState=0;
    var listIsLoading=true;

  GlobalKey<RefreshIndicatorState> refreshKey;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
TabController _controller;



  @override
  void initState() {
    super.initState();
     _controller=new TabController(length:3,vsync: this);
      _controller.addListener(() {
        // print(_controller.index.toString());
        setState(() {
          currentState=_controller.index;
        });
      });

    Services.getUsers().then((usersFromServer) {
      setState(() {
        refreshKey=GlobalKey<RefreshIndicatorState>();
        print("sfsafasfasfsdavsdvdsb");
        print(usersFromServer);
        Events = usersFromServer;

        Events_Reunion = Events
            .where((u) => (u.EventId
            .toLowerCase()
            .contains(state1.toLowerCase()) ||
            u.EventId.toLowerCase().contains(state1.toLowerCase())))
            .toList();

        Events_Webinar = Events
            .where((u) => (u.EventId
            .toLowerCase()
            .contains(state2.toLowerCase()) ||
            u.EventId.toLowerCase().contains(state2.toLowerCase())))
            .toList();

        Events_Funding = Events
            .where((u) => (u.EventId
            .toLowerCase()
            .contains(state3.toLowerCase()) ||
            u.EventId.toLowerCase().contains(state3.toLowerCase())))
            .toList();

       
          listIsLoading=false;
       


      });
    });
  }
  newList(){
    Services.getUsers().then((usersFromServer) {
print(usersFromServer.toList());
      setState(() {
        Events = usersFromServer;

        Events_Reunion = Events
            .where((u) => (u.EventId
            .toLowerCase()
            .contains(state1.toLowerCase()) ||
            u.EventId.toLowerCase().contains(state1.toLowerCase())))
            .toList();
        // print(Events_Reunion[0].image);

        Events_Webinar = Events
            .where((u) => (u.EventId
            .toLowerCase()
            .contains(state2.toLowerCase()) ||
            u.EventId.toLowerCase().contains(state2.toLowerCase())))
            .toList();
        print(Events_Webinar[0].image);

        Events_Funding = Events
            .where((u) => (u.EventId
            .toLowerCase()
            .contains(state3.toLowerCase()) ||
            u.EventId.toLowerCase().contains(state3.toLowerCase())))
            .toList();
      listIsLoading=false;
      
      });


    });
  }

  Future<Null> refreshList() async{
    await Future.delayed(Duration(seconds: 1));
        }

  @override
  Widget build(BuildContext context) {
    Size screen=MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(

              floatingActionButton:Stack(
        children:<Widget>[
      Align(
        alignment: Alignment(-0.8,-0.85),
      child: FloatingActionButton(
      elevation:30,
      // backgroundColor: Color(0xff127B82),
      backgroundColor: Color(0XFFA50909),
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
            onPressed: (){
             Navigator.of(context).push(
   PageRouteBuilder(
    pageBuilder: (
        BuildContext context, 
        Animation<double> animation, 
        Animation<double> secondaryAnimation) {
          if(currentState==0)
      return ReunionUpload(widget.name);
                if(currentState==1)
      return WebinarUpload(widget.name);
                if(currentState==2)
      return ReunionUpload(widget.name);
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
            },

          ))
        ],
      ),
      
    // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    key: _scaffoldKey,
    drawer: SafeArea(
    
      child:ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(50)),
      child: Drawer1(widget.name,"Events"),),),

        appBar: AppBar(
          
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: ()=>newList())
          ],
          // backgroundColor: Color(0xff28D9CE),
          backgroundColor: Colors.red,
          // title: Text("Events"),
          bottom: TabBar(
            controller: _controller,

            indicatorColor: Colors.white,
            labelColor: Colors.white,

            tabs: <Widget>[
              Tab(
                child:Text("Reunion",style: TextStyle(fontSize: 18),),
              ),
              Tab(
                child:Text("Webinars",style: TextStyle(fontSize: 18),),
              ),
              Tab(
                child:Text("Funding",style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
        ),
        body:Container(
          color: Colors.grey[10],
          child: TabBarView(
            controller: _controller,

            children: <Widget>[
              tab1(Events_Reunion, Events_Reunion,screen,listIsLoading),
              tab2(Events_Webinar,screen,listIsLoading),
              tab3(Events_Funding,screen),

            ],
          ),
        ),
          // floatingActionButton: new FloatingActionButton(
          //     elevation: 0.0,
          //     child: new Icon(Icons.add),
          //    backgroundColor: Colors.lightGreen,
          //    //backgroundColor: new Color(0xFFE57373),
          //     onPressed: () {
          //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
          //     }
          // )
      ),
    );
  }
}

RefreshIndicator tab1(List<User> Events,List<User>  Events_Reunion,Size screen,var listIsLoading) {
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
  var name;
  var batch;
  var image;
return RefreshIndicator(
  onRefresh: _EventHomePageState().refreshList,

  child:   Container(
    child: Events.length!=0||listIsLoading?ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(4.0),
      itemCount: listIsLoading?3:Events.length,
      itemBuilder: (BuildContext context, int index) {
       if(!listIsLoading)
        {Services.userList.forEach((user){
        if(user['enrollmentNo']==Events[index].user)
        {
          name=user['Name'];
          image=user['image'];
          // batch=user['batch'];
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
                backgroundImage: image.toString()=="null"||image.toString()=="NULL"?AssetImage('images/noface.png'):MemoryImage(base64Decode(image)),
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
                  
                  
                  Events[index].image!=null?ClipRRect (
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.memory(base64Decode(Events[index].image),fit: BoxFit.cover,height: 100,),
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
                      Events[index].title,
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
                          Events[index].date,
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
                          Events[index].location,
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
                         Events[index].description,
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
                        onPressed: ()
                        {
                          Fluttertoast.showToast(
                              msg: "You have succesfully joined the event",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        },
                        child: Text('Join Event',
                          style: TextStyle(color:Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
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
child:Padding(padding:EdgeInsets.only(top:100),child:Column(
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



RefreshIndicator tab2(List<User> Events,Size screen,var listIsLoading) {
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
var name;
// var batch;
var image;
  return RefreshIndicator(
    onRefresh: _EventHomePageState().refreshList,
    child: Container(

      child:Events.length!=0||listIsLoading? ListView.builder(
       physics: BouncingScrollPhysics(),

        padding: EdgeInsets.all(4.0),
        itemCount: listIsLoading?3:Events.length,
        itemBuilder: (BuildContext context, int index) {
         if(!listIsLoading)
        { Services.userList.forEach((user){
        if(user['enrollmentNo']==Events[index].user)
        {
          name=user['Name'];
          image=user['image'];
          // batch=user['batch'];
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
                backgroundImage: image.toString()=="null"?AssetImage('images/noface.png'):MemoryImage(base64Decode(image)),
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
                  
                  
                  Events[index].image!=null?ClipRRect (
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.memory(base64Decode(Events[index].image),fit: BoxFit.cover,height: 100,),
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
                      Events[index].title,
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
                          Events[index].date,
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
                          
                          Events[index].location,
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
                         Events[index].description,
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
                            launchUrl(Events[index].webinarLink);
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

                  ],
                ),
              ),
            ),
          );
        },
      ):
    SingleChildScrollView(
physics:AlwaysScrollableScrollPhysics(),
child:Padding(padding:EdgeInsets.only(top:100),child:Column(
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



RefreshIndicator tab3(List<User> Events,Size screen) {
 return RefreshIndicator(   onRefresh: _EventHomePageState().refreshList,
child:Center(child:Text("Coming Soon")));
  // retchild(urn RefreshIndicator(
  //   onRefresh: _EventHomePageState().refreshList,
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
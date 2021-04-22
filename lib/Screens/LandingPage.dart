
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../Widgets/LandingPage/Internships.dart';
import '../Widgets/LandingPage/News.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'Login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';







class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>with SingleTickerProviderStateMixin  {
  var currentindex=0;
  // var tabs=<Widget>[
  //                   Internships("sd"),
  //                   tab3(newsList, userList,screen)
  //                 ];
  var newsList=[];
  var userList=[];
  var internshipList=[];
  var userList_internship=[];
  var listIsLoading_internships=true;
   var listIsLoading_news=true;
    var listIsLoading_webinars=true;

      @override
  void initState() {
    super.initState();
        _controller=new TabController(length:3,vsync: this);
      _controller.addListener(() {
        print("dadsd");
        setState(() {
          currentindex=_controller.index;
        });
        print(currentindex);
      });
 
      loadInternships();
      loadNews();
      loadWebinar();
  }
  
  loadInternships()async{
   print("hhjgbjhgbkhvvnvjhvh");
    setState(() {
      listIsLoading_internships=true;         

    });
    print("kghghjvhjvghchgchcbcjcgchc");
    print(currentindex.toString());
String url="https://alumniportal2001.000webhostapp.com/GetInternships.php";
final response=await http.get(url);
// if(jsonDecode(response.body)!="Not Found")
if((response.body).toString()!="Not Found")
{setState(() {
    internshipList=jsonDecode(response.body)[0];
  userList_internship=jsonDecode(response.body)[1];
  listIsLoading_internships=false;
});
print("loadinternship finish");
print(internshipList);
}
  }

  loadNews()async{
    print("sml;nlkbnlkbnmkn");
    setState(() {
      listIsLoading_news=true;
    });
String url="https://alumniportal2001.000webhostapp.com/GetNews.php";
final response=await http.get(url);
if(jsonDecode(response.body)!="Not Found")
{setState(() {
  newsList=jsonDecode(response.body)[0];
  userList=jsonDecode(response.body)[1];

  listIsLoading_news=false;

});
}
setState(() {
  listIsLoading_news=false;
});
print(response.body);
print(newsList);
print(userList);
}

var webinarList=[];
 loadWebinar()async{
   setState(() {
     listIsLoading_webinars=true;
   });
    print("sjdsjknd");
String url="https://alumniportal2001.000webhostapp.com/GetWebinars.php";
final response=await http.get(url);
if(jsonDecode(response.body)!="Not Found")
{setState(() {
  webinarList=jsonDecode(response.body);
  listIsLoading_webinars=false;
});
}
setState(() {
  listIsLoading_webinars=false;
});
print(response.body);
print(webinarList);

}


    PageController  _pageController=new  PageController(initialPage: 0);
    TabController _controller;
@override
  Widget build(BuildContext context) {
print(internshipList);
print(listIsLoading_internships);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
var screen=MediaQuery.of(context).size;
  return DefaultTabController(
      length: 3,
      child: SafeArea(
      child:Scaffold(
    
      appBar: AppBar(
        leading:FlatButton(onPressed:(){loadNews();},child:Icon(currentindex==0?Icons.work:currentindex==1?Icons.pages:Icons.pages_outlined,color: Colors.black,)),
        actions:[
        //  Container(
        //       width: 100,
        //       height: 30,
              
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(50),
        //         boxShadow: [BoxShadow(color:Colors.black26,blurRadius:10,spreadRadius:0,offset:Offset(0,10))],
        //      color: Colors.white
        //       ),
              FlatButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
                },
                child: Text("Login"),
              ),
            ],
        title: 
            Text(currentindex==0?"Internships":currentindex==1?"News":currentindex==2?"Webinars":"",style: TextStyle(color: Colors.black),),
          
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        
      //   shape:RoundedRectangleBorder(
      // borderRadius: BorderRadius.vertical(
      //   bottom: Radius.circular(30),
      // ),
        
      // ),
      ),
      body:PageView(
        
        controller:_pageController,
                  children:<Widget>[
                    Internships(internshipList,userList_internship,listIsLoading_internships),
                    tab3(newsList, userList,screen),
                    tab4(webinarList,screen)
                  ],

          onPageChanged: (index) {
            setState((){
              currentindex = index;
                            // _pageController.jumpToPage(0);

            });
          },
      
      ),
     
      backgroundColor: Colors.white,
      bottomNavigationBar:CurvedNavigationBar(
        index: currentindex,
        items: [
          Column(
            children:<Widget>[
              SizedBox(height: 20,),
              Icon(Icons.work,color:currentindex==0?Colors.black:Colors.white,),
           SizedBox(height:5,),
           Text("internships",style: TextStyle(color:currentindex==0?Colors.black:Colors.white,fontSize: 10 ),),
            ]
          ),
 Column(
            children:<Widget>[
              SizedBox(height: 20,),
              Icon(Icons.pages,color:currentindex==1?Colors.black:Colors.white,),
           SizedBox(height:5,),
           Text("News",style: TextStyle(color:currentindex==1?Colors.black:Colors.white,fontSize: 10 ),),
            ]
          ),         
 Column(
            children:<Widget>[
              SizedBox(height: 20,),
              Icon(Icons.video_call,color:currentindex==2?Colors.black:Colors.white,),
           SizedBox(height:5,),
           Text("Webinar",style: TextStyle(color:currentindex==2?Colors.black:Colors.white,fontSize: 10 ),),
            ]
          ),         
        ],
        onTap: (index)async{
          if(index==0)
          { var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                  loadInternships();
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                     
                      );
                       }
           
          }
          if(index==1)
         {
            var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                  loadNews();
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                     
                      );
                       }
         
         }
            if(index==2)
          {var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                  loadWebinar();
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                     
                      );
                       }
            
          }
           setState(() {
             currentindex=index;
            _pageController.animateToPage(currentindex,duration:Duration(milliseconds: 500) ,curve: Curves.linear);

           });
        },
        animationDuration: Duration(milliseconds: 500),
        height: MediaQuery.of(context).size.height/10,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.grey[50],
        color:Colors.red,
      ) ,
    ),
    ),
    
  );
  }

Widget tab4(var Events,Size screen) {
  
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
onRefresh:((){ 
    return Future.delayed( 
                  
      Duration(seconds: 1), 
      () { 
        setState(() { 
              loadWebinar();

        }); 
                  
                });
 }),    child: Container(

      child:Events.length!=0||listIsLoading_webinars?
      ListView.builder(
       physics: BouncingScrollPhysics(),

        padding: EdgeInsets.all(4.0),
        itemCount: listIsLoading_webinars?3:Events.length,
        itemBuilder: (BuildContext context, int index) {
             if(!listIsLoading_webinars){
             name=Events[index]["Name"];
             image=Events[index]["image"];
                          }
          return listIsLoading_webinars?ShimmerLayout():Padding(
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

Widget tab3(var news,var users,Size screen) {
  
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

 return Padding(
  padding:EdgeInsets.only(top:30),
child:ListView.builder(
  physics: BouncingScrollPhysics(),
itemCount: listIsLoading_news?3:news.length,
itemBuilder: (BuildContext context,index){
 
  return listIsLoading_news?ShimmerLayout():NewsCard(news[index],users);
},
),
 
);
}

// Widget tab1(var alumni,Size screen,) {


//   Widget ShimmerLayout(){
  
//   return Shimmer.fromColors( 
//   direction: ShimmerDirection.ttb,
//   baseColor: Colors.white, 
//   highlightColor: Colors.grey[300],
//   child:Container(
//     margin: EdgeInsets.only(left:30,right:30,top:30),
//     width:screen.width/10,
//     height:screen.height/2,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
//       color: Colors.grey,
//     ),
//   ),
//   );
// }
//  return Padding(
//   padding:EdgeInsets.only(top:30),
//   child:ListView.builder(
//   physics: BouncingScrollPhysics(),
// itemCount: listIsLoading?3:alumni.length,
// itemBuilder: (BuildContext context,index){
 
//   return listIsLoading?ShimmerLayout():InternshipCard(alumni[index],userdetail);
// },
// ),

// );
// }

  }
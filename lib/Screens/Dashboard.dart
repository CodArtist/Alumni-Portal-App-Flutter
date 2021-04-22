import '../Widgets/Dashboard/card1.dart';
import '../Widgets/Dashboard/ExperienceCard.dart';
import '../Widgets/Dashboard/EducationCard.dart';
import '../Widgets/Dashboard/ContactCard.dart';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Widgets/Dashboard/drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../User.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';




class Dashboard extends StatefulWidget {
  var name;
  Dashboard(var name)
  {
    this.name=name;
  }
  
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
var recentExperience;
// void _openDrawer() {
//   _scaffoldKey.currentState.openDrawer();
// }

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

List<Experience> experience =[];
addExperience(){
 print(experience.length);
  setState(() {
     experience.add(new Experience());
  });
}

removeExperience(){
 print(experience.length);
  setState(() {
     experience.removeLast();
  });
}
recentExp(){
  //    setState(() {
  //    recentExperience="null";
  //  });
  setState(() {
    
  });
  print(User.experience);
       var year=[];
var occupation=[];
if(User.experience!=null&&User.experience!="null"&&User.experience!="")
   { print("lalalala");
     var exp=User.experience.split("\n");
    exp.removeLast();
    exp.forEach((element) {
      year.add(element.split(" ")[0]);
   var ele=element.split(" ");
   var str="";
   for(var i =1;i<ele.length;i++)
   {
str=str+ele[i]+" ";
   }

      occupation.add(str);
});
var intYear=[];
year.forEach((y){
intYear.add(int.parse(y.toString()));
});

intYear.sort();
for(var i = 0;i<year.length;i++)
{
  if(intYear[intYear.length-1]==int.parse(year[i].toString()))
  setState((){
    recentExperience=occupation[i].toString();
  });
}
   }
   else
   setState(() {
     recentExperience="null";
   });
}

  @override
  Widget build(BuildContext context) {
  var college;
  var batch;
  var course;
  setState(() {
    college=User.post_grad_college!=""&&User.post_grad_college!="null"?User.post_grad_college:User.grad_college;
  course=User.post_grad_course!=""&&User.post_grad_course!="null"?User.post_grad_course:User.grad_course;
  batch=User.post_grad_batch!=""&&User.post_grad_batch!="null"?User.post_grad_batch:User.grad_batch;
  });
  
  
    return MaterialApp(
      // theme:ThemeData(
      //   canvasColor: Colors.transparent,
      // ),
      debugShowCheckedModeBanner: false,
       home: Scaffold(
         
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          //child: Expanded(
          child:Container(
            child:RefreshIndicator(
              onRefresh: ((){
                       print(User.linkedIn.toString());
                       if(User.phone=="")
                       print("heloo");

                return Future.delayed( 
                  
      Duration(seconds: 1), 
      () { 
        setState(() { 
              recentExp();

        }); 
                  
                });
              }),
            child:SingleChildScrollView(
              physics: BouncingScrollPhysics(),
            child:Column(
              children: <Widget>[
              Card1(                        // Card1  in  Action
                child: Column(
                  children:<Widget>[
                  
                            CircleAvatar(
                  backgroundImage: User.image.toString()=="null"?AssetImage("images/noface.png"):MemoryImage(base64Decode(User.image)),
                  radius: 50,
                
                
                ),
                
       
          //      Container(
          // width:MediaQuery.of(context).size.width/5,
          // height: MediaQuery.of(context).size.height/8,
          // margin: EdgeInsets.only(top:0, bottom:0),
          // decoration: BoxDecoration(
          //   borderRadius:BorderRadius.circular(100),
          //   image:DecorationImage(image: User.image.toString()=="null"?AssetImage('images/noface.png'):MemoryImage(base64Decode(User.image)),
          //   fit: BoxFit.fill,
           
          //   ),
            
          // ),
          // ),
           SizedBox(height: 10,),
                    Text(widget.name,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),),
                    
                    SizedBox(height: 10,),
                     batch!=""&&batch!="null"&&batch!=null?
                      Text("Alumni of " + batch +" batch" ,

                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.normal
                      ) ,) :
                      SizedBox(),
                       batch!=""&&batch!="null"&&batch!=null?SizedBox(height:5):
                       SizedBox(),

                   SizedBox(height: 20,),


                      course!=""&&course!="null"&&course!=null?
                      Text(course,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold
                      ) ,) :
                      SizedBox(),
                        course!=""&&course!="null"&&course!=null?SizedBox(height:5):
                       SizedBox(),

                      recentExperience!=""&&recentExperience!="null"&&recentExperience!=null?
                        Text(recentExperience,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ) ,) :
                      SizedBox(),
                      recentExperience!=""&&recentExperience!="null"&&recentExperience!=null?SizedBox(height: 5):
                      SizedBox(),
                      
 

                      college!=""&&college!="null"&&college!=null?
                      Text(college,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ) ,) :
                      SizedBox(),
                      SizedBox(height:20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                         if(User.linkedIn!="null"&&User.linkedIn!="")
                         IconButton(icon:Image.asset("images/linkedin.png",scale:20),onPressed:(){launchUrl(User.linkedIn);}),
                        
                         if(User.facebook!="null"&&User.facebook!="")
                         IconButton(icon:Image.asset("images/facebook.png",scale:20),onPressed:(){launchUrl(User.facebook);}),

                          if(User.instagram!="null"&&User.instagram!="")
                         IconButton(icon:Image.asset("images/instagram.png",scale:20),onPressed:(){launchUrl(User.instagram);}),

                          if(User.twitter!="null"&&User.twitter!="")                     
                         IconButton(icon:Image.asset("images/twitter.png",scale:20),onPressed:(){launchUrl(User.twitter);}),

                      ],)

  
                    //   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                          
                    //       FlatButton(onPressed: null,
                    //       padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    //       disabledColor: Colors.cyan[400],
                    //       disabledTextColor: Colors.black,
                          
                            
                    //         child:Text("Connect",
                    //       style: TextStyle(
                    //       fontSize: 15,
                          
                    // ), ),),//),
                    // //SizedBox(width:45),
                    //  FlatButton(onPressed: null, 
                    //       padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    //       disabledColor: Colors.yellow[700],
                    //       disabledTextColor: Colors.black,
                    //       child: Text("Message",
                    //       style: TextStyle(
                    //       fontSize: 15,
                    //       //fontWeight: FontWeight.bold,
                    // ), ),)
                    //     ],
                    //   )
                      
                  ])
                
                  
                  ,),

                  // Card1(
                  //   child: Column(crossAxisAlignment: CrossAxisAlignment.end, 
                  //     children:[ TextFormField(
                        
                  //       keyboardType: TextInputType.emailAddress,
                  //       decoration: InputDecoration(
                  //         labelText : "What's in your mind today ?",
                  //         labelStyle : TextStyle(color: Colors.grey),
                  //         border: InputBorder.none
                  //       ),
                        
                  //     ),
                      
                  //     FlatButton(onPressed: null, 
                  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  //     disabledColor: Colors.yellow[700],
                  //     disabledTextColor: Colors.black,
                  //       child: Text("POST") ),
                  //     ],),),
                
                  
                  Card1(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("EXPERIENCE",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                        ),
                        ),
                        SizedBox( height: 35),
                          ExperienceCard(User.experience),
                        // SizedBox( height: 35),

             
               
                      ]
                    ),
                  ),
                  
                    Card1(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Educational Details",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                        ),
                        ),
                        SizedBox( height: 35),
                        EducationCard(User.grad_college,User.school_10),
                        /*SizedBox( height: 35),
                        ExperienceCard(),
                        SizedBox( height: 35),
                        ExperienceCard(),
                        SizedBox( height: 35),*/
                      ]
                    ),
                  ),
                  
                  Card1(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text("Contact Details",
                        
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                        ),
                        ),
                        SizedBox( height: 35),
                        ContactCard(User.phone,User.email,User.linkedIn),
                        /*SizedBox( height: 35),
                        ExperienceCard(),
                        SizedBox( height: 35),
                        ExperienceCard(),
                        SizedBox( height: 35),*/
                      ]
                    ),
                  ),
                  
                
                FlatButton(onPressed: null, 
                 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      disabledColor: Colors.red,
                      disabledTextColor: Colors.black,
                        child:Container(
                           margin: EdgeInsets.all(15),
                           padding: EdgeInsets.all(10),
                          child:Text("Recommend to Others !",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          )
                        ) ,),
                  
               
                  
            ],),//)
        ),
          ),
      
      ),
      
    ),
    // appBar: AppBar(
    //   backgroundColor: Colors.cyan,
    //   title: Text("Dashboard")
    // ),
    floatingActionButton: FloatingActionButton(
      elevation:30,
      backgroundColor: Colors.red[600],
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
        
    floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    key: _scaffoldKey,
    drawer: SafeArea(
    
      child:ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(50)),
      child: Drawer1(widget.name,"Dashboard"),),),
        
    
    ),);
  }
}
 


 class Experience extends StatelessWidget{
  TextEditingController occupationController =new TextEditingController();
  TextEditingController yearController =new TextEditingController();


  @override 
  Widget build(BuildContext context){
     return Padding(
       padding: EdgeInsets.only(bottom:20),
       child:Expanded(
       child: Row(
   children:<Widget> [
     Padding(
       padding:EdgeInsets.only(right:20),
       child:Container(
width: MediaQuery.of(context).size.width/6,
   child:TextField(
     controller: yearController,
     style: TextStyle(fontSize: 15),
     decoration:InputDecoration(
            filled:true,
            labelText: "Year",
          
            fillColor: Colors.grey[50],
            // hintText: "Title",
            contentPadding: const EdgeInsets.only(left:10,top:10,bottom:10),
            border: OutlineInputBorder(
               borderSide: const BorderSide(color: Colors.grey, width:3.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width:3.0),
              borderRadius: BorderRadius.circular(25.0),

            )     ) ,
     )
 ),
     ),
    Container(
      width: MediaQuery.of(context).size.width/2,
      child: TextField(controller: occupationController,
                 style: TextStyle(fontSize: 15),

                decoration:InputDecoration(
            filled:true,
            labelText: "Occupation",
          
            fillColor: Colors.grey[50],
            // hintText: "Title",
            contentPadding: const EdgeInsets.only(left:10,top:10,bottom:10),
            border: OutlineInputBorder(
               borderSide: const BorderSide(color: Colors.grey, width:3.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width:3.0),
              borderRadius: BorderRadius.circular(25.0),

            )     ) ,
                obscureText: false,),
    ),
 

   ],
       ),
       ),
  );
  }
}
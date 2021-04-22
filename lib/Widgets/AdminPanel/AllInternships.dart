import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';




class AllInternships extends StatefulWidget {
 
  var carddetail;
  var user;
  var name;
  // var batch;
  var image;
  Widget delete;
  var internship_time;
  AllInternships(carddetail,user,@required this.delete)
  {internship_time=carddetail['internship_time'].split(" ")[0];
    DateTime current= DateTime.now();
    // internship_time="2021-01-08";
    DateTime current_date = new DateTime(current.year, current.month,current.day);
    internship_time=DateTime.parse(internship_time).difference(current_date).inDays.toString();
    if(internship_time=="0")
    {
      internship_time="Today";
    }
    else
    {
      var diff=int.parse(internship_time)*-1;
      if(diff<30)
      {
        internship_time=(diff-(diff%7))/7==0? diff.toString()+(diff.toString()!="1"? " days ago":" day ago"): (((diff-(diff%7))/7).round()).toString() + ((((diff-(diff%7))/7).round()).toString()!="1"? " weeks ago":" week ago");
      }
            if(diff>=30)
      {
        internship_time= ((diff-(diff%30))/30).round()!=1?(((diff-(diff%30))/30).round()).toString() + " months ago":(((diff-(diff%30))/30).round()).toString() + " month ago";
      }
    }
    this.user=user;
  this.carddetail=carddetail;
    user.forEach((ele){
     if(ele['enrollmentNo']==carddetail['enrollmentNo'])
     {
         this.image=ele['image'];
         this.name=ele['Name'];
        //  this.batch=ele['batch'];
     }


    });
  }
 
  @override
  _AllInternships createState() => _AllInternships();
}

class _AllInternships extends State<AllInternships> {

internshipDetail(BuildContext context)
{
  showBottomSheet(
    context: context,
    builder:(BuildContext context) {
              return InternshipDetails(widget.carddetail);
    }
    );
}

verified(var enrollmentNo) async
  {
  var url ="https://alumniportal2001.000webhostapp.com/Verify.php";
  var response = await http.post(url,body:{
    "EnrollmentNo":enrollmentNo,
    "Function":"Internships",
    "Details":widget.carddetail["details"],
    "Verified":"1",
  });
  if(response.statusCode==200)
  {setState(() {
    widget.carddetail['Allowed']="1";
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


  return Container(
    margin: EdgeInsets.only(left:30,right:30,bottom:30),
    width:MediaQuery.of(context).size.width/10,
    // height:MediaQuery.of(context).size.height/2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
      color: Colors.white
    ),
    child:Column(
      children:<Widget> [
          ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage:widget.image.toString()=="null"?AssetImage('images/noface.png'):MemoryImage(base64Decode(widget.image)),
              ),
              title: Text(widget.name,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              // subtitle: Text(
              //    "Alumni of " + (int.parse(widget.batch)-4).toString() +"-" +widget.batch +" batch" ,
              //   style: TextStyle(fontSize: 10.0, color: Colors.grey),
              // ),
            ),
      

      //***************Title********************** */
      Row(
      children:<Widget>[
        Padding(padding: EdgeInsets.only(left:20,top:15,right: 20),
      child:Container(
        width:MediaQuery.of(context).size.width/1.4,
        child:Text(widget.carddetail['title'],
      style:TextStyle(fontWeight: FontWeight.bold,fontSize:15,color: Colors.black),overflow: TextOverflow.clip,)
      )
      ),
      ],
      ),
      //****************Titleend************************ */
      
      //***************Details********************** */
      Row(
      children:<Widget>[
        Padding(padding: EdgeInsets.only(left:20,top:20,right:20),
      child:Container(
       
        height:MediaQuery.of(context).size.height/6,
        width:MediaQuery.of(context).size.width/1.4,
        decoration:BoxDecoration(
          color:Colors.black12,
          borderRadius: BorderRadius.circular(20),
          ),
      
       child:Column(
         
         children:<Widget> [
         //***********location********************************* */
         Padding(
         padding: EdgeInsets.only(bottom:0),
         child:Container(
          //  height:20,
         child:ListTile(
           title: Text(widget.carddetail['location'],
           style: TextStyle(fontSize:15),),
           leading:Icon(Icons.location_pin),
           minLeadingWidth: 10,
         ),
         ),
         ),
       //*************locationend********************************/
       Expanded(
       child:Row(
       children:<Widget>[
        //*************Postedon********************************/
        Container(
          // height:30,
          width:130,
          // color:Colors.red,
        child: ListTile(
           title: Text(widget.internship_time,
           style: TextStyle(fontSize:12),),
           leading:Icon(Icons.timer),
           minLeadingWidth:1,
        )
        
        ),

             Expanded(
          // height:30,
          // width:150,
          // color:Colors.red,
        child: ListTile(
           title: Text(widget.carddetail['worktime']+" months",
           style: TextStyle(fontSize:12),),
           leading:Icon(Icons.work),
           minLeadingWidth:1,
        )
        
        ),
        
        //  Container(
        //   // height:30,
        //   width:150,
        //   color:Colors.red,
        // child: ListTile(
        //    title: Text("2months ago",
        //    style: TextStyle(fontSize:12),),
        //    leading:Icon(Icons.timeline),
        //    minLeadingWidth:1,
        // )
        // ),
        
        //  Padding(
        //  padding: EdgeInsets.only(),
        //  child:Expanded(
        //   //  width:20,
        //   //  height: 20,
        //    child:ListTile(
        //    title: Text("2months ago",
        //    style: TextStyle(fontSize:15),),
        //    leading:Icon(Icons.timeline),
        //    minLeadingWidth: 10,
        //  ),
        // )
        //  ),
        //*************Postedonend********************************/

       
       
       ],
       ),
       ),
     
     
       ],)
      
      )
      ),
     
      ],
      ),
      //****************Detailsend************************ */      
      
      //*************Details****************************** */
      Row(
        children:<Widget> [
          Padding(
            padding: EdgeInsets.only(left:20,top:10,bottom: 10),
          child:Container(
            height:MediaQuery.of(context).size.height/15,
            width: 100,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(10),
               boxShadow: [BoxShadow(color:Colors.black26,blurRadius:10,spreadRadius:0,offset:Offset(0,10))],

              color:Color(0XFF317CEE),
            ),
            child:FlatButton(
              onPressed:((){
                internshipDetail(context);
          
              }),
              child:Center(child: Text("Details",
              style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),),
            )
          )
          ),
        ],
        ),
      //************Detailsend*************************** */
      
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
             color:widget.carddetail["Allowed"]=="1"?Colors.greenAccent[400]:Colors.blue,
           ),
           child:FlatButton(
             onPressed: (()async{
                                          var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                  widget.carddetail["Allowed"]!="1"?verified(widget.carddetail["enrollmentNo"]):Fluttertoast.showToast(msg:"Already Verified",
               backgroundColor: Colors.green,
               textColor: Colors.white);
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }

               widget.carddetail["Allowed"]!="1"?verified(widget.carddetail["enrollmentNo"]):Fluttertoast.showToast(msg:"Already Verified",
               backgroundColor: Colors.green,
               textColor: Colors.white);
             }),
             child: Text(widget.carddetail["Allowed"]=="1"?"Verified":"Verify",
             style:TextStyle(fontWeight:FontWeight.bold,color:Colors.white),),
             )
         ) ,
         ),
     //***************************************************Delete************************************************** */
      SizedBox(width:80,),
      
       widget.delete,
     
     
     
       ],
      ),

      ],
    ),
  );





  }
}



class InternshipDetails extends StatefulWidget {
var details;
InternshipDetails(this.details);
  
 
  @override
  _InternshipDetails createState() => _InternshipDetails();
}

class _InternshipDetails extends State<InternshipDetails> {

launchUrl(var url) async {

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    Fluttertoast.showToast(msg:"Invalid link",
    backgroundColor: Colors.red,
    textColor: Colors.white);
    throw 'Could not launch $url';
  }
}

   @override
  Widget build(BuildContext context) {
      return Container(
                height:MediaQuery.of(context).size.height/1.4,
              
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
           color:Colors.blue
        //             gradient: LinearGradient(
        //   // begin: Alignment.topLeft,
        //   // end:Alignment(0.8, 0.0),
        //   colors: [
        //       const Color(0xff020024),
        //     //   const Color(0xff090979),
        //     // const Color(0xff00d4ff),
        //   ], // red to yellow
       
        // ),
                ),
                child:Column(
                  children:<Widget>[
                  Padding(
                    padding: EdgeInsets.only(left:50,right:50,top:10),
                    child:Container(
                      height:5,
                      width:50,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(5),
                        color:Colors.grey,
                      ),
                    )
                  
                  ),   
                    

                   Expanded( 
                  child:Padding(
                  padding: EdgeInsets.only(top:30),
                  
                    child:ListView(
                    physics: BouncingScrollPhysics(),
                    children:<Widget>[
                  
                  //***************Details *********************/
                  Padding(
                    padding: EdgeInsets.all(10),
                  child:Text("Description",
                  style:TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color: Colors.white))
                  ),
                  
                   Padding(
                    padding: EdgeInsets.all(10),
                    child:Text(widget.details['details'],
                  style:TextStyle(fontSize:15,color:Colors.white))
                  ),
                  

                  //*************************About************************ */
                    Padding(
                    padding: EdgeInsets.all(10),
                  child:Text("About",
                  style:TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color: Colors.white))
                  ),
                  
                    Padding(
                    padding: EdgeInsets.all(10),
                  child:Text(widget.details['about'],
                  style:TextStyle(fontSize:15,color: Colors.white))
                  ),
                  
                 //***************************Skills************************** */
                  Padding(
                    padding: EdgeInsets.all(10),
                  child:Text("Skills",
                  style:TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color: Colors.white))
                  ),
                
                   Padding(
                    padding: EdgeInsets.all(10),
                  child:Text(widget.details['skills'],
                  style:TextStyle(fontSize:20,color: Colors.white))
                  ),
                  
                  //***************************ApplyNow************************* */
                   Padding(
            padding: EdgeInsets.only(left:20,top:10,bottom:30,right: 20),
          child:Container(
            height:MediaQuery.of(context).size.height/15,
            width:10,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:Colors.red,
            ),
            child:FlatButton(
              onPressed:((){
                launchUrl(widget.details['link']);
              }),
              child:Center(child: Text("Apply Now",
              style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),),
            )
          )
          ),
                 
                  ],
                ),
                ),
                  ),               
                  ],
                ),
           
              );


  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'InternshipDetails.dart';


class InternshipCard extends StatefulWidget {
  var userDetail;
  var image;
  var name;
  // var batch;
  var carddetail;
  var internship_time;
  
  InternshipCard(this.carddetail,this.userDetail)
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
    userDetail.forEach((user){
        if(user['enrollmentNo']==carddetail['enrollmentNo'])
        {
          this.name=user['Name'];
          this.image=user['image'];
          // this.batch=user['batch'];
        }
    });
  }

 
  @override
  _InternshipCard createState() => _InternshipCard();
}

class _InternshipCard extends State<InternshipCard> {

internshipDetail(BuildContext context)
{
  showBottomSheet(
    context: context,
    builder:(BuildContext context) {
              return InternshipDetails(widget.carddetail,widget.carddetail['link']);
    }
    );
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
                backgroundImage: widget.image.toString()=="null"?AssetImage('images/noface.png'):MemoryImage(base64Decode(widget.image)),
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
        Padding(padding: EdgeInsets.only(left:20,top:15,right:20),
      child:Container(
        width: MediaQuery.of(context).size.width/1.4,
       child: Text(widget.carddetail['title'],
      style:TextStyle(fontWeight: FontWeight.bold,fontSize:15,color: Colors.black),overflow: TextOverflow.clip,)
      ),
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
      
      ],
    ),
  );





  }
}
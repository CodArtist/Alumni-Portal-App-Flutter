import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';



class AllAlumni extends StatefulWidget {
  var alumni;
  var college;
  var batch;
  var course;
 
  Widget delete;
AllAlumni(this.alumni,@required this.delete)
{
  this.college=alumni["post_grad_college"]!=""&&alumni["post_grad_college"]!="null"?alumni["post_grad_college"]:alumni["grad_college"];
  this.course=alumni["post_grad_course"]!=""&&alumni["post_grad_course"]!="null"?alumni["post_grad_course"]:alumni["grad_course"];
  this.batch=alumni["post_grad_batch"]!=""&&alumni["post_grad_batch"]!="null"?alumni["post_grad_batch"]:alumni["grad_batch"];
  

}
  @override
  _AllAlumni createState() => _AllAlumni();
}

class _AllAlumni extends State<AllAlumni> {
  verified(var enrollmentNo) async
  {
  var url ="https://alumniportal2001.000webhostapp.com/Verify.php";
  var response = await http.post(url,body:{
    "EnrollmentNo":enrollmentNo,
    "Function":"Alumni",
    "Verified":"1",
  });
  if(response.statusCode==200)
  {setState(() {
    widget.alumni["Allowed"]="1";
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
                backgroundImage: widget.alumni['image'].toString()=="null"?AssetImage("images/noface.png"):MemoryImage(base64Decode(widget.alumni['image'])),
              ),
              title: Text(widget.alumni['Name'],
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text(
                 "Alumni of " + widget.batch+ " batch" ,
                style: TextStyle(fontSize: 10.0, color: Colors.grey),
              ),
            ),
    
      Column(
        children:<Widget> [

          //************************branch********************************************** */
          Row(children: <Widget>[
            SizedBox(width: 20,),
       Text("College"),
         SizedBox(width:62,),
         Icon(Icons.album,
         color:Colors.primaries[5]),
      SizedBox(width: 20,),
        Container(
          width: 120,
          child:Text(
            widget.college
          )
        )

          ],),
     
     SizedBox(height: 20,),
          //************************branch********************************************** */
          Row(children: <Widget>[
            SizedBox(width: 20,),
       Text("Course"),
         SizedBox(width:62,),
         Icon(Icons.album,
         color:Colors.primaries[10]),
      SizedBox(width: 20,),
        Container(
          width: 120,
          child:Text(
            widget.course
          )
        )

          ],),
     
     SizedBox(height: 20,),
     //*****************************EnrollmentNo******************************** */
     
     Row(children: <Widget>[
            SizedBox(width: 20,),
       Text("EnrollmentNo"),
         SizedBox(width: 20,),
         Icon(Icons.album,
         color:Colors.primaries[13]),
      SizedBox(width: 20,),
        Container(
          width: 120,
          child:Text(
            widget.alumni["enrollmentNo"]
          )
        )

          ],),

     SizedBox(height: 20,),


 //*****************************Email******************************** */
     
     Row(children: <Widget>[
            SizedBox(width: 20,),
       Text("Email"),
         SizedBox(width: 71,),
         Icon(Icons.album,
         color:Colors.primaries[5]),
      SizedBox(width: 20,),
        Container(
          width: 120,
          child:Text(
            widget.alumni["Email"]
          )
        )

          ],),
        
             SizedBox(height: 20,),

        
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
             color:widget.alumni["Allowed"]=="1"?Colors.greenAccent[400]:Colors.blue,
           ),
           child:FlatButton(
             onPressed: (()async{
                                          var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                  widget.alumni["Allowed"]!="1"?verified(widget.alumni["enrollmentNo"]):Fluttertoast.showToast(msg:"Already Verified",
               backgroundColor: Colors.green,
               textColor: Colors.white);
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }

              
             }),
             child: Text(widget.alumni["Allowed"]=="1"?"Verified":"Verify",
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
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';



class InternshipDetails extends StatefulWidget {
var details;
var link;
InternshipDetails(this.details,this.link);
  
 
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
                height:MediaQuery.of(context).size.height/1.2,
              
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
      color:Colors.blue,
      
        //             gradient: LinearGradient(
        //   // begin: Alignment.topLeft,
        //   // end:Alignment(0.8, 0.0),
        //   colors: [
        //     const Color(0xffFF0000),
        //     const Color(0xffFF6347),
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
                launchUrl(widget.link);
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
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../User.dart';


class ContactCard extends StatefulWidget {
 var phone;
var email;
var linkedIn;
  ContactCard(this.phone,this.email,this.linkedIn);

  
  @override
  _ContactCardState createState() => _ContactCardState();
}


class _ContactCardState extends State<ContactCard> {
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
  @override
  Widget build(BuildContext context) {
    
      return Column(
        children:<Widget> [
           widget.phone!="null"&&widget.phone!=""? Row(
              children:<Widget>[
                Text("Phone"),
                 SizedBox(
                          width: 34,
                        ),
                        Icon(Icons.album,color: Colors.primaries[2],),
                     
                        SizedBox(
                          width: 30,
                        ),
                Expanded(
                  // width:110,
                  child:Text(widget.phone,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):
        SizedBox(),
        SizedBox(height:20),
          widget.email!="null"&&widget.email!=""?Row(
              children:<Widget>[
                Text("Email"),
                  SizedBox(
                          width:40,
                        ),
                        Icon(Icons.album,color: Colors.primaries[2],),
                     
                        SizedBox(
                          width: 30,
                        ),
                Expanded(
                  child:Text(widget.email,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):
        SizedBox(),
                SizedBox(height:20),

        //           widget.linkedIn!="null"&&widget.linkedIn!=""?Row(
        //       children:<Widget>[
        //         Text("linkedIn"),
        //           SizedBox(
        //                   width:28,
        //                 ),
        //                 Icon(Icons.album,color: Colors.primaries[2],),
                     
        //                 SizedBox(
        //                   width: 30,
        //                 ),
        //         Expanded(
        //           child:InkWell(
        //             onTap:((){
        //               launchUrl(widget.linkedIn);
        //             }),
        //           child:Text(widget.linkedIn,style: TextStyle(color:Colors.blue,fontWeight:FontWeight.normal),),
        //           )
        //         )
        //       ]
        //     ):
        // SizedBox(),
        //   SizedBox(height:20),

        //           User.facebook!="null"&&User.facebook!=""?Row(
        //       children:<Widget>[
        //         Text("Facebook"),
        //           SizedBox(
        //                   width: 17,
        //                 ),
        //                 Icon(Icons.album,color: Colors.primaries[2],),
                     
        //                 SizedBox(
        //                   width: 30,
        //                 ),
        //         Expanded(
        //           child:InkWell(
        //             onTap:((){
        //               launchUrl(User.facebook);
        //             }),
        //           child:Text(User.facebook,style: TextStyle(color:Colors.blue,fontWeight:FontWeight.normal),),
        //           )
        //         )
        //       ]
        //     ):
        // SizedBox(),
        //   SizedBox(height:20),

        //           User.instagram!="null"&&User.instagram!=""?Row(
        //       children:<Widget>[
        //         Text("Instagram"),
        //           SizedBox(
        //                   width: 15,
        //                 ),
        //                 Icon(Icons.album,color: Colors.primaries[2],),
                     
        //                 SizedBox(
        //                   width: 30,
        //                 ),
        //         Expanded(
        //           child:InkWell(
        //             onTap:((){
        //               launchUrl(User.instagram);
        //             }),
        //           child:Text(User.instagram,style: TextStyle(color:Colors.blue,fontWeight:FontWeight.normal),),
        //           )
        //         )
        //       ]
        //     ):
        // SizedBox(),
        //  SizedBox(height:20),

        //           User.twitter!="null"&&User.twitter!=""?Row(
        //       children:<Widget>[
        //         Text("Twitter"),
        //           SizedBox(
        //                   width: 35,
        //                 ),
        //                 Icon(Icons.album,color: Colors.primaries[2],),
                     
        //                 SizedBox(
        //                   width: 30,
        //                 ),
        //         Expanded(
        //           child:InkWell(
        //             onTap:((){
        //               launchUrl(User.twitter);
        //             }),
        //           child:Text(User.twitter,style: TextStyle(color:Colors.blue,fontWeight:FontWeight.normal),),
        //           )
        //         )
        //       ]
        //     ):
        // SizedBox(), 
        ],
      );
  }
}
import 'package:flutter/material.dart';
import 'dart:math';
class Tracker1 extends StatefulWidget {
 var year=[];
var occupation=[];
  List<String> experience;
  Tracker1(var exp)
  {if(exp!=null)
    {this.experience=exp.split("\n");
    this.experience.removeLast();
    experience.forEach((element) {
      year.add(element.split(" ")[0]);
      occupation.add(element.split(" ")[1]);
    });
    }
  }
  @override
  _Tracker1State createState() => _Tracker1State();
}


class _Tracker1State extends State<Tracker1> {
  @override
  Widget build(BuildContext context) {
    
      return Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
          
            children:[
             Container(
                          // color: Colors.red,
              
              width: MediaQuery.of(context).size.width/1.3,
             child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.year.length!=0?widget.year.length:1,
                  itemBuilder: (context,index){
                    if(widget.year.length==0)
                    return Center(child:Text("No Experience"));
                    return Padding(

                      padding: EdgeInsets.only(bottom:30),

                      child:Row(
                        children:<Widget>[
                          Text(widget.year[index],
              style: TextStyle(
                              fontSize: 15,
                              color:Colors.grey[600]),),
                          
                        SizedBox(
                          width: 50,
                        ),
                        Icon(Icons.album,color: Colors.primaries[index],),
                     
                        SizedBox(
                          width: 50,
                        ),
                         Text(widget.occupation[index],
                     style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color:Colors.black),),
                       
                        ],
                             
                              ),
                        
                    );
              
              // SizedBox( height: 50);
                  }

            ),
            ),



            ]
          //     Text("Present",
          //     style: TextStyle(
          //                     fontSize: 15,
          //                     color:Colors.grey[600]),),
          //     SizedBox( height: 50),

          //     Text("2020",
          //    style: TextStyle(
          //                     fontSize: 15,
          //                     color:Colors.grey[600]),),
          //     SizedBox( height: 50),

          //     Text("2018",
          //     style: TextStyle(
          //                     fontSize: 15,
          //                     color:Colors.grey[600]),),
          //     SizedBox( height: 50),

          // Text("2015",
          //     style: TextStyle(
          //                     fontSize: 15,
          //                     color:Colors.grey[600]),),
          //     SizedBox( height: 40),

          //   ]
          ),
        
          // Text("jhgj"),
        
        
//         Column(
          
//           // crossAxisAlignment: CrossAxisAlignment.start,
//            children:[
//              Container(
//                           // color: Colors.red,
              
//               width: MediaQuery.of(context).size.width/1.3,
//              child: ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: year.length!=0?year.length:1,
//                   itemBuilder: (context,index){
//                     if(year.length==0)
//                     return SizedBox();
//                     return Padding(
//                       padding: EdgeInsets.only(bottom:30),
//                       child:Text("Present",
//               style: TextStyle(
//                               fontSize: 15,
//                               color:Colors.grey[600]),),);
//               // SizedBox( height: 50);
//                   }

//             ),
//             ),



//             ]
// //           children:[
// //             Text("ANALYST",
// //               style: TextStyle(
// //                               fontSize: 15,
// //                               fontWeight: FontWeight.bold,
// //                               color:Colors.black),),

// //             Text("ITM UNIVERSITY Sep 2020 - Till Now",
// //               style: TextStyle(
// //                               fontSize: 12,
                              
// //                               color:Colors.grey[700]),),                  
// // SizedBox( height: 35),
// //             Text("FREE LANCER",
// //               style: TextStyle(
                              
// //                               fontSize: 15,
// //                               fontWeight: FontWeight.bold,
// //                               color:Colors.cyanAccent),),        

// //              Text("Upgrade (8 Sep 2018 - Sep 2020)",
// //               style: TextStyle(
// //                               fontSize: 12,
                              
// //                               color:Colors.grey[700]),),

// // SizedBox( height: 35),

// //            Text("PROGRAMMER",
// //               style: TextStyle(
                              
// //                               fontSize: 15,
// //                               fontWeight: FontWeight.bold,
// //                               color:Colors.black),),     

// //                      Text("UNIVERSITY (Sep 2015 - Sep 2018)",
// //               style: TextStyle(
// //                               fontSize: 12,
                              
// //                               color:Colors.grey[700]),),
         

// // SizedBox( height: 35),

// // Text("WEB DEVLOPER",
// //               style: TextStyle(
                              
// //                               fontSize: 15,
// //                               fontWeight: FontWeight.bold,
// //                               color:Colors.black),),   

// //                               Text("UNIVERSITY (Aug 2011 - Sep 2015)",
// //               style: TextStyle(
// //                               fontSize: 12,
                              
// //                               color:Colors.grey[700]),),


// // SizedBox( height: 35),

// //           ]
//         )
        
        ],
      );
   
   
   

   
   
   
   
   
   
   
   
   /* return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:[
                            Text("Present",
                            style: TextStyle(
                              fontSize: 15,
                              color:Colors.grey[600]
                            ),
                            ),
                            Text("ANALYST",
                            style: TextStyle(
                              color:Colors.grey[800],
                              fontSize:15,
                            ))
                          ]
                        );*/
  }
}
import 'package:flutter/material.dart';
import 'dart:math';
import '../../User.dart';

class EducationCard extends StatefulWidget {
 var college;
var school;
  EducationCard(this.college,this.school);

  
  @override
  _EducationCardState createState() => _EducationCardState();
}


class _EducationCardState extends State<EducationCard> {
  @override
  Widget build(BuildContext context) {
    
      return Column(
        children:<Widget> [

 //**********************************Post Graduation*************************************************************** */
           User.post_grad_college!="null"&&User.post_grad_college!=""? Row(
              children:<Widget>[
                
                Text("College"),
                 SizedBox(
                          width:38,
                        ),
                        Icon(Icons.album,color: Colors.primaries[15],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:110,
                  child:Text(User.post_grad_college,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),
             User.post_grad_college!="null"&&User.post_grad_college!=""? SizedBox(height:20): SizedBox(),

        User.post_grad_cgpa!="null"&&User.post_grad_cgpa!=""? Row(
              children:<Widget>[
                Text("CGPA"),
                 SizedBox(
                          width: 50,
                        ),
                        Icon(Icons.album,color: Colors.primaries[15],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:110,
                  child:Text(User.post_grad_cgpa,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),  
            User.post_grad_cgpa!="null"&&User.post_grad_cgpa!=""?SizedBox(height:20):SizedBox(),
         
          User.post_grad_course!="null"&&User.post_grad_course!=""? Row(
              children:<Widget>[
                Text("Course"),
                 SizedBox(
                          width: 43,
                        ),
                        Icon(Icons.album,color: Colors.primaries[15],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:110,
                  child:Text(User.post_grad_course,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),
            User.post_grad_course!="null"&&User.post_grad_course!=""?SizedBox(height:20):SizedBox(),

          User.post_grad_batch!="null"&&User.post_grad_batch!=""? Row(
              children:<Widget>[
                Text("Batch"),
                 SizedBox(
                          width: 53,
                        ),
                        Icon(Icons.album,color: Colors.primaries[15],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:110,
                  child:Text(User.post_grad_batch,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),
            User.post_grad_batch!="null"&&User.post_grad_batch!=""?SizedBox(height:20):SizedBox(), 

        //  (User.grad_college!="null"&&User.grad_college!="")||( User.grad_cgpa!="null"&&User.grad_cgpa!="")||(User.grad_course!="null"&&User.grad_course!="")||(User.grad_batch!="null"&&User.grad_batch!="")? Text("Graduation",
        //   style:TextStyle(fontWeight: FontWeight.w500)):SizedBox(),
        //   SizedBox(height: 20,),
//**********************************Graduation*************************************************************** */
           widget.college!="null"&&widget.college!=""? Row(
              children:<Widget>[
                
                Text("College"),
                 SizedBox(
                          width:38,
                        ),
                        Icon(Icons.album,color: Colors.primaries[4],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:110,
                  child:Text(widget.college,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),
             widget.college!="null"&&widget.college!=""? SizedBox(height:20): SizedBox(),

        User.grad_cgpa!="null"&&User.grad_cgpa!=""? Row(
              children:<Widget>[
                Text("CGPA"),
                 SizedBox(
                          width: 50,
                        ),
                        Icon(Icons.album,color: Colors.primaries[4],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:110,
                  child:Text(User.grad_cgpa,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),  
            User.grad_cgpa!="null"&&User.grad_cgpa!=""?SizedBox(height:20):SizedBox(),
         
          User.grad_course!="null"&&User.grad_course!=""? Row(
              children:<Widget>[
                Text("Course"),
                 SizedBox(
                          width: 43,
                        ),
                        Icon(Icons.album,color: Colors.primaries[4],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:110,
                  child:Text(User.grad_course,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),
            User.grad_course!="null"&&User.grad_course!=""?SizedBox(height:20):SizedBox(),

          User.grad_batch!="null"&&User.grad_batch!=""? Row(
              children:<Widget>[
                Text("Batch"),
                 SizedBox(
                          width: 53,
                        ),
                        Icon(Icons.album,color: Colors.primaries[4],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:110,
                  child:Text(User.grad_batch,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),
            User.grad_batch!="null"&&User.grad_batch!=""?SizedBox(height:20):SizedBox(),
        

      

  // (widget.school!="null"&&widget.school!="")||(User.marks_10!="null"&&User.marks_10!="")||(User.marks_12!="null"&&User.marks_12!="")||( User.school_year_10!="null"&&User.school_year_10!="")||(User.school_board_10!="null"&&User.school_board_10!=""&&User.school_board_10!=null)? Center(child:Text("Schooling",
  //         style:TextStyle(fontWeight: FontWeight.w500))):SizedBox(),
  //         SizedBox(height: 20,),

          //*******************Schooling******************************************************** */
              //****************************************12 school************************************************ */
          User.school_12!="null"&&User.school_12!=""?Row(
              children:<Widget>[
                Text("12th School"),
                  SizedBox(
                          width:20,
                        ),
                        Icon(Icons.album,color: Colors.primaries[6],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  child:Text(User.school_12,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ): SizedBox(),
             User.school_12!="null"&&User.school_12!=""?SizedBox(height: 20,):SizedBox(),
       
       User.school_board_12!="null"&&User.school_board_12!=""&&User.school_board_12!=null? Row(
              children:<Widget>[
                Text("12th Board"),
                 SizedBox(
                          width:27,
                        ),
                        Icon(Icons.album,color: Colors.primaries[6],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:112,
                  child:Text(User.school_board_12,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),
            User.school_board_12!="null"&&User.school_board_12!=""&&User.school_board_12!=null? SizedBox(height:20):SizedBox(),        
      
       User.marks_12!="null"&&User.marks_12!=""? Row(
              children:<Widget>[
                Text("12th %"),
                 SizedBox(
                          width: 55,
                        ),
                        Icon(Icons.album,color: Colors.primaries[6],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:112,
                  child:Text(User.marks_12,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),
            User.marks_12!="null"&&User.marks_12!=""? SizedBox(height:20):SizedBox(),
            
                    User.school_year_12!="null"&&User.school_year_12!=""? Row(
              children:<Widget>[
                Text("12th Pass Year"),
                 SizedBox(
                          width:5,
                        ),
                        Icon(Icons.album,color: Colors.primaries[6],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:112,
                  child:Text(User.school_year_12,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ): SizedBox(),
            User.school_year_12!="null"&&User.school_year_12!=""?SizedBox(height:20): SizedBox(),

          //******************10 School********************************************************* */
          User.school_10!="null"&&User.school_10!=""?Row(
              children:<Widget>[
                Text("10th School"),
                  SizedBox(
                          width:25,
                        ),
                        Icon(Icons.album,color: Colors.primaries[6],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  child:Text(User.school_10,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ): SizedBox(),
             User.school_10!="null"&&User.school_10!=""?SizedBox(height: 20,):SizedBox(),
       
       User.school_board_10!="null"&&User.school_board_10!=""&&User.school_board_10!=null? Row(
              children:<Widget>[
                Text("10th Board"),
                 SizedBox(
                          width:30,
                        ),
                        Icon(Icons.album,color: Colors.primaries[6],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:110,
                  child:Text(User.school_board_10,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),
            User.school_board_10!="null"&&User.school_board_10!=""&&User.school_board_10!=null? SizedBox(height:20):SizedBox(),        
      
       User.marks_10!="null"&&User.marks_10!=""? Row(
              children:<Widget>[
                Text("10th %"),
                 SizedBox(
                          width: 60,
                        ),
                        Icon(Icons.album,color: Colors.primaries[6],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:110,
                  child:Text(User.marks_10,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ):SizedBox(),
            User.marks_10!="null"&&User.marks_10!=""? SizedBox(height:20):SizedBox(),
            
                    User.school_year_10!="null"&&User.school_year_10!=""? Row(
              children:<Widget>[
                Text("10th Pass Year"),
                 SizedBox(
                          width:10,
                        ),
                        Icon(Icons.album,color: Colors.primaries[6],),
                     
                        SizedBox(
                          width: 50,
                        ),
                Expanded(
                  // width:110,
                  child:Text(User.school_year_10,style: TextStyle(fontWeight:FontWeight.bold),),
                )
              ]
            ): SizedBox(),
            User.school_year_10!="null"&&User.school_year_10!=""?SizedBox(height:20): SizedBox(),


 

          
        
         
       
        ],
      );
  }
}
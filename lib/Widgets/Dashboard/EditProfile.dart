// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'tracker1.dart';
// import '../../User.dart';
// import 'dart:convert';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;








// class EditProfile extends StatefulWidget {
//   @override
//   _EditProfileState createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   bool _secureText = true;
//   String value;
//   var year=[];
//   var occupation=[];
//   List<Experience> experience =[];
//   TextEditingController name= new TextEditingController();
//   TextEditingController email= new TextEditingController();
//   TextEditingController phone= new TextEditingController();
//   TextEditingController linkedIn= new TextEditingController();
//   TextEditingController school= new TextEditingController();
//   TextEditingController college= new TextEditingController();
//   TextEditingController marks_10= new TextEditingController();
//   TextEditingController marks_12= new TextEditingController();
//   TextEditingController cgpa= new TextEditingController();
//   TextEditingController facebook= new TextEditingController();
//   TextEditingController instagram= new TextEditingController();
//   TextEditingController twitter= new TextEditingController();


//   String image;
//   var isLoading=false;


//   @override
//   initState(){
//     super.initState();
  
//   var exp =User.experience;
//   name.text=User.name;
//   email.text=User.email;
//   college.text=User.college=="null"?"":User.college;
//   image=User.image;
//   linkedIn.text=User.linkedIn=="null"?"":User.linkedIn;
//   phone.text=User.phone=="null"?"":User.phone;
//   school.text=User.school=="null"?"":User.school;
//   marks_10.text=User.marks_10=="null"?"":User.marks_10;
//   marks_12.text=User.marks_12=="null"?"":User.marks_12;
//   cgpa.text=User.cgpa=="null"?"":User.cgpa;
//   facebook.text=User.facebook=="null"?"":User.facebook;
//   instagram.text=User.instagram=="null"?"":User.instagram;
//   twitter.text=User.twitter=="null"?"":User.twitter;

//   _passwordController.text=User.password;


//   print(exp);
//   if(User.experience!=null)
//   {exp=User.experience.split("\n");
//   exp.removeLast();
//     exp.forEach((element){
//       setState(() {
//        year.add(element.split(" ")[0]);
//   var ele=element.split(" ");
//    var str="";
//    for(var i =1;i<ele.length;i++)
//    {
// str=str+ele[i]+" ";
//    }

//       occupation.add(str);      }); 
//     }); 
//   }

//   for(var i =0;i<year.length;i++) {
    
//     setState(() {
//       experience.add(new Experience(year[i].split("-")[0],year[i].split("-")[1],occupation[i].split("&")[0],occupation[i].split("&")[1]));
//     });
//   }


//   }

//   TextEditingController _passwordController = TextEditingController();
//   String _passwordError;

//   //var _formKey = GlobalKey<FormState>();

// File imageFile;

// imagePicker()async{
// var pickedimage=await ImagePicker().getImage(source: ImageSource.gallery);
// if(pickedimage!=null)
// {
// setState(() {
//   imageFile=File(pickedimage.path);
//   image=base64Encode(imageFile.readAsBytesSync());
// });

// print(image);

// }

// }


// addExperience(){
//  print(experience.length);
//   setState(() {
//      experience.add(new Experience("","","",""));
//   });
// }


// removeExperience(){
//  print(experience.length);
//   setState(() {
//      experience.removeLast();
//   });
// }

// saveChanges()async{
// var validexp=true;
//  var exp="";
// print(linkedIn.text);
//  if(name.text.isNotEmpty&&_passwordController.text.isNotEmpty&&email.text.isNotEmpty)
//  { 
   


//    //****************************Add Experience***************************************** */
//    experience.forEach((element) {
//     if(element.year1Controller.text.isNotEmpty&&element.year2Controller.text.isNotEmpty&&element.occupationController.text.isNotEmpty&&element.companyController.text.isNotEmpty)
//     {if(int.parse(element.year1Controller.text)<int.parse(element.year2Controller.text))
//     exp= exp + element.year1Controller.text+"-"+ element.year2Controller.text + " " + element.occupationController.text +"&"+ element.companyController.text+ "\n"; 
//     else
//     {validexp=false;
//     print("false");
//     }
    
//     }
   
//    });

//   var url ="https://alumniportal2001.000webhostapp.com/EditProfile.php";
// if(validexp)
// {        setState(() {
//            isLoading=true;
//               });
//   var response = await http.post(url,body: {
//     'EnrollmentNo':User.enrollmentNo,
//     'Name':name.text,
//     'Password':_passwordController.text,
//     'Email':User.email,
//     'Phone':phone.text==""?"null":phone.text,
//     'LinkedIn':linkedIn.text==""?"null":linkedIn.text,
//     'Experience':exp==""?"null":exp,
//     'School':school.text==""?"null":school.text,
//     'College':college.text==""?"null":college.text,
//     'Image':image.toString()=="null"?"null":image,
//     'Marks_10':marks_10.text==""?"null":marks_10.text,
//     'Marks_12':marks_12.text==""?"null":marks_12.text,
//     'CGPA':cgpa.text==""?"null":cgpa.text,
//     'Facebook':facebook.text==""?"null":facebook.text,
//     'Instagram':instagram.text==""?"null":instagram.text,
//     'Twitter':twitter.text==""?"null":twitter.text,
//   });   
// print("ended");
// print(response.body);
//   if(jsonDecode(response.body).toString()=="true")
//   {    Fluttertoast.showToast(msg: "Changes Saved",
//     textColor: Colors.white,
//     backgroundColor: Colors.green);
//       setState(() {
//     isLoading=false;
//   });
//     print("true");
//     print(response.body.toString());
//     User.experience=exp;
//     User.image=image;
//     User.password=_passwordController.text;
//     User.name=name.text;
//     User.phone=phone.text;
//     User.school=school.text;
//     User.college=college.text;
//     User.linkedIn=linkedIn.text;
//     User.email=email.text;
//     User.marks_10=marks_10.text;
//     User.marks_12=marks_12.text;
//     User.cgpa=cgpa.text;
//     User.facebook=facebook.text;
//     User.instagram=instagram.text;
//     User.twitter=twitter.text;

// Navigator.pop(context);
   
//   }
//   else
//   {
//     Fluttertoast.showToast(msg: "error occured",
//     textColor: Colors.white,
//     backgroundColor: Colors.red);
//   }
//   print("not true");
//   print(jsonDecode(response.body.toString()).toString());
//   setState(() {
//     isLoading=false;
//   });
//  }
//  else
// Fluttertoast.showToast(msg:"Add proper year",
// backgroundColor: Colors.red,
// textColor: Colors.white);
// }

// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading:IconButton(icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.greenAccent,),
//          onPressed:() {Navigator.pop(context);} ,),
//         title: Text("Edit Profile",
        
//         style: TextStyle(
//           color: Colors.black
//         ),
//         /*leading: IconButton( icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,) 
//         onPressed: null)*/
//         ),),
      
      
//         body:isLoading?Center(child:Image.asset("images/spinner.gif",scale:2)):SafeArea(
//             child:ListView(
//           physics: BouncingScrollPhysics(),
//           children:<Widget>[
            
//             SizedBox(height: 50),
//                Row(mainAxisAlignment: MainAxisAlignment.center,
//                  children: [ 
//                 Padding(
//                   padding: EdgeInsets.only(left:30),
//                 child: CircleAvatar(
//                   backgroundImage: image.toString()=="null"?AssetImage("images/noface.png"):MemoryImage(base64Decode(image)),
//                   radius: 50,
                
                
//                 ),
//                 ),
               
//               //  Image.memory(base64Decode(image),fit: BoxFit.cover,),
//                 FlatButton(
//                   minWidth:0.1,
                  
//                   onPressed: ((){
//                     imagePicker();
//                   }),
//                   child:Container(
//                   height: 30,
//                   width: 30,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 boxShadow: [BoxShadow(color:Colors.black26,spreadRadius:0,blurRadius:10,offset: Offset(0,10))],
//                 color: Colors.white
//               ),
                  
//                   child:Icon(Icons.edit,
//                 color: Colors.greenAccent,
//                 size: 20
//                 )
//                 ),
//                 )
//                 ],),
//               SizedBox(height: 50),
//               Padding(
//                  padding: EdgeInsets.only(left:30,bottom: 20),
//                child: Text("Personal Info",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
//                ),
//               TextField(
//                 controller: name,
                
//                 decoration: InputDecoration(
//                     //hintText: "Your Name",

//                     labelText: "Full Name",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     //border: InputBorder.none,
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
//                 maxLength: 30,
//               ),
//               // SizedBox(
//               //   height: 16,
//               // ),
             
//          SizedBox(
//                 height: 16,),
//               TextField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                     labelText: "Password",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     //labelText: "Password",
//                     errorText: _passwordError,
//                     fillColor: Colors.white,
//                     filled: true,
                    
//                     //border: OutlineInputBorder(),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                           _secureText ? Icons.remove_red_eye : Icons.security),
//                       onPressed: () {
//                         setState(() {
//                           _secureText = !_secureText;
//                         });
//                       },
//                     )),
//                 obscureText: _secureText,
//               ),
             
//                SizedBox(
//                 height: 30,),
//                Padding(
//                  padding: EdgeInsets.only(left:30),
//                child: Text("Experience",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
//                ),
//                   SizedBox(
//                 height: 40,),
//             Padding(
//               padding: EdgeInsets.only(left:20),
//               child:Container(
//               // height: 50,
//               // width: 100,
//              child: ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: experience.length!=0?experience.length:1,
//                   itemBuilder: (context,index){
//                     if(experience.length==0)
//                     return SizedBox(height: 10,);
//                     return experience[index];
//                   },

//             ),
//             ),
//             ),
//                 SizedBox(
//                 height: 10,),
            
//               Padding(
//                 padding: EdgeInsets.only(left:30),
//                 child:Row(
//               children:<Widget>[
//                  Container(
//                height: 50,
//                width: 50,
              
//                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(25),
//                   color: Colors.blue,
//                   boxShadow: [BoxShadow(color:Colors.black26,spreadRadius:0,blurRadius:10,offset:Offset(0,8))]
//                ),
//                       child:Center(
//                         child:FlatButton(                     
//                         onPressed: ((){
//                        addExperience();
//                         }),
//                    child: Align(alignment: Alignment(0,0),
//                      child:Text("+",
//                      style: TextStyle(color: Colors.white,fontSize: 25),)),
//                         ),
//                           ),
//                  ),
              
//                 SizedBox(width:MediaQuery.of(context).size.width/7),
                
               

//                    SizedBox(width:MediaQuery.of(context).size.width/7),

//                   experience.length!=0?Container(
//                height: 50,
//                width: 50,
//                  decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(25),
//                   color: Colors.blue,
//                 boxShadow: [BoxShadow(color:Colors.black26,spreadRadius:0,blurRadius:10,offset:Offset(0,8))]

//                ),
//                       child:FlatButton(
//                         onPressed: ((){
//                        removeExperience();
//                         }),
//                    child: Align(alignment: Alignment(0,0),
//                      child:Text("-",
//                      style: TextStyle(color: Colors.white,fontSize: 25),)),
//                         ),
//                           ):
//                 SizedBox(),
//               ]
//             ),      
//               ),
            
            
              
//               SizedBox(
//                 height: 50,
//               ),
              
//                Padding(
//                  padding: EdgeInsets.only(left:30),
//                child: Text("Education",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
//                ),
//                   SizedBox(
//                 height: 20,),
               
//                                  TextField(
//                controller: college,
//                 decoration: InputDecoration(
//                     //hintText: "Your Name",
//                     labelText: "College",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     //border: InputBorder.none,
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
                
//               ),
//                 TextField(
//                controller: cgpa,
//                 decoration: InputDecoration(
//                     //hintText: "Your Name",
//                     labelText: "College CGPA",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     //border: InputBorder.none,
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
                
//               ),

//                                  TextField(
//                controller: school,
//                 decoration: InputDecoration(
//                     //hintText: "Your Name",
//                     labelText: "school",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     //border: InputBorder.none,
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
                
//               ),
              
//               TextField(
//                controller:marks_10,
//                 decoration: InputDecoration(
//                     labelText: "10th Percentage",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
                
//               ),
              
//                TextField(
//                controller:marks_12,
//                 decoration: InputDecoration(
//                     labelText: "12th Percentage",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
                
//               ),
                
//                    SizedBox(
//                 height: 20,),
//                 Padding(
//                  padding: EdgeInsets.only(left:30),
//                child: Text("Contact",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
//                ),
//                   SizedBox(
//                 height: 20,),
           
//              TextField(
//                controller: email,
//                 decoration: InputDecoration(
//                     //hintText: "Your Name",
//                     labelText: "Email",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     //border: InputBorder.none,
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
                
//               ),
//          TextField(
//                controller: phone,
//                keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                     //hintText: "Your Name",
//                     labelText: "Phone",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     //border: InputBorder.none,
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
                
//               ),
//                   TextField(
//                controller: linkedIn,
//                 decoration: InputDecoration(
//                     //hintText: "Your Name",
//                     labelText: "LinkedIn",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     //border: InputBorder.none,
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
                
//               ),
//               TextField(
//                controller: facebook,
//                 decoration: InputDecoration(
//                     //hintText: "Your Name",
//                     labelText: "Facebook",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     //border: InputBorder.none,
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
                
//               ),
//             TextField(
//                controller:instagram,
//                 decoration: InputDecoration(
//                     //hintText: "Your Name",
//                     labelText: "Instagram",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     //border: InputBorder.none,
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
                
//               ),
//             TextField(
//                controller: twitter,
//                 decoration: InputDecoration(
//                     //hintText: "Your Name",
//                     labelText: "Twitter",
//                     labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
//                     //border: InputBorder.none,
//                     fillColor: Colors.white,
//                     filled: true),
//                 obscureText: false,
                
//               ),
//          SizedBox(
//                 height: 16,),
             



//               Padding(padding: EdgeInsets.all(20),
//              child: Row( 
//                children:[
                         

//                             SizedBox(width: 30),

//                             Container(
                                
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(30),
//                                   color: Colors.greenAccent
//                                 ),
//                                 child: SizedBox(
//                                   height: 50,
//                                   width: 100,
//                                   child: FlatButton(onPressed: (){
                            
//                                     saveChanges();
//                                   }, 
//                                   child: isLoading?Image.asset("images/loading.gif"):Text("SAVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
//                                 ),),
//                               ),
                           
//         ],
//                ),)
           
       
//           ],
//         ),
        
//         ),
//    );
//   }
// }










// //********************************Experience******************************************************* */
//  class Experience extends StatelessWidget{
//   TextEditingController occupationController =new TextEditingController();
//   TextEditingController yearController =new TextEditingController();
//   TextEditingController companyController =new TextEditingController();
//   TextEditingController year1Controller =new TextEditingController();
//   TextEditingController year2Controller =new TextEditingController();


//   Experience(String year1,String year2,String occupation,String company){
//     this.occupationController.text=occupation;
//     this.year1Controller.text=year1;
//         this.year2Controller.text=year2;
//             this.companyController.text=company;


//   }

//   @override 
//   Widget build(BuildContext context){
//      return Padding(
//        padding: EdgeInsets.only(bottom:20),
//        child:Container(
//       child: Row(
//    children:<Widget> [
//      Padding(
//        padding:EdgeInsets.only(right:5),
//        child:Container(
// width: MediaQuery.of(context).size.width/6,
//    child:TextField(
//      controller: year1Controller,
//      style: TextStyle(fontSize: 15),
//      decoration:InputDecoration(
//             filled:true,
//             labelText: "Year",
          
//             fillColor: Colors.grey[50],
//             // hintText: "Title",
//             contentPadding: const EdgeInsets.only(left:10,top:10,bottom:10),
//             border: OutlineInputBorder(
//                borderSide: const BorderSide(color: Colors.grey, width:3.0),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.green, width:3.0),
//               borderRadius: BorderRadius.circular(25.0),

//             )     ) ,
//      )
//  ),
//      ),
    
//     Text("to"),
    

//      Padding(
//        padding:EdgeInsets.only(right:5,left:5),
//        child:Container(
// width: MediaQuery.of(context).size.width/6,
//    child:TextField(
//      controller: year2Controller,
//      style: TextStyle(fontSize: 15),
//      decoration:InputDecoration(
//             filled:true,
//             labelText: "Year",
          
//             fillColor: Colors.grey[50],
//             // hintText: "Title",
//             contentPadding: const EdgeInsets.only(left:10,top:10,bottom:10),
//             border: OutlineInputBorder(
//                borderSide: const BorderSide(color: Colors.grey, width:3.0),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.green, width:3.0),
//               borderRadius: BorderRadius.circular(25.0),

//             )     ) ,
//      )
//  ),
//      ),
    
//   Column(
//     children:<Widget>[
//       Container(
//       width: MediaQuery.of(context).size.width/2,
//       child: TextField(controller: occupationController,
//                  style: TextStyle(fontSize: 15),

//                 decoration:InputDecoration(
//             filled:true,
//             labelText: "Occupation",
          
//             fillColor: Colors.grey[50],
//             // hintText: "Title",
//             contentPadding: const EdgeInsets.only(left:10,top:10,bottom:10),
//             border: OutlineInputBorder(
//                borderSide: const BorderSide(color: Colors.grey, width:3.0),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.green, width:3.0),
//               borderRadius: BorderRadius.circular(25.0),

//             )     ) ,
//                 obscureText: false,),
//     ),
//     SizedBox(height:20 ,),
//     Container(
//       width: MediaQuery.of(context).size.width/2,
//       child: TextField(controller: companyController,
//                  style: TextStyle(fontSize: 15),

//                 decoration:InputDecoration(
//             filled:true,
//             labelText: "Company",
          
//             fillColor: Colors.grey[50],
//             // hintText: "Title",
//             contentPadding: const EdgeInsets.only(left:10,top:10,bottom:10),
//             border: OutlineInputBorder(
//                borderSide: const BorderSide(color: Colors.grey, width:3.0),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.green, width:3.0),
//               borderRadius: BorderRadius.circular(25.0),

//             )     ) ,
//                 obscureText: false,),
//     ),
//     ]
//       ),

//    ],
//        ),
//        ),
//   );
//   }
// }
// 




import 'dart:math';

import 'package:flutter/material.dart';
import 'tracker1.dart';
import '../../User.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';








class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _secureText = true;
  String value;
  var year=[];
  var occupation=[];
  List<Experience> experience =[];
  TextEditingController name= new TextEditingController();
  TextEditingController email= new TextEditingController();
  TextEditingController phone= new TextEditingController();
  TextEditingController linkedIn= new TextEditingController();
  TextEditingController facebook= new TextEditingController();
  TextEditingController instagram= new TextEditingController();
  TextEditingController twitter= new TextEditingController();

  TextEditingController school_10= new TextEditingController();
  TextEditingController marks_10= new TextEditingController();
  TextEditingController school_year_10= new TextEditingController();
    
  TextEditingController school_12= new TextEditingController();
  TextEditingController marks_12= new TextEditingController();
  TextEditingController school_year_12= new TextEditingController();

  TextEditingController grad_course= new TextEditingController();
  TextEditingController grad_college= new TextEditingController();
  TextEditingController grad_cgpa= new TextEditingController();
  TextEditingController grad_batch= new TextEditingController();
  
  TextEditingController post_grad_course= new TextEditingController();
  TextEditingController post_grad_college= new TextEditingController();
  TextEditingController post_grad_cgpa= new TextEditingController();
  TextEditingController post_grad_batch= new TextEditingController();


  String image;
  var isLoading=false;


  String school_board_10=null;
  String school_board_12=null;
  List listItems=[ 
     'CBSE - Central Board of Secondary Education' , 'ISC - Indian School Certificate' , 'ICSE - Indian School Certificate Examinations ' , 'NIOS – National Institute of Open Schooling' , 'UP Board - Board of High School and Intermediate Education Uttar Pradesh' , 'JKBOSE - Jammu and Kashmir State Board of School Education' , 'RBSE - Board of Secondary Education Rajasthan' , 'HPBOSE - Himachal Pradesh Board of School Education', 'MPBSE - Madhya Pradesh Board of Secondary Education' , 'CGBSE - Chhattisgarh Board of Secondary Education' , 'PSEB – Punjab School Education Board' , 'BSEH - Haryana Board of School Education (HBSE)' , 'BSEB - Bihar School Examination Board' , 'GSEB - Gujarat Secondary and Higher Secondary Education Board' , 'MSBSHSE – Maharashtra State Board Of Secondary and Higher Secondary Education' , 'BIEAP - Andhra Pradesh Board of Intermediate Education' , 'BSEAP - Andhra Pradesh Board of Secondary Education' , 'WBBSE - West Bengal Board of Secondary Education', 'WBCHSE - West Bengal Council of Higher Secondary Education'    
  ];

  Future<bool> checkUrl(var url) async {
  if (await canLaunch(url)) {
    return Future<bool>.value(true);
  } else {
     return Future<bool>.value(false);
  }

}

  @override
  initState(){
    super.initState();
  
  var exp =User.experience;
  name.text=User.name;
  email.text=User.email;
  image=User.image;
  linkedIn.text=User.linkedIn=="null"?"":User.linkedIn;
  phone.text=User.phone=="null"?"":User.phone;

  facebook.text=User.facebook=="null"?"":User.facebook;
  instagram.text=User.instagram=="null"?"":User.instagram;
  twitter.text=User.twitter=="null"?"":User.twitter;

  school_10.text=User.school_10=="null"?"":User.school_10;
  marks_10.text=User.marks_10=="null"?"":User.marks_10;
  school_year_10.text=User.school_year_10=="null"?"":User.school_year_10;
  school_board_10=User.school_board_10=="null"||User.school_board_10=="NULL"||User.school_board_10==null?null:User.school_board_10;

  school_12.text=User.school_12=="null"?"":User.school_12;
  marks_12.text=User.marks_12=="null"?"":User.marks_12;
  school_year_12.text=User.school_year_12=="null"?"":User.school_year_12;
  school_board_12=User.school_board_12=="null"||User.school_board_12=="NULL"||User.school_board_12==null?null:User.school_board_12;


  grad_college.text=User.grad_college=="null"?"":User.grad_college;
  grad_course.text=User.grad_course=="null"?"":User.grad_course;
  grad_cgpa.text=User.grad_cgpa=="null"?"":User.grad_cgpa;
  grad_batch.text=User.grad_batch=="null"?"":User.grad_batch;

  post_grad_college.text=User.post_grad_college=="null"?"":User.post_grad_college;
  post_grad_course.text=User.post_grad_course=="null"?"":User.post_grad_course;
  post_grad_cgpa.text=User.post_grad_cgpa=="null"?"":User.post_grad_cgpa;
  post_grad_batch.text=User.post_grad_batch=="null"?"":User.post_grad_batch;

  _passwordController.text=User.password;


  if(User.experience!=null)
  {exp=User.experience.split("\n");
  exp.removeLast();
    exp.forEach((element){
      setState(() {
       year.add(element.split(" ")[0]);
  var ele=element.split(" ");
   var str="";
   for(var i =1;i<ele.length;i++)
   {
str=str+ele[i]+" ";
   }

      occupation.add(str);      }); 
    }); 
  }

  for(var i =0;i<year.length;i++) {
    
    setState(() {
      experience.add(new Experience(year[i].split("-")[0],year[i].split("-")[1],occupation[i].split("&")[0],occupation[i].split("&")[1]));
    });
  }


  }

  TextEditingController _passwordController = TextEditingController();
  String _passwordError;

  //var _formKey = GlobalKey<FormState>();

File imageFile;

imagePicker()async{
var pickedimage=await ImagePicker().getImage(source: ImageSource.gallery);
if(pickedimage!=null)
{
setState(() {
  imageFile=File(pickedimage.path);
  image=base64Encode(imageFile.readAsBytesSync());
});

print(image);

}

}


addExperience(){
 print(experience.length);
  setState(() {
     experience.add(new Experience("","","",""));
  });
}


removeExperience(){
 print(experience.length);
  setState(() {
     experience.removeLast();
  });
}

saveChanges()async{
var validexp=true;
 var exp="";
 print(school_board_12);


 if(name.text.isNotEmpty&&_passwordController.text.isNotEmpty&&email.text.isNotEmpty)
 { 
   


   //****************************Add Experience***************************************** */
   experience.forEach((element) {
    if(element.year1Controller.text.isNotEmpty&&element.year2Controller.text.isNotEmpty&&element.occupationController.text.isNotEmpty&&element.companyController.text.isNotEmpty)
    {if(int.parse(element.year1Controller.text)<int.parse(element.year2Controller.text))
    exp= exp + element.year1Controller.text+"-"+ element.year2Controller.text + " " + element.occupationController.text +"&"+ element.companyController.text+ "\n"; 
    else
    {validexp=false;
    print("false");
    }
    
    }
   
   });

  var url ="https://alumniportal2001.000webhostapp.com/EditProfile.php";
if(validexp)
{        setState(() {
           isLoading=true;
              });
  var response = await http.post(url,body: {
    'EnrollmentNo':User.enrollmentNo,
    'Name':name.text,
    'Password':_passwordController.text,
    'Email':User.email,
    'Phone':phone.text==""?"null":phone.text,
    'LinkedIn':linkedIn.text==""?"null":linkedIn.text,
    'Experience':exp==""?"null":exp,
    'School_10':school_10.text==""?"null":school_10.text,
    'School_Year_10':school_year_10.text==""?"null":school_year_10.text,
    'School_board_10':school_board_10==null?"null":school_board_10,
    'Marks_10':marks_10.text==""?"null":marks_10.text,
    'School_12':school_12.text==""?"null":school_12.text,
    'School_Year_12':school_year_12.text==""?"null":school_year_12.text,
    'School_board_12':school_board_12==null?"null":school_board_12,
    'Marks_12':marks_12.text==""?"null":marks_12.text,
    'Image':image.toString()=="null"?"null":image,
    'Grad_college':grad_college.text==""?"null":grad_college.text,
    'Grad_cgpa':grad_cgpa.text==""?"null":grad_cgpa.text,
    'Grad_course':grad_course.text==""?"null":grad_course.text,
    'Grad_batch':grad_batch.text==""?"null":grad_batch.text,    
    'Post_grad_college':post_grad_college.text==""?"null":post_grad_college.text,
    'Post_grad_cgpa':post_grad_cgpa.text==""?"null":post_grad_cgpa.text,
    'Post_grad_course':post_grad_course.text==""?"null":post_grad_course.text,
    'Post_grad_batch':post_grad_batch.text==""?"null":post_grad_batch.text,  
    'Facebook':facebook.text==""?"null":facebook.text,
    'Instagram':instagram.text==""?"null":instagram.text,
    'Twitter':twitter.text==""?"null":twitter.text,
  });   
print("ended");
print(response.body.toString());
  if(jsonDecode(response.body).toString()=="true")
  {    Fluttertoast.showToast(msg: "Changes Saved",
    textColor: Colors.white,
    backgroundColor: Colors.green);
      setState(() {
    isLoading=false;
  });
    print("true");
    print(response.body.toString());
    User.experience=exp;
    User.image=image;
    User.password=_passwordController.text;
    User.name=name.text;
    User.phone=phone.text;

    User.linkedIn=linkedIn.text;
    User.email=email.text;
    User.facebook=facebook.text;
    User.instagram=instagram.text;
    User.twitter=twitter.text;

    User.school_10=school_10.text;
    User.marks_10=marks_10.text;
    User.school_year_10=school_year_10.text;
    User.school_board_10=school_board_10;

    User.school_12=school_12.text;
    User.marks_12=marks_12.text;
    User.school_year_12=school_year_12.text;
    User.school_board_12=school_board_12;

    User.grad_college=grad_college.text;
    User.grad_cgpa=grad_cgpa.text;
    User.grad_course=grad_course.text;
    User.grad_batch=grad_batch.text;

    User.post_grad_college=post_grad_college.text;
    User.post_grad_cgpa=post_grad_cgpa.text;
    User.post_grad_course=post_grad_course.text;
    User.post_grad_batch=post_grad_batch.text;



Navigator.pop(context);
   
  }
  else
  {
    Fluttertoast.showToast(msg: "error occured",
    textColor: Colors.white,
    backgroundColor: Colors.red);
  }
  print("not true");
  print(jsonDecode(response.body.toString()).toString());
  setState(() {
    isLoading=false;
  });
 }
 else
Fluttertoast.showToast(msg:"Add proper experience year",
backgroundColor: Colors.red,
textColor: Colors.white);
}

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:IconButton(icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.greenAccent,),
         onPressed:() {Navigator.pop(context);} ,),
        title: Text("Edit Profile",
        
        style: TextStyle(
          color: Colors.black
        ),
        /*leading: IconButton( icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,) 
        onPressed: null)*/
        ),),
      
      
        body:isLoading?Center(child:Image.asset("images/spinner.gif",scale:2)):SafeArea(
            child:ListView(
          physics: BouncingScrollPhysics(),
          children:<Widget>[
            
            SizedBox(height: 50),
               Row(mainAxisAlignment: MainAxisAlignment.center,
                 children: [ 
                Padding(
                  padding: EdgeInsets.only(left:30),
                child: CircleAvatar(
                  backgroundImage: image.toString()=="null"?AssetImage("images/noface.png"):MemoryImage(base64Decode(image)),
                  radius: 50,
                
                
                ),
                ),
               
              //  Image.memory(base64Decode(image),fit: BoxFit.cover,),
                FlatButton(
                  minWidth:0.1,
                  
                  onPressed: ((){
                    imagePicker();
                  }),
                  child:Container(
                  height: 30,
                  width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color:Colors.black26,spreadRadius:0,blurRadius:10,offset: Offset(0,10))],
                color: Colors.white
              ),
                  
                  child:Icon(Icons.edit,
                color: Colors.greenAccent,
                size: 20
                )
                ),
                )
                ],),
              SizedBox(height: 50),
              Padding(
                 padding: EdgeInsets.only(left:30,bottom: 20),
               child: Text("Personal Info",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
               ),
              TextField(
                controller: name,
                
                decoration: InputDecoration(
                    //hintText: "Your Name",

                    labelText: "Full Name",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    //border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                maxLength: 30,
              ),
              // SizedBox(
              //   height: 16,
              // ),
             
         SizedBox(
                height: 16,),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    //labelText: "Password",
                    errorText: _passwordError,
                    fillColor: Colors.white,
                    filled: true,
                    
                    //border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _secureText ? Icons.remove_red_eye : Icons.security),
                      onPressed: () {
                        setState(() {
                          _secureText = !_secureText;
                        });
                      },
                    )),
                obscureText: _secureText,
              ),
             
               SizedBox(
                height: 30,),
               Padding(
                 padding: EdgeInsets.only(left:30),
               child: Text("Experience",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
               ),
                  SizedBox(
                height: 40,),
            Padding(
              padding: EdgeInsets.only(left:20),
              child:Container(
              // height: 50,
              // width: 100,
             child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: experience.length!=0?experience.length:1,
                  itemBuilder: (context,index){
                    if(experience.length==0)
                    return SizedBox(height: 10,);
                    return experience[index];
                  },

            ),
            ),
            ),
                SizedBox(
                height: 10,),
            
              Padding(
                padding: EdgeInsets.only(left:30),
                child:Row(
              children:<Widget>[
                 Container(
               height: 50,
               width: 50,
              
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(25),
                  color: Colors.blue,
                  boxShadow: [BoxShadow(color:Colors.black26,spreadRadius:0,blurRadius:10,offset:Offset(0,8))]
               ),
                      child:Center(
                        child:FlatButton(                     
                        onPressed: ((){
                       addExperience();
                        }),
                   child: Align(alignment: Alignment(0,0),
                     child:Text("+",
                     style: TextStyle(color: Colors.white,fontSize: 25),)),
                        ),
                          ),
                 ),
              
                SizedBox(width:MediaQuery.of(context).size.width/7),
                
               

                   SizedBox(width:MediaQuery.of(context).size.width/7),

                  experience.length!=0?Container(
               height: 50,
               width: 50,
                 decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(25),
                  color: Colors.blue,
                boxShadow: [BoxShadow(color:Colors.black26,spreadRadius:0,blurRadius:10,offset:Offset(0,8))]

               ),
                      child:FlatButton(
                        onPressed: ((){
                       removeExperience();
                        }),
                   child: Align(alignment: Alignment(0,0),
                     child:Text("-",
                     style: TextStyle(color: Colors.white,fontSize: 25),)),
                        ),
                          ):
                SizedBox(),
              ]
            ),      
              ),
            
            
              
              SizedBox(
                height: 50,
              ),
              
               Padding(
                 padding: EdgeInsets.only(left:30),
               child: Text("Education",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
               ),
                  SizedBox(
                height: 20,),
               
                               
SizedBox(
                height: 16,),

      //****************************************Schooling******************************** */
              Padding(
                padding: EdgeInsets.only(left:20),
                child:Text('Schooling',
              style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),),
              ),
                SizedBox(
                height: 16,),

//****************************************10  school************************************** */
            Padding(
              padding: EdgeInsets.only(left:10,right:20),
              child: DropdownButton(hint: school_board_10==null?Text('Select 10th Board :'):Text(school_board_10), isExpanded: true , value:school_board_10 , onChanged: (newValue){
                  setState(() {
                    school_board_10 = newValue;
                  });
                },
                items: listItems.map((valueItem){
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
	 }).toList(),
                ),
            ),
               SizedBox(
                height: 16,),


       
              TextField(
               controller:school_10,
                decoration: InputDecoration(
                    labelText: "10th School Name ",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),

              TextField(
               controller:marks_10,
                decoration: InputDecoration(
                    labelText: "10th Percentage",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),         

              TextField(
               controller:school_year_10,
                decoration: InputDecoration(
                    labelText: "10th Pass Out Year",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),
              SizedBox(
                height: 16,),

//****************************************12  school************************************** */
            Padding(
              padding: EdgeInsets.only(left:10,right:20),
              child: DropdownButton(hint: school_board_12==null?Text('Select 12th Board :'):Text(school_board_12), isExpanded: true , value:school_board_12 , onChanged: (newValue){
                  setState(() {
                    school_board_12 = newValue;
                  });
                },
                items: listItems.map((valueItem){
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
	 }).toList(),
                ),
            ),
               SizedBox(
                height: 16,),


       
              TextField(
               controller:school_12,
                decoration: InputDecoration(
                    labelText: "12th School Name ",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),
              
               TextField(
               controller:marks_12,
                decoration: InputDecoration(
                    labelText: "12th Percentage",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),

               TextField(
               controller:school_year_12,
                decoration: InputDecoration(
                    labelText: "12th Pass Out Year",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),
              SizedBox(
                height: 16,),
                Padding(
                padding: EdgeInsets.only(left:20),
                child:Text('Graduation',
              style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),),
              ),
            SizedBox(
                height: 16,),


                TextField(
               controller:grad_course,
                decoration: InputDecoration(
                    labelText: "Course",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),

TextField(
               controller:grad_college,
                decoration: InputDecoration(
                    labelText: "Name of College",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ), 

              TextField(
               controller:grad_cgpa,
                decoration: InputDecoration(
                    labelText: "CGPA",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),

TextField(
               controller:grad_batch,
                decoration: InputDecoration(
                    labelText: "Pass Out Year",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),

            Padding(
                padding: EdgeInsets.only(left:20,top: 20),
                child:Text('Post Graduation',
              style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),),
              ),
SizedBox(
                height: 16,),


                TextField(
               controller:post_grad_course,
                decoration: InputDecoration(
                    labelText: "Course",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),

TextField(
               controller:post_grad_college,
                decoration: InputDecoration(
                    labelText: "Name of College",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ), 

              TextField(
               controller:post_grad_cgpa,
                decoration: InputDecoration(
                    labelText: "CGPA",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),

TextField(
               controller:post_grad_batch,
                decoration: InputDecoration(
                    labelText: "Pass Out Year",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),


                   SizedBox(
                height: 20,),
                Padding(
                 padding: EdgeInsets.only(left:30),
               child: Text("Contact",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
               ),
                  SizedBox(
                height: 20,),
           
             TextField(
               controller: email,
                decoration: InputDecoration(
                    //hintText: "Your Name",
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    //border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),
         TextField(
               controller: phone,
               keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    //hintText: "Your Name",
                    labelText: "Phone",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    //border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),
                  TextField(
               controller: linkedIn,
                decoration: InputDecoration(
                    //hintText: "Your Name",
                    labelText: "LinkedIn",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    //border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),
              TextField(
               controller: facebook,
                decoration: InputDecoration(
                    //hintText: "Your Name",
                    labelText: "Facebook",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    //border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),
            TextField(
               controller:instagram,
                decoration: InputDecoration(
                    //hintText: "Your Name",
                    labelText: "Instagram",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    //border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),
            TextField(
               controller: twitter,
                decoration: InputDecoration(
                    //hintText: "Your Name",
                    labelText: "Twitter",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black45),
                    //border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true),
                obscureText: false,
                
              ),
         SizedBox(
                height: 16,),
             



              Padding(padding: EdgeInsets.all(20),
             child: Row( 
               children:[
                         

                            SizedBox(width: 30),

                            Container(
                                
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.greenAccent
                                ),
                                child: SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: FlatButton(onPressed: () async{
                                    Future<bool> validUrl=Future<bool>.value(true);

                                    if(linkedIn.text!="")
                                    {
                                      validUrl=checkUrl(linkedIn.text);
                                    }
                                    if(facebook.text!="")
                                    {
                                      validUrl=checkUrl(facebook.text);
                                    }
                                    if(instagram.text!="")
                                    {
                                      validUrl=checkUrl(instagram.text);
                                    }
                                    if(twitter.text!="")
                                    {
                                      validUrl=checkUrl(twitter.text);
                                    }
                                  if(await validUrl)
                                    saveChanges();
                                    else
                                  Fluttertoast.showToast(msg:"Invalid Url in Contact");
                                  }, 
                                  child: isLoading?Image.asset("images/loading.gif"):Text("SAVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                                ),),
                              ),
                           
        ],
               ),)
           
       
          ],
        ),
        
        ),
   );
  }
}










//********************************Experience******************************************************* */
 class Experience extends StatelessWidget{
  TextEditingController occupationController =new TextEditingController();
  TextEditingController yearController =new TextEditingController();
  TextEditingController companyController =new TextEditingController();
  TextEditingController year1Controller =new TextEditingController();
  TextEditingController year2Controller =new TextEditingController();


  Experience(String year1,String year2,String occupation,String company){
    this.occupationController.text=occupation;
    this.year1Controller.text=year1;
        this.year2Controller.text=year2;
            this.companyController.text=company;


  }

  @override 
  Widget build(BuildContext context){
     return Padding(
       padding: EdgeInsets.only(bottom:20),
       child:Container(
      child: Row(
   children:<Widget> [
     Padding(
       padding:EdgeInsets.only(right:5),
       child:Container(
width: MediaQuery.of(context).size.width/6,
   child:TextField(
     controller: year1Controller,
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
    
    Text("to"),
    

     Padding(
       padding:EdgeInsets.only(right:5,left:5),
       child:Container(
width: MediaQuery.of(context).size.width/6,
   child:TextField(
     controller: year2Controller,
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
    
  Column(
    children:<Widget>[
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
    SizedBox(height:20 ,),
    Container(
      width: MediaQuery.of(context).size.width/2,
      child: TextField(controller: companyController,
                 style: TextStyle(fontSize: 15),

                decoration:InputDecoration(
            filled:true,
            labelText: "Company",
          
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
    ]
      ),

   ],
       ),
       ),
  );
  }
}
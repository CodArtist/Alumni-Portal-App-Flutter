import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'LoadingSplash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';



class reg extends StatefulWidget {
  @override
  _regState createState() => _regState();
}

class _regState extends State<reg> {

   TextEditingController emailc,namec,passc,confirmpassc,passOutYear,enrollmentNo;
   var isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState(

    );
    emailc=new TextEditingController();
    namec=new TextEditingController();
    passc=new TextEditingController();
    // branch=new TextEditingController();
    passOutYear=new TextEditingController();
    enrollmentNo=new TextEditingController();
    confirmpassc=new TextEditingController();

  }
  
  String college;
String course;

  List colleges=[
    "ITM UNIVERSITY GWALIOR","ITM GOI"
  ];

  List goiCourses=[
    "B.Tech Computer Science",
    "B.Tech Civil Engineering",
    "B.Tech Mechanical Engineering"
    "B.Tech Electronics Engineering",
    "B.Tech Information Technology",
    "B.Tech Chemical Engineering",
    "Diploma in Computer Science",
    "Diploama in Civil Engineering",
    "Diploama in Mechanical Engineering"
    "Diploma in Electronics Engineering",
    "Diploma in Information Technology",
    "Diploma in Chemical Engineering",
    "MBA (Master of Business Administration)",
    "MCA (Master of Computer Applications)"

  ];

  List courses=["Please Select Your College"];

  List itmcourses=[
    "Agriculture",
    "B. Architecture (B.Architecture)",
    "B.A. (Journalism & Mass Comm.)",
    "B.A. B.Ed",
    "B.A.LL.B(Hons.)",
    "B.Com and MBA Int.",
    "B.Com Hons (CA/CS/CMA)",
    "B.Com(H) & MBA Int. (B.Com(H) and MBA Int.)",
    "B.Com.LL.B.(Hons.)",
    "B.Ed. (B.Ed.)",
    "B.Lib. I.Sc.",
    "B.Optometry (B.Optometry)",
    "B.Pharm. (B.Pharmacy)",
    "B.Sc Agriculture (Horticulture)",
    "B.Sc Design (Fashion Design & Modelling)",
    "B.Sc Design (Interior Design)",
    "B.Sc. (Biomedical Science)",
    "B.Sc. Food Technology(Spec. in Post Harvest Technology & Food Processing)",
    "B.Sc. Hons (Food Tech)",
    "B.Sc. Hons Biotechnology (Biotechnology)",
    "B.Sc. Hons Microbiology (Microbiology)",
    "B.Sc. Nursing Hons (Nursing BSc)",
    "B.Sc. PCM (B.Sc. PCM)",
    "B.Sc.(CS) (B.Sc.(CS))",
    "B.Tech (Agricultural Engineering)",
    "B.Tech and MBA Inte. (Civil Engineering)",
    "B.Tech and MBA Inte. (Computer Science and Engineering)",
    "B.Tech and MBA Inte. (Electronics and Communication Engineering.)",
    "B.Tech and MBA Inte. (Mechanical Engineering)",
    "B.Tech CSE (Cloud Computing)",
    "B.Tech CSE (Cyber Forensics)",
    "B.Tech CSE (Data Science and Machine Learning)",
    "B.Tech. (Automobile Engineering)",
    "B.Tech. (Biotechnology)",
    "B.Tech. (Civil Engineering)",
    "B.Tech. (Computer Science and Engineering)",
    "B.Tech. (Electrical Engineering)",
    "B.Tech. (Electronics and Communication Engineering)",
    "B.Tech. (Information and Communication Technology)",
    "B.Tech. (Mechanical Engineering)",
    "B.Tech. (Petrolium Technology)",
    "B.Tech. Agriculture(Spec. in Post Harvest Technology & Food Processing)",
    "B.Tech. and M.Tech. (INT) (Civil Engineering)",
    "B.Tech. and M.Tech. (INT) (Computer Science & Engineering)",
    "B.Tech. and M.Tech. (INT) (Electronics and Communication Engineering)",
    "B.Tech. and M.Tech. (INT) (Mechanical Engineering)",
    "Bachelor in Physiotherapy (BPT)",
    "Bachelor of Business Administration (BBA)",
    "Bachelor of Commerce (B.COM)",
    "Bachelore of Commerce Hons. (Bachelor of Commerce Hons)",
    "BBA (Honours) Financial Markets jointly offered with NSE",
    "BBA (Hons) (Bachelor of Business Administration Hons)",
    "BBA and MBA Int.",
    "BBA Hons MBA Int.",
    "BCA (BCA)",
    "BCA Hons. (BCA Hons.)",
    "BCA(CEP)",
    "BSc AG Credit Transfer 2nd Year",
    "BSc AG Credit Transfer 3rd Year",
    "BSC Honours (Horticulture)",
    "Certificate in Operation Theatre Technician ",
    "D.Pharm. (D.Pharmacy)",
    "Diploma (Fashion Design)",
    "Diploma (Interior Design)",
    "Diploma in Anesthesia Technician",
    "Diploma in Optometrist Refractions ",
    "LLB",
    "L.L.M.",   
    "LLM - Constitutional Law",
    "LLM - Criminal Law",
    "M. Sc. Nursing (Child Health (Paediatric) Nursing)",
    "M. Sc. Nursing (Psychiatric (Mental Health) Nursing)",
    "M.Des. (Fashion Design)",
    "M.Des. (Interior Design)",
    "M.Lib. I.Sc.",
    "M.Pharm. (M.Pharmacy)",
    "M.Sc Mathematics",
    "M.Sc. (Environmental Science)",
    "M.Sc. Agriculture (Agro/Horti/GPB/Soil Sci./Plant Patho) ",
    "M.Sc. Biotechnology (Biotech)",
    "M.Sc. Chemistry",
    "M.Sc. Microbiology (Microbiology)",
    "M.Sc. Nursing (Community Health Nursing)",
    "M.Sc. Nursing (Medical Surgical Nursing)",
    "M.Sc. Nursing (Obstetrics & Gynaecology Nursing)",
    "M.Sc. Petroleum Tech. (Petro)",
    "M.Sc. Physics",
    "M.Tech",
    "M.Tech. (Communication System)",
    "M.Tech. (Computer Science & Engineering)",
    "M.Tech. (Construction Technology & Management )",
    "M.Tech. (Geotechnical Engineering)",
    "M.Tech. (Machine Design)",
    "M.Tech. (Production & Ind)",
    "M.Tech. (Structural Engineering)",
    "M.Tech. (Thermal Engineering)",
    "M.Tech. (VLSI Design)",
    "MBA (DUAL)",
    "MBA (Financial Markets) jointly offered with NSE",
    "MBA (Hospital Management)",
    "MBA (Supply Chain and Logistics Mgmt)",
    "MBA-Agribusiness (MBA-Agribusiness)",
    "MCA (Lateral Entry)",
    "MCA (MCA)",
    "MSc. Food Technology (Food)",
    "PG Diploma in Journalism",
    "Ph.D (Agriculture)",
    "Ph.D (Chemistry)",
    "Ph.D (Civil)",
    "Ph.D (Computer Science and App)",
    "Ph.D (Enviornment Science)",
    "Ph.D (Horticulture)",
    "Ph.D (Management)",
    "Ph.D (Mathematics)",
    "Ph.D (Mechanical)",
    "Ph.D (Physics)",
    "Ph.D(Electronics and Communication)",
    "Ph.D. (Pharmacy)",
    "Ph.D. Biotechnology",
    "Ph.D. Microbiology",
    "Post Basic B.Sc (Nursing Yearly)"];

   Future<List> register() async {
     setState(() {
       isLoading=true;
     });
     var post_grad_course;
     var post_grad_college;
     var post_grad_batch;
     var grad_college;
     var grad_course;
     var grad_batch;

      if(college=="ITM UNIVERSITY GWALIOR")
     { 
       if(itmcourses.indexOf(course)>66)
      {post_grad_course=course;
      post_grad_college=college;
      post_grad_batch=passOutYear.text;
      }
      else
      {grad_course=course;
      grad_college=college;
      grad_batch=passOutYear.text;

      }

      
     }
       if(college=="ITM GOI")
      {
      if(goiCourses.indexOf(course)>11)
      {post_grad_course=course;
      post_grad_college=college;
      post_grad_batch=passOutYear.text;
      }
      else
      {grad_course=course;
      grad_college=college;
      grad_batch=passOutYear.text;

      }
      
      }
    
     final response = await http.post(
         "https://alumniportal2001.000webhostapp.com/Register.php", body: {
       "Name": namec.text,
       "Email": emailc.text,
       "Password": passc.text,
       "EnrollmentNo":enrollmentNo.text,
       "Post_grad_college":post_grad_college==null?"null":post_grad_college,
       "Post_grad_course":post_grad_course==null?"null":post_grad_course,
       "Post_grad_batch":post_grad_batch==null?"null":post_grad_batch,
       "Grad_college":grad_college==null?"null":grad_college,
       "Grad_course":grad_course==null?"null":grad_course,
       "Grad_batch":grad_batch==null?"null":grad_batch,

     });
print((response.body).toString());

    if(response.body=="Email already exists")
    {
      Fluttertoast.showToast(
      msg:"Email already exists",
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM
    );
      setState(() {
        isLoading=false;
        namec.text="";
        emailc.text="";
        passc.text="";
        
      });
    }
        if(jsonDecode(response.body).toString()=="true")
    {Fluttertoast.showToast(
      msg:"Registered Successfully!!",
      backgroundColor: Colors.greenAccent[700],
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM
    );
    Fluttertoast.showToast(
      msg:"Wait for Confirmation mail",
      backgroundColor: Colors.greenAccent[700],
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
      setState(() {
        isLoading=false;
        namec.text="";
        emailc.text="";
        passc.text="";
        // branch.text="";
        enrollmentNo.text="";
        passOutYear.text="";

      });
    }
    if(jsonDecode(response.body).toString()=="false")
    {
    Fluttertoast.showToast(
      msg:"An Error Occured",
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
      setState(() {
        isLoading=false;
        namec.text="";
        emailc.text="";
        passc.text="";
        // branch.text="";
        enrollmentNo.text="";
        passOutYear.text="";
        
      });
    }
    
    print("ssss");
    print(response.body);
    // print(jsonDecode(response.body).toString());
    //  var datauser = json.decode(response.body);

    //  if(jsonDecode(datauser.body)=="account already exists"){
    //    Fluttertoast.showToast(msg: "exists",toastLength: Toast.LENGTH_SHORT);
    //  }else{
    //    if(jsonDecode(datauser.body)=="success"){
    //      Fluttertoast.showToast(msg: "Account Created successfully: Redirecting to login screen",toastLength: Toast.LENGTH_SHORT);
    //    }else{
    //      Fluttertoast.showToast(msg: "failure",toastLength: Toast.LENGTH_SHORT);
    //    }
    //  }


   }


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return isLoading?LoadingSplash():Scaffold(

      body:Stack(
        children: <Widget>[

          ClipPath(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 2*(size.width*0.12)+4*(size.height*0.07)+2*(size.height*0.05)+8*10+(size.height*0.1)/1.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/itmnight.jpg"),

                  fit: BoxFit.fill,
                ),
              ),
            ),
            clipper: CustomClipPath(),
          ),










          SingleChildScrollView(

            child: Center(

              child: Column(

                children: <Widget>[

                  SizedBox(
                    height: size.height*0.05,
                  ),

               Padding(
                padding: EdgeInsets.only(top:0),
              child:Container(
                height:80,
                width: 80,
                decoration:BoxDecoration(
                  image: DecorationImage(image:AssetImage("images/logo.jpeg")),
                  borderRadius: BorderRadius.circular(200),
                  // boxShadow: [BoxShadow(blurRadius:10,offset: Offset(5,10),color: Colors.grey)],
                  border:Border.all(color:Colors.blue,width:2),
                ),
              ),
              ),





                  SizedBox(
                    height: size.height*0.05,
                  ),

Container(
  height:MediaQuery.of(context).size.height/2,
  width: MediaQuery.of(context).size.width/1.2,
child:ListView(
children:<Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: size.height*0.07,
                      width: size.width*0.8,

                      decoration: BoxDecoration(
                        color:Colors.white.withOpacity(.9),
                        boxShadow: [BoxShadow(blurRadius:10,offset: Offset(0,5),color: Colors.black45)],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: TextField(
                          controller: namec,
                          decoration: InputDecoration(
                            border:InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: Icon(Icons.account_circle_rounded,
                                size: 28,
                              ),
                            ),
                            hintText: "Name",


                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: size.height*0.07,
                      width: size.width*0.8,
                      decoration: BoxDecoration(
                        color:Colors.white.withOpacity(.9),
                        boxShadow: [BoxShadow(blurRadius:10,offset: Offset(0,5),color: Colors.black45)],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: TextField(
                          controller: emailc,
                          decoration: InputDecoration(


                            border:InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: Icon(Icons.email,
                                size: 28,
                              ),
                            ),
                            hintText: "Email",


                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                  ),

                 
                  

                  //                   Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                  //   child: Container(
                  //     height: size.height*0.07,
                  //     width: size.width*0.8,
                  //     decoration: BoxDecoration(
                  //       color:Colors.white.withOpacity(.9),
                  //       boxShadow: [BoxShadow(blurRadius:10,offset: Offset(0,5),color: Colors.black45)],

                  //       borderRadius: BorderRadius.circular(16),
                  //     ),
                  //     child: Center(
                  //       child: TextField(
                  //         controller: branch,
                  //         decoration: InputDecoration(
                  //           border:InputBorder.none,
                  //           prefixIcon: Padding(
                  //             padding: const EdgeInsets.symmetric(horizontal:20.0),
                  //             child: Icon(Icons.work,
                  //               size: 28,
                  //             ),
                  //           ),
                  //           hintText: "Branch",


                  //         ),
                  //         textInputAction: TextInputAction.next,
              
                  //       ),
                  //     ),
                  //   ),
                  // ),

                                      Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: size.height*0.07,
                      width: size.width*0.8,
                      decoration: BoxDecoration(
                        color:Colors.white.withOpacity(.9),
                        boxShadow: [BoxShadow(blurRadius:10,offset: Offset(0,5),color: Colors.black45)],

                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                     child: Padding(
                               padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(                               
                                  isExpanded: true,
                                  underline: SizedBox(),
                                 icon: Padding(
                                   padding: const EdgeInsets.symmetric(horizontal:8.0),
                                   child: Padding(
                                     padding: const EdgeInsets.symmetric(horizontal:8.0),
                                     child: Icon(Icons.school),
                                   ),
                                 ),
                                  hint: Padding(padding:EdgeInsets.only(left:30),
                                  child:Text("College",overflow: TextOverflow.ellipsis)),
                                  value:college,
                                  onChanged: (newValue){
                                    if(course==null)
                                    setState(() {
                                      college=newValue;
                                      if(college=="ITM GOI")
                                      courses=goiCourses;

                                      if(college=="ITM UNIVERSITY GWALIOR")
                                        courses=itmcourses;
                                    });
                                  },
                                  items: colleges.map((valueItem){
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child:Padding(padding:EdgeInsets.only(left:30),
                                  child:Text(valueItem,overflow: TextOverflow.ellipsis)),
                                    );
                                  }).toList(),

                                ),
                              ),
                      ),
                    ),
                  ),               
                    
                    
                                                        Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: size.height*0.07,
                      width: size.width*0.8,
                      decoration: BoxDecoration(
                        color:Colors.white.withOpacity(.9),
                        boxShadow: [BoxShadow(blurRadius:10,offset: Offset(0,5),color: Colors.black45)],

                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                       child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  icon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                                      child: Icon(Icons.book),
                                    ),
                                  ),
                                  hint: Padding(padding:EdgeInsets.only(left:30),
                                  child:Text("Select Course",overflow: TextOverflow.ellipsis)),
                                  value:course,
                                  
                                  onChanged: (newValue){
                                    if(college!=null)
                                   {

                                     setState(() {
                                      course=newValue;
                                    });
                                   
                                   }
                                  },
                                  items: courses.map((valueItem){
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Padding(padding:EdgeInsets.only(left:30),
                                  child:Text(valueItem,overflow: TextOverflow.ellipsis)),
                                    );
                                  }).toList(),

                                ),
                              ),
                      ),
                    ),
                  ),
                  
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: size.height*0.07,
                      width: size.width*0.8,
                      decoration: BoxDecoration(
                        color:Colors.white.withOpacity(.9),
                        boxShadow: [BoxShadow(blurRadius:10,offset: Offset(0,5),color: Colors.black45)],

                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: TextField(
                          controller: passOutYear,
                          decoration: InputDecoration(
                            border:InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: Icon(Icons.lock_clock,
                                size: 28,
                              ),
                            ),
                            hintText: "Pass out year",


                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
              
                        ),
                      ),
                    ),
                  ),   
                    
                                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: size.height*0.07,
                      width: size.width*0.8,
                      decoration: BoxDecoration(
                        color:Colors.white.withOpacity(.9),
                        boxShadow: [BoxShadow(blurRadius:10,offset: Offset(0,5),color: Colors.black45)],

                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: TextField(
                          controller: enrollmentNo,
                          decoration: InputDecoration(
                            border:InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: Icon(Icons.vpn_key,
                                size: 28,
                              ),
                            ),
                            hintText: "Enrollment no.",


                          ),
                          textInputAction: TextInputAction.next,
              
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: size.height*0.07,
                      width: size.width*0.8,
                      decoration: BoxDecoration(
                        color:Colors.white.withOpacity(.9),
                        boxShadow: [BoxShadow(blurRadius:10,offset: Offset(0,5),color: Colors.black45)],

                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: TextField(
                          controller: passc,
                          decoration: InputDecoration(
                            border:InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: Icon(Icons.lock,
                                size: 28,
                              ),
                            ),
                            hintText: "Password",


                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                        ),
                      ),
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: size.height*0.07,
                      width: size.width*0.8,
                      decoration: BoxDecoration(
                        color:Colors.white.withOpacity(.9),
                        boxShadow: [BoxShadow(blurRadius:10,offset: Offset(0,5),color: Colors.black45)],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: TextField(
                          controller: confirmpassc,
                          decoration: InputDecoration(
                            border:InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: Icon(Icons.lock,
                                size: 28,
                              ),
                            ),
                            hintText: "Confirm Password",


                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height*0.1,
                  ),
               
                ]
              ),
),
                SizedBox(height: 30,),
                Container(
                  height: size.height*0.06,
                  width: size.width*0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [BoxShadow(blurRadius:10,offset: Offset(0,5),color: Colors.grey)],

                    color:Colors.blue,
                  ),
                  child: FlatButton(
                    onPressed: ()async{
                      var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                 if(namec.text.isNotEmpty&&passc.text.isNotEmpty&&emailc.text.isNotEmpty&&confirmpassc.text.isNotEmpty&&passOutYear.text.isNotEmpty&&enrollmentNo.text.isNotEmpty&&course!=null&&college!=null)
                                   {if(confirmpassc.text==passc.text)
                                     {bool hasUppercase = passc.text.contains(new RegExp(r'[A-Z]'));
                                    bool hasDigits = passc.text.contains(new RegExp(r'[0-9]'));
                                bool hasLowercase = passc.text.contains(new RegExp(r'[a-z]'));
                             bool hasSpecialCharacters = passc.text.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                               bool hasMinLength = passc.text.length > 8;
                                   if(hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & hasMinLength)
                                   
                                  if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailc.text))
                                   register();
                                   else
                                     Fluttertoast.showToast(msg: "Invalid Email",
                                   textColor: Colors.white,
                                   backgroundColor: Colors.red,
                                   );

                                   else

                                   Fluttertoast.showToast(msg: "Password must contain special character\n and length must be 8 or more",
                                   textColor: Colors.white,
                                   backgroundColor: Colors.red,
                                   );
                                     
                                     }
                                   
                                   else
                                   {Fluttertoast.showToast(msg: "Password didn't matched",
                                   textColor: Colors.white,
                                   backgroundColor: Colors.red,
                                   );
                                   }
                                   }
                                  else
                                  {
                                    Fluttertoast.showToast(msg: "All Fields are Required",
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red,
                      );
                                  }
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }
                      

                    },
                    child: Text('Create Account',
                      style: TextStyle(color:Colors.white),
                    ),
                  ),
                ),

                  SizedBox(
                    height: size.height*0.01,
                  ),
                  Text('Terms & Condition ',style: TextStyle(color:Colors.black),),

                  SizedBox(
                    height:10,
                  ),
                

                  FlatButton(
                    onPressed: ((){
                      Navigator.pop(context);
                    }),
                    child:Text('Already Have Account ? Login Here',style: TextStyle(color:Colors.black),),
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

class CustomClipPath extends CustomClipper<Path> {
  var radius=10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width/4, size.height
        - 40, size.width/2, size.height-20);
    path.quadraticBezierTo(3/4*size.width, size.height,
        size.width, size.height-30);
    path.lineTo(size.width, 0);

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


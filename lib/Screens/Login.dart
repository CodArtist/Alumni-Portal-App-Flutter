import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'LoadingSplash.dart';
import 'Dashboard.dart';
import 'Register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';
import '../User.dart';
import 'adminPanel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey=GlobalKey<FormState>();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  var isLoading=false;
  FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
  String token1;
 DateTime current;
  Future<bool> popped(){
    DateTime now=DateTime.now();
    if(current==null||now.difference(current)>Duration(seconds:2))
    {
      current=now;
      Fluttertoast.showToast(msg:"Press Again to exit");
      return Future<bool>.value(false);
    }
    else
    {
      return Future<bool>.value(true);
    }
  }
  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
  
  }

  void firebaseCloudMessaging_Listeners() {
    //get token of mobile device
    _firebaseMessaging.getToken().then((token){
     print("token is"+ token);
     setState(() {
       token1=token;
     });
    });
  }

 Future getQue() async {

    if(token1!=null){
      //call php file
    }
    else{
      print("Token is null");
    }
  }


void validator()
{
  if(formkey.currentState.validate())
  {
    setState(() {
    isLoading=true;
  });
    handleLogin();

  }
  
}


void handleLogin() async
{print("helooooooooooo");
  var urlemail=email.text;
var urlpassword=password.text;
  var url ="https://alumniportal2001.000webhostapp.com/Login.php";
  var response = await http.post(url,body: {
    'Email':urlemail,
    'Password':urlpassword,
  });
  print(response.body.toString());
  if(response.body.toString()!="Not Found")
  { User.name=jsonDecode(response.body)[0]["Name"].toString();
    User.email=jsonDecode(response.body)[0]["Email"].toString();
    User.password=jsonDecode(response.body)[0]["Password"].toString();
    User.enrollmentNo=jsonDecode(response.body)[0]["enrollmentNo"].toString();
    User.experience=jsonDecode(response.body)[0]["experience"].toString();
    User.phone=jsonDecode(response.body)[0]["phone"].toString();
    User.linkedIn=jsonDecode(response.body)[0]["linkedIn"].toString();
    User.image=jsonDecode(response.body)[0]["image"].toString();

    User.facebook=jsonDecode(response.body)[0]["facebook"].toString();
    User.instagram=jsonDecode(response.body)[0]["instagram"].toString();
    User.twitter=jsonDecode(response.body)[0]["twitter"].toString();
    

    User.school_10=jsonDecode(response.body)[0]["school_10"].toString();
    User.marks_10=jsonDecode(response.body)[0]["10_Marks"].toString();
    User.school_year_10=jsonDecode(response.body)[0]["school_year_10"].toString();
    User.school_board_10=jsonDecode(response.body)[0]["school_board_10"].toString();

    User.school_12=jsonDecode(response.body)[0]["school_12"].toString();
    User.marks_12=jsonDecode(response.body)[0]["12_Marks"].toString();
    User.school_year_12=jsonDecode(response.body)[0]["school_year_12"].toString();
    User.school_board_12=jsonDecode(response.body)[0]["school_board_12"].toString();

    User.grad_college=jsonDecode(response.body)[0]["grad_college"].toString();
    User.grad_cgpa=jsonDecode(response.body)[0]["grad_cgpa"].toString();
    User.grad_course=jsonDecode(response.body)[0]["grad_course"].toString();
    User.grad_batch=jsonDecode(response.body)[0]["grad_batch"].toString();

    User.post_grad_college=jsonDecode(response.body)[0]["post_grad_college"].toString();
    User.post_grad_cgpa=jsonDecode(response.body)[0]["post_grad_cgpa"].toString();
    User.post_grad_course=jsonDecode(response.body)[0]["post_grad_course"].toString();
    User.post_grad_batch=jsonDecode(response.body)[0]["post_grad_batch"].toString();
    
    if(jsonDecode(response.body)[0]["Name"].toString()=="Admin"&&jsonDecode(response.body)[0]["Password"].toString()=="Admin*123")
    {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>AdminPanel(token1)),
    );
    }
    else
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => WillPopScope(
                onWillPop:()=> popped(),

      child:Dashboard(jsonDecode(response.body)[0]["Name"].toString())),
    )
  );
 setState((){
      isLoading=false;
       email.text="";
      password.text="";
    });
  }
   else
  { Fluttertoast.showToast(msg: "Invalid Email or Password",
   textColor: Colors.white,
   backgroundColor: Colors.red,
  );
  }
  setState((){
      isLoading=false;
      email.text="";
      password.text="";
 
    });
 print(response.body.toString());
  // print(jsonDecode(response.body)[0]['Name']);
}
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:isLoading?LoadingSplash():Column(
        children:<Widget>[
          Container(
            height:MediaQuery.of(context).size.height/1.6,
            width:MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login-bg.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(300),bottomRight:Radius.circular(300)),
          boxShadow: [BoxShadow(blurRadius: 30,offset: Offset(0,10),color: Colors.grey)]
        ),
        child: Center(
          child:Column(
            children:<Widget> [

              //***********Logo*********************** */
              Padding(
                padding: EdgeInsets.only(top:50),
              child:Container(
                height:80,
                width: 80,
                decoration:BoxDecoration(
                  image: DecorationImage(image:AssetImage("images/logo.jpeg")),
                  borderRadius: BorderRadius.circular(200),
                  boxShadow: [BoxShadow(blurRadius:10,offset: Offset(5,10),color: Colors.grey)],
                  border:Border.all(color:Colors.blue),
                ),
              ),
              ),

              //**************TextFields*************** */
              Center(
                child:Form(
                  key:formkey,
                  child: Column(
                    children:<Widget>[

                       //**************Email Address*************** */
                      Padding(
                        padding: EdgeInsets.only(top:60),
                      child:Container(
                        width: MediaQuery.of(context).size.width/1.2,
                        height: 50,
                        
                        decoration: BoxDecoration(
                        boxShadow: [BoxShadow(blurRadius:10,offset: Offset(5,10),color: Colors.black38)],
                        color: Colors.white,
                        ),
                      child:TextFormField(
                        controller: email,
                        decoration:InputDecoration(
                          prefixIcon: new Padding(
                        padding: const EdgeInsets.only( top: 15, left: 5, right: 0, bottom: 15),
                          child: new SizedBox(
                                height: 4,
                                 child: Image.asset("images/Emailicon.png"),
                              ),
                           ),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        labelText:"E-mail Address"),
                        validator: (value){
                          if(value.isEmpty)
                          return "Enter Email";
                          else
                          return null;
                        },
                      ),
                      ),
                      ),
                
                 //**************Password*************** */
                    Padding(
                      padding: EdgeInsets.only(top:50),
                      child:Container(
                        width: MediaQuery.of(context).size.width/1.2,
                        height: 50,
                        decoration: BoxDecoration(
                        boxShadow: [BoxShadow(blurRadius:10,offset: Offset(5,10),color: Colors.black38)],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        ),
                      child:TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration:InputDecoration(
                          
                         prefixIcon: new Padding(
                        padding: const EdgeInsets.only( top: 15, left: 5, right: 0, bottom: 15),
                          child: new SizedBox(
                                height: 4,
                                 child: Image.asset("images/Passwordicon.png"),
                              ),
                           ),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        labelText:"Password"),
                        validator: (value){
                          if(value.isEmpty)
                          return "Enter Password";
                          else
                          return null;
                        },
                      ),
                      ),
                      ),
                
                
                
                
                
                
                
                  ],
                  ),

                )
              ),


            

          ],
          ),
        ),
      ),
      
        
        //****************BottomContainer***************** */
            Expanded(
              child:Container(
                
                decoration: BoxDecoration(
                   image: DecorationImage(
            image: AssetImage("images/bottomDesign.png"),
            fit: BoxFit.cover,
          ),
                ),


            
               child:Center(
                 child:Column(
                   children:<Widget>[

                     //*****************LoginButton**************************** */
                    Padding(
                      padding: EdgeInsets.only(top:30),
                      child:Container(
                      width:MediaQuery.of(context).size.width/1.5,
                      decoration: BoxDecoration(
                        color: Color(0XFF054AFC),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [BoxShadow(blurRadius:10,offset: Offset(5,10),color: Colors.grey)],

                      ),
                      child:FlatButton(
                        onPressed:()async{ 
                           var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                 validator();
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }
                          
                          },
                      minWidth: 50,
                      highlightColor: Colors.blue,
                   
                   child:Center(child: Text("Login",
                   style:TextStyle(
                     color:Colors.white,
                     fontWeight: FontWeight.bold,
                     fontSize:20,
                   )),)
                 ),
                    ),
                    ),
                    

                    //************ForgetPassword********************* */

                   Padding(
                     padding: EdgeInsets.only(top:5),
                     child: Container(
                       child:FlatButton(
                         child:Text("Forgot Your Password?",
                         style: TextStyle(color:Color(0XFF0081F9)),
                         ),
                         ),
                         ),
                     ),

                   //************Register********************* */

                   Padding(
                     padding: EdgeInsets.only(top:0,left:65),
                     child: Container(
                       child:Row(
                         children:<Widget>[
                          // Text("Don't have an acoount?",
                          // style: TextStyle(color:Colors.grey),),
                        
                            
                          FlatButton(
                          onPressed:((){
                          Navigator.of(context).push(
   PageRouteBuilder(
    pageBuilder: (
        BuildContext context, 
        Animation<double> animation, 
        Animation<double> secondaryAnimation) {
      return reg();
    },
    transitionsBuilder: (
        BuildContext context, 
        Animation<double> animation, 
        Animation<double> secondaryAnimation, 
        Widget child) {
     var begin = Offset(1.0,0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds:500),
  ),
);
                          }),
                         child:Text("Don't have an account? Register",
                         style: TextStyle(color:Colors.black),
                         ),
                         ),
                           

                         ],
                         ),
                     ),
                   ),
                   


//                 
                   
                  
                   ],
                 
                 ),
               ),
                  
              ),
                   
            ),
        
        
        
        
        
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoadingSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/Splash Background1.png"),
                  fit: BoxFit.cover)),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Padding(
                padding: EdgeInsets.only(top:150),
              child:Center(
                child: CircleAvatar(
                  radius:53,
                  backgroundColor: Color(0xFF039BE5),
                  
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/logo.jpeg"),
                    radius: 50.0,
                  ),
                ),
              ),
              ),
                
                  Padding(padding: EdgeInsets.only(top:200),
                  child:Image.asset("images/loading.gif",width:80,height:80)
                 
                  ),
               
            ],
          ),
        ),
      ),
    ));
  }
}

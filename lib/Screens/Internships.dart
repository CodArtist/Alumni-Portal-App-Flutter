import 'dart:convert';

import 'package:AlumniPortal/Widgets/Internships/InternshipDetails.dart';
import 'package:flutter/material.dart';
import '../Widgets/Dashboard/drawer.dart';
import '../Widgets/Internships/InternshipsCard.dart';
import '../Widgets/Internships/InternshipUpload.dart';
import '../Widgets/Internships/InternshipDetails.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';


class Internships extends StatefulWidget {
  var name;
  Internships(var name)
  {
    this.name=name;
  }
  @override
  _Internships createState() => _Internships();
}

class _Internships extends State<Internships> {



final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

   var _width=250.0;
    var _height=50.0;
    var _isFilterExpanded=false;
    String dropdownValueCategory = 'Jobs';
    String dropdownValueBranch;
    String dropdownValueTime = '1-5 months';
  var internshipList=[];
  var filteredList=[];
  var userList=[];
  var listIsLoading=true;
  var branches=[    "Agriculture",
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
  @override
void initState() {
    super.initState();
    loadInternships();
}
loadInternships()async{
String url="https://alumniportal2001.000webhostapp.com/GetInternships.php";
final response=await http.get(url);
print("bhjkgkjgbkj");

if(response.body.toString()!="Not Found")
{setState(() {
  internshipList=jsonDecode(response.body)[0];
  userList=jsonDecode(response.body)[1];
  filteredList=internshipList;
  listIsLoading=false;
});
}
setState(() {

  listIsLoading=false;
});
print(internshipList);
print(userList);
}


filterList()
{var filteredlist=[];

  for(var i=0; i<internshipList.length;i++)
  {
   if(internshipList[i]['branch']==branches.indexOf(dropdownValueBranch).toString())
   {print("stage 1");
     if(dropdownValueTime=="1-5 months"&&(int.parse(internshipList[i]['worktime'])>=1&&int.parse(internshipList[i]['worktime'])<=5))
    {print("stage 2");
      filteredlist.add(internshipList[i]);
    
    }
    if(dropdownValueTime=="more than 5 months"&&int.parse(internshipList[i]['worktime'])>=6)
    {print("stage 3");
      filteredlist.add(internshipList[i]);
    }
   }
  
  }
  setState(() {
    filteredList=filteredlist;
  });
}

Widget ShimmerLayout(){
  
  return Shimmer.fromColors( 
  direction: ShimmerDirection.ttb,
  baseColor: Colors.white, 
  highlightColor: Colors.grey[300],
  child:Container(
    margin: EdgeInsets.only(left:30,right:30,top:30),
    width:MediaQuery.of(context).size.width/10,
    height:MediaQuery.of(context).size.height/2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
      color: Colors.grey,
    ),
  ),
  );
}


Widget FilterExpanded(var options,var dropdownValue)
  {
    return  DropdownButton<String>(
      hint: Padding(padding:EdgeInsets.only(left:30), child:Text("Select branch")),
      value: dropdownValue,
      icon: Padding(padding:EdgeInsets.only(left:5), child:Icon(Icons.arrow_drop_down)),
      iconSize: 30,
      elevation:2,
      focusColor: Colors.white,
      
      style: TextStyle(color: Colors.deepPurple,fontSize:15),
      underline: Container(
        height: 0,
        color: Colors.white,
      ),
      onChanged: (String newValue) {
        
        var catagory=['Jobs','Internships'];
        var time=['1-5 months','more than 5 months'];
  
        for(var i=0;i<catagory.length;i++)
        {if(newValue==catagory[i])
        {setState(() {
          dropdownValueCategory=newValue;
        });
        }
        }
        for(var i=0;i<time.length;i++)
        {if(newValue==time[i])
       {
          setState(() {
          dropdownValueTime=newValue;
        });
       }
        }
     
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(padding:EdgeInsets.only(left:30), child:Text(value)),
        );
      }).toList(),
      );
  }

@override
  Widget build(BuildContext context) {


    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    
    
  
  
 
return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Scaffold(
            resizeToAvoidBottomInset: false,

      floatingActionButton:Stack(
        children:<Widget>[
      Align(
        alignment: Alignment(-0.8,-0.85),
      child: FloatingActionButton(
      elevation:30,
      backgroundColor: Colors.red[900],
      onPressed: (){
        _scaffoldKey.currentState.openDrawer();

      },
      child:Center(
        child:Column(
        children: [
         Padding(
           padding: EdgeInsets.only(top:15),
         child: Container(
            height: 5,
            width: 25,
            decoration:BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10),
            )
          )
         ),
        
        Padding(
           padding: EdgeInsets.only(top:5),
         child: Container(
            height: 5,
            width: 25,
            decoration:BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10),
            )
          )
         ),
        
         Padding(
           padding: EdgeInsets.only(top:5),
         child: Container(
            height: 5,
            width: 25,
            decoration:BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10),
            )
          )
         ),
        
        ],
      )
    ),
    ),
      ),
        
        //*************Upload****************** */
        Align(
          alignment: Alignment.bottomRight,
          child:FloatingActionButton(
           child: Icon(Icons.drive_folder_upload,color: Colors.white,),
            backgroundColor: Colors.blue,
            onPressed: (){
              Navigator.of(context).push(
   PageRouteBuilder(
    pageBuilder: (
        BuildContext context, 
        Animation<double> animation, 
        Animation<double> secondaryAnimation) {
      return InternshipUpload(widget.name);
    },
    transitionsBuilder: (
        BuildContext context, 
        Animation<double> animation, 
        Animation<double> secondaryAnimation, 
        Widget child) {
     var begin = Offset(0.0, 1.0);
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
            },

          ))
        ],
      ),
      
    // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    key: _scaffoldKey,
    drawer: SafeArea(
    
      child:ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(50)),
      child: Drawer1(widget.name,"Internships"),),),
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child:SingleChildScrollView(
             physics: BouncingScrollPhysics(),
          child:Column(
          
          
           children:<Widget> [

             //***********************Search*************************** */
            // Row(
            //  children:<Widget>[
            //    Padding(
            //    padding: EdgeInsets.only(top:50,left:20),
            //    child:Center(
            //    child: Container(
            //      width:width/1.5,
            //      height: height/14,
            //      decoration: BoxDecoration(
            //        color: Colors.white,
            //        borderRadius: BorderRadius.circular(20),
            //        boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
            //      ),
            //   child: TextField(
            //     textInputAction: TextInputAction.search,
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(Icons.search),
            //       hintText: "Search",
            //       border: InputBorder.none,
            //     ),
            //   ),
              
            //    ),
            //    ),
            //  ),
             
          
            //  ],
            // ),
            //**********************Filters***************************** */
            Padding(
              padding: EdgeInsets.only(top:10,bottom:30),
              child: AnimatedContainer(
                 duration: Duration(milliseconds:500),
           
                 width:_width,
                 height:_height,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20),
                  //  boxShadow: [BoxShadow(color:Colors.black12,blurRadius:30,spreadRadius:0,offset: Offset(0,10))],
                 ),
               
                 

                 child:_isFilterExpanded? 
                   Column(
                 children:<Widget>[
          FlatButton(
 
                  child: Icon(Icons.filter_alt),
                   onPressed: ((){
                   setState(() {
                     _width=250;
                     _height=height/14;
                     _isFilterExpanded=false;
                   });
                 }),),
              
            //  Padding(
            //    padding: EdgeInsets.only(bottom:10),
            //  child: Container(
            //     decoration: BoxDecoration(
            //      borderRadius: BorderRadius.circular(20),
            //      color: Colors.black12,
            
            //    ),
            //     height:30,
            //     width:width/1.8,
            //    child:FilterExpanded(<String>['Jobs','Internships'],this.dropdownValueCategory)
            //   ),
            //  ),
              
                           Padding(
               padding: EdgeInsets.only(bottom:10),
             child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 color: Colors.black12,
            
               ),
                height:30,
                width:width/1.8,
               child:DropdownButton(                               
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
                                  child:Text("branch",overflow: TextOverflow.ellipsis)),
                                  value:dropdownValueBranch,
                                  onChanged: (newValue){
                                      setState(() {
                                        dropdownValueBranch=newValue;
                                      });
                                  },
                                  items: branches.map((valueItem){
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child:Padding(padding:EdgeInsets.only(left:30),
                                  child:Text(valueItem,overflow: TextOverflow.ellipsis)),
                                    );
                                  }).toList(),

                                ),
            
              ),
             ),
              
            
                          Padding(
               padding: EdgeInsets.only(bottom:30),
             child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 color: Colors.black12,
            
               ),
                height:30,
                width:width/1.8,
               child:FilterExpanded(<String>['1-5 months','more than 5 months'],dropdownValueTime)
            
              ),
             ),
              
             Container(
            height:height/15,
            width: 100,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:Colors.yellow[700],
            ),
            child:FlatButton(
              onPressed: ((){
                   setState(() {
                     _width=250;
                     _height=height/14;
                     _isFilterExpanded=false;
                   });
                   filterList();
                 }),
              child:Center(child: Text("Apply Now",
              style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),),
            )
          ),
                 
                 
                 ],
                 )
                   
                 :FlatButton(
                   
                   child:Align(alignment: Alignment.centerRight, child:Icon(Icons.filter_alt)),
                   onPressed: ((){
                   setState(() {
                     _width=width/1.5;
                     _height=height/3;
                     _isFilterExpanded=true;
                   });
                 }),)
                 
                 
                 ),
                 
                
             
              ),
                        
            filteredList.length!=0||listIsLoading?ListView.builder(
             physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:listIsLoading?3:filteredList.length,
                itemBuilder: (context,index){
                  return listIsLoading?ShimmerLayout():InternshipCard(filteredList[index],userList);
                }
            //  InternshipCard("Khyati Agrawal","2013","Summer InternShip \n hello\nyo\nt\nt\n","India","2 months"),
            //  InternshipCard("Khyati Agrawal","2013","Summer InternShip","India","2 months"),
            //  InternshipCard("Khyati Agrawal","2013","Summer InternShip","India","2 months"),
           
            )
          :Padding(padding:EdgeInsets.only(top:50),child:Column(
            children:<Widget>[
              CircleAvatar(
                radius: 70,
                backgroundImage:AssetImage("images/error.png")
              ),
              Padding(padding: EdgeInsets.only(top:20),
              child:Center(child: Text("Nothing found"),
              ),
              ),
            
            ],
              ),
          ),
          
           ],
          ),
         
          ),
       
      
        ),

       ),

);

  }

}
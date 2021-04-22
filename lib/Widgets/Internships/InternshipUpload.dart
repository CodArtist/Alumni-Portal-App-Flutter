import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../User.dart';
import 'package:url_launcher/url_launcher.dart';



class InternshipUpload extends StatefulWidget {
var user;
  InternshipUpload(this.user);
 
  @override
  _InternshipUpload createState() => _InternshipUpload();
}

class _InternshipUpload extends State<InternshipUpload> {
TextEditingController title=new TextEditingController();
TextEditingController location=new TextEditingController();
TextEditingController workTime=new TextEditingController();
TextEditingController description=new TextEditingController();
TextEditingController about=new TextEditingController();
TextEditingController skills=new TextEditingController();
TextEditingController link=new TextEditingController();
var isLoading=false;
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
String dropdownValueBranch;

handleSubmit() async
{
  var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                 uploaddata();
                   } else {
                      Fluttertoast.showToast(msg: "No Internet",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
                       }
}
 Future<bool> checkUrl(var url) async {
  if (await canLaunch(url)) {
    return Future<bool>.value(true);
  } else {
     return Future<bool>.value(false);
  }

}

uploaddata() async{
  if(title.text.isNotEmpty&&location.text.isNotEmpty&&workTime.text.isNotEmpty&&description.text.isNotEmpty&&about.text.isNotEmpty&&skills.text.isNotEmpty&&link.text.isNotEmpty&&dropdownValueBranch!=null)
  {     
    setState(() {
      isLoading=true;
    });
    
    final response = await http.post(
         "https://alumniportal2001.000webhostapp.com/AddInternship.php", body: {
       "EnrollmentNo": User.enrollmentNo,
       "Link":link.text,
       "Title": title.text,
       "Location": location.text,
       "Worktime":workTime.text,
       "Details":description.text,
       "About":about.text,
       "Skills":skills.text,
       "Branch":branches.indexOf(dropdownValueBranch).toString(),
     });

       print(response.body.toString());

   if(response.body.toString()=="already exists")
  {
    Fluttertoast.showToast(
      msg:"Internship already posted",
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM
    );
    Navigator.of(context).pop();

  }

  if(response.body.toString()=="true"||response.body.toString()=="1"||response.statusCode==200)
  {
    Fluttertoast.showToast(
      msg:"Submitted Successfully!!",
      backgroundColor: Colors.greenAccent[700],
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM
    );
     Fluttertoast.showToast(
      msg:"Wait for Verification",
      backgroundColor: Colors.greenAccent[700],
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
    Navigator.of(context).pop();

  }
  else{
    print(response.body);
     Fluttertoast.showToast(
      msg:"An error occured",
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM
    );
    Navigator.of(context).pop();

  }
  setState(() {
    isLoading=false;
  });

  }
  else{
     Fluttertoast.showToast(msg: "All fields are required",
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                      );
  }
}
   @override
  Widget build(BuildContext context) {
    
  return Scaffold(
    appBar: AppBar(title:Text("Upload Internship"),
    backgroundColor: Colors.red,),
    body: isLoading?Center(child:Image.asset("images/spinner.gif",scale:2)):SafeArea(
      child:Container(
    // height:MediaQuery.of(context).size.height/2,
    child: Column(
      children:<Widget>[
        
        //*********************Cancel******************** */
      //    Padding(
      //      padding: EdgeInsets.only(top:10,left:0),
      //     // margin: EdgeInsets.all(30),
      //     // width:MediaQuery.of(context).size.width,
      //     // height: 50,
      //    child:Container(
      //      height: MediaQuery.of(context).size.height/12,
      //    child: Row(
      //     children:<Widget>[
      //       FlatButton(
      //         onPressed:((){Navigator.of(context).pop();}),
      //         child:Icon(Icons.arrow_back_ios_outlined),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.only(left:50),
      //       child:Text("Upload Internship",
      //       style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),) 
      //       ),
          
      //     ]
      //   ),
      // ), 
      //    ),
        // ListTile(
        // title: Text("Upload Internships"),
        // leading: Icon(Icons.cancel_outlined),
        // ),
        Expanded(
          child:ListView(
      physics:BouncingScrollPhysics(),
      children:<Widget>[
        //*****************************Title*************************************** */
        Padding(
          padding: EdgeInsets.all(20),
          child:Container(
          
            child:TextField(
          style:TextStyle(fontWeight: FontWeight.bold),
          keyboardType:TextInputType.multiline,
          maxLines: null,
          controller: title,
          decoration: InputDecoration(
            filled:true,
            labelText: "Title",
            fillColor: Colors.black12,
            // hintText: "Title",
            contentPadding: const EdgeInsets.only(left:30,top:10,bottom:10),
            border: OutlineInputBorder(
               borderSide: const BorderSide(color: Colors.grey, width:3.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width:3.0),
              borderRadius: BorderRadius.circular(25.0),

            ),
         
          ),
          ),
        ),
        ),
        
        //*********************************location***************************** */
           Padding(
          padding: EdgeInsets.all(20),
          child:Container(
     
            child:TextField(
          style:TextStyle(fontWeight: FontWeight.normal),
          keyboardType:TextInputType.multiline,
          maxLines: null,
          controller: location,
          decoration: InputDecoration(
            filled:true,
            labelText: "location",
            fillColor: Colors.black12,
            // hintText: "Title",
            contentPadding: const EdgeInsets.only(left:30,top:10,bottom:10),
            border: OutlineInputBorder(
               borderSide: const BorderSide(color: Colors.grey, width:3.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width:3.0),
              borderRadius: BorderRadius.circular(25.0),

            ),
         
          ),
          ),
        ),
        ),
      
      //*********************branch************************* */
      Padding(
        padding:EdgeInsets.only(left:20,right: 20,top:20),
       child:Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 color: Colors.black12,
            
               ),
                height:50,
             
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
      
     //******************************Time Period*********************************************** */
          Padding(
          padding: EdgeInsets.only(left:20,right:20,top:40,bottom:20),
          child:Container(
     
            child:TextField(
          style:TextStyle(fontWeight: FontWeight.normal),
          keyboardType:TextInputType.number,
          maxLines: null,
          controller: workTime,
          decoration: InputDecoration(
            filled:true,
            labelText: "Time Period (in months)",
            fillColor: Colors.black12,
            // hintText: "Title",
            contentPadding: const EdgeInsets.only(left:30,top:10,bottom:10),
            border: OutlineInputBorder(
               borderSide: const BorderSide(color: Colors.grey, width:3.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width:3.0),
              borderRadius: BorderRadius.circular(25.0),

            ),
         
          ),
          ),
        ),
        ),
     
       
       //**********************************Description********************************** */
          Padding(
          padding: EdgeInsets.all(20),
          child:Container(
            child:TextField(
            
          style:TextStyle(fontWeight: FontWeight.normal),
          keyboardType:TextInputType.multiline,
          maxLines: null,
          controller: description,
          decoration: InputDecoration(
            filled:true,
            labelText: "Description",
            fillColor: Colors.black12,
            // hintText: "Title",
            contentPadding: EdgeInsets.only(left:30,top:10,bottom:10),
            border: OutlineInputBorder(
               borderSide: const BorderSide(color: Colors.grey, width:3.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width:3.0),
              borderRadius: BorderRadius.circular(25.0),

            ),
         
          ),
          ),
        ),
        ),
       
       //***************************About********************************* */
         Padding(
          padding: EdgeInsets.all(20),
          child:Container(
            child:TextField(
            
          style:TextStyle(fontWeight: FontWeight.normal),
          keyboardType:TextInputType.multiline,
          maxLines: null,
          controller: about,
          decoration: InputDecoration(
            filled:true,
            labelText: "About the work",
            fillColor: Colors.black12,
            // hintText: "Title",
            contentPadding: EdgeInsets.only(left:30,top:10,bottom:10),
            border: OutlineInputBorder(
               borderSide: const BorderSide(color: Colors.grey, width:3.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width:3.0),
              borderRadius: BorderRadius.circular(25.0),

            ),
         
          ),
          ),
        ),
        ),
     
     //********************************Skills****************************** */
       Padding(
          padding: EdgeInsets.all(20),
          child:Container(
            child:TextField(
            
          style:TextStyle(fontWeight: FontWeight.normal),
          keyboardType:TextInputType.multiline,
          maxLines: null,
          controller: skills,
          decoration: InputDecoration(
            filled:true,
            labelText: "Skills",
            fillColor: Colors.black12,
            // hintText: "Title",
            contentPadding: EdgeInsets.only(left:30,top:10,bottom:10),
            border: OutlineInputBorder(
               borderSide: const BorderSide(color: Colors.grey, width:3.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width:3.0),
              borderRadius: BorderRadius.circular(25.0),

            ),
         
          ),
          ),
        ),
        ),
        
        //**************************************Link************************************ */
         Padding(
          padding: EdgeInsets.all(20),
          child:Container(
            child:TextField(
            
          style:TextStyle(fontWeight: FontWeight.normal),
          keyboardType:TextInputType.multiline,
          maxLines: null,
          controller: link,
          decoration: InputDecoration(
            filled:true,
            labelText: "Internship Link",
            fillColor: Colors.black12,
            // hintText: "Title",
            contentPadding: EdgeInsets.only(left:30,top:10,bottom:10),
            border: OutlineInputBorder(
               borderSide: const BorderSide(color: Colors.grey, width:3.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width:3.0),
              borderRadius: BorderRadius.circular(25.0),

            ),
         
          ),
          ),
        ),
        ),

        //******************************Submit**************************** */
       Padding(
            padding: EdgeInsets.only(left:60,top:10,bottom:30,right:60),
          child:Container(
            height:MediaQuery.of(context).size.height/15,
            width: 50,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:Color(0XFF317CEE),
            ),
            child:FlatButton(
              onPressed:(()async{
                Future<bool> validUrl=Future<bool>.value(true);
                 if(link.text!="")
                                    {
                                      validUrl=checkUrl(link.text);
                                    }
                if(await validUrl)
                                    handleSubmit();
                                    else
                                  Fluttertoast.showToast(msg:"Invalid Url of internship");
                 
              }),
              child:Center(child: Text("Submit",
              style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),),
            )
          )
          ),
      
      ],
    ),
        ), 
      
      
      ],
    ),
    
    ),
    ),
  );
  }


}
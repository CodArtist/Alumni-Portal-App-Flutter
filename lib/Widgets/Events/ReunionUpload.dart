import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../User.dart';
import 'dart:convert';


class ReunionUpload extends StatefulWidget {
var user;
  ReunionUpload(this.user);
 
  @override
  _ReunionUpload createState() => _ReunionUpload();
}

class _ReunionUpload extends State<ReunionUpload> {
TextEditingController title=new TextEditingController();
TextEditingController location=new TextEditingController();
TextEditingController date=new TextEditingController();
TextEditingController description=new TextEditingController();
var isImageSelected=false;
var isLoading=false;

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

File imageFile;
String imageData;
imagePicker()async{
var pickedimage=await ImagePicker().getImage(source: ImageSource.gallery);
if(pickedimage!=null)
{
setState(() {
  imageFile=File(pickedimage.path);
  imageData=base64Encode(imageFile.readAsBytesSync());
  isImageSelected=true;
});
print(imageData);

}
else
{setState(() {
  isImageSelected=false;
});
}
}

uploaddata() async{
  print("sdasdsjbsddddkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
  if(title.text.isNotEmpty&&location.text.isNotEmpty&&date.text.isNotEmpty&&description.text.isNotEmpty)
  {   
    setState(() {
      isLoading=true;
    });
      final response = await http.post(
         "https://alumniportal2001.000webhostapp.com/AddEvents.php", body: {
       "EnrollmentNo":User.enrollmentNo,
       "Title": title.text,
       "Location": location.text,
       "Date":date.text,
       "Details":description.text,
       "Function":"Reunion",
       "Image":imageData==null?"NULL":imageData,

     });

       print(response.body.toString());

   if(response.body.toString()=="already exists")
  {
    Fluttertoast.showToast(
      msg:"Reunion already posted",
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
    print(response);
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
    appBar: AppBar(title:Text("Upload Reunion"),
    backgroundColor: Colors.red,),
    body: isLoading?Center(child:Image.asset("images/spinner.gif",scale:2)):SafeArea(
      child:Container(
    child: Column(
      children:<Widget>[
    
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
      
     
      
     //******************************Date*********************************************** */
          Padding(
          padding: EdgeInsets.only(left:20,right:20,top:40,bottom:20),
          child:Container(
     
            child:TextField(
          style:TextStyle(fontWeight: FontWeight.normal),
          maxLines: null,
          controller: date,
          decoration: InputDecoration(
            filled:true,
            labelText: "date (DD/MM/YY)",
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
       
        //*******************************************Addimage***************************************** */
      Padding(
            padding: EdgeInsets.only(left:60,top:10,bottom:10,right:60),
          child:Container(
            height:MediaQuery.of(context).size.height/15,
            width: 50,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:Color(0XFF317CEE),
            ),
            child:FlatButton(
              onPressed:((){
                 imagePicker();
              }),
              child:Center(child: Text("Add Image(Optional)",
              style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),),
            )
          )
          ),
        
         //******************************************ShowUploadedImage*************************** */

                isImageSelected?Padding(
          padding: EdgeInsets.only(top:10,left: 30,right: 30),
          child:ClipRRect(
            
            borderRadius:BorderRadius.circular(60),


          child:Image.memory(base64Decode(imageData),height: MediaQuery.of(context).size.height/2,),
          )
          )
        :Center(child:Text("No image Selected",
        style:TextStyle(fontSize: 10,color: Colors.red))),
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
              onPressed:((){
                 handleSubmit();
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
import 'dart:convert';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget{



  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  bool a=false;

  @override
  void initState() { 
    super.initState();
    pref();
    
  }

  
   pref() async{
    var pref =await SharedPreferences.getInstance();
     a = pref.getBool("login");

     if(a){
       Navigator.of(context).pushReplacementNamed("/home");
     }
     setState(() {
       
     });

   }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   

  bool _autoValidate = false;

  bool _isvisible = false;

  String _email;

  String _password;


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        title: Text("Feel Safe",style: GoogleFonts.roboto(fontSize: 24, color: Colors.black),),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,

      ),
      body: GestureDetector(

           behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
           FocusScope.of(context).requestFocus(FocusNode());
           },
          onTap: (){
             FocusScopeNode currentFocus = FocusScope.of(context);
             if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) { currentFocus.focusedChild.unfocus(); }
          },


              child: SingleChildScrollView(
            child: new Container(
              margin: new EdgeInsets.all(15.0),
              child: new Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: FormUI(),
              ),
            ),
          ),
      ),
      
      );
  }

  Widget FormUI(){

    return SingleChildScrollView(
          child: new Column(
        children: <Widget>[

         Image.asset('assets/login.gif'),

          
         SizedBox(height: 20,),
          new TextFormField(
            decoration:  InputDecoration(
              prefixIcon: Icon(Icons.mail),
              labelText: 'Email',
               fillColor: Colors.grey,
              focusColor: Colors.grey,
              enabledBorder:OutlineInputBorder(
                
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
               errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
              errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,),
              
               focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
              border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,//this has no effect
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
              
              
              ),
            keyboardType: TextInputType.emailAddress,
           validator: (String arg) {

             if (arg.isEmpty) return 'Email can not be empty';

            

            else{
              return null;
            }
            

          },
            onSaved: (String val){
              _email = val;
            },
          ),

          SizedBox(height: 20,),


          new TextFormField(
            decoration:  InputDecoration(
               prefixIcon: Icon(Icons.lock),
              labelText: 'Password',
              enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
               errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
              errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,),
              
               focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
              border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,//this has no effect
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
              
              
              
              ),
            keyboardType: TextInputType.visiblePassword,

            obscureText: true,
            validator: (String arg){
              if(arg.length<4){
                return "Password is too Short!";
              }

              else{
                return null;
              }

            },
            onSaved: (String val){
              _password = val;
            },
            
          ),
          

          new SizedBox(
            height: 10.0,
          ),


           ArgonButton(
              height: 50,
              roundLoadingShape: true,
              
              width: MediaQuery.of(context).size.width * 0.45,
              onTap: (startLoading, stopLoading, btnState) {
                if (btnState == ButtonState.Idle) {
                  startLoading();

                  if (_formKey.currentState.validate()) {

                      _formKey.currentState.save();
                     // print("email is $_email and pasword is $_password");
                      setState(() {
                        _isvisible = true;
                      });
                      print("here");
                      send(_email,_password,stopLoading);

                    } else  {
                    
                      setState(() {
                        _autoValidate = true;
                      });
                      stopLoading();
                    }
                
                  
                } else {
                  stopLoading();
                }
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              loader: Container(
                padding: EdgeInsets.all(10),
                child: SpinKitSpinningCircle(
                  color: Colors.white,
                  // size: loaderWidth ,
                ),
              ),
              borderRadius: 5.0,
              color: Color(0xFFfb4747),
            ),
            SizedBox(
              height: 20,
            ),






            //##############################3


            ArgonButton(
              height: 50,
              roundLoadingShape: true,
              width: MediaQuery.of(context).size.width * 0.45,
              onTap: (startLoading, stopLoading, btnState) {
                
                Navigator.of(context).pushNamed("/signup");
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              loader: Container(
                padding: EdgeInsets.all(10),
                child: SpinKitSpinningCircle(
                  color: Colors.white,
                  // size: loaderWidth ,
                ),
              ),
              borderRadius: 5.0,
              color: Colors.blue,
            ),
            SizedBox(
              height: 50,
            ),

          // new RaisedButton(
            
          //   onPressed: _validateInputs,
          //   child: new Text('Validate'),
          // ),


          
        //    Visibility(
        //   child: Center(child: CircularProgressIndicator(),),
        //   maintainSize: true, 
        //   maintainAnimation: true,
        //   maintainState: true,
        //   visible: _isvisible, 
        // ),



        ],
      ),
    );


  }


   send(String email, String password, stoploading) async {

   String url = "https://securityapp22.000webhostapp.com/Login.php";

  try{

    final post = await http.post(
      url,
      headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
        },

      body: jsonEncode(<String, String>{
        "email": email,
        "pass": password
      })

    ).then((http.Response response) async {

      //  var pref = await SharedPreferences.getInstance();

      var data = json.decode(response.body);
      if(data['uid']=="-1"){
      
     print(data);
      _showMyDialog("Invalid Credentials", "Check Your email and password and try again");
       

       setState(() {
         _isvisible = false;
       });

       stoploading();
      }

        

      if(data['uid']!="-1")  {
        print(data);


        String uid = data['uid'];

        var pref = await SharedPreferences.getInstance();
        
        pref.setBool("login", true);
        pref.setString("uid",uid );

       
        print("success");


        Navigator.of(context).popAndPushNamed('/home');

       

        
      }

    });

      

  }catch(ex){
    print(ex);
  }

 }


 Future<void> _showMyDialog(String title,String content) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(content),
              //Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}










}
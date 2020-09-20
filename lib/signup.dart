import 'dart:convert';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


class SignUp extends StatefulWidget{
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   

  bool _autoValidate = false;

  bool _isvisible = false;

  String _email;

  String _password;

  String _name;



  @override
  Widget build(BuildContext context) {
   return Scaffold(
 appBar: AppBar(
   iconTheme: IconThemeData(color: Colors.black),
        title: Text("Feel Safe",style: GoogleFonts.roboto(fontSize: 24, color: Colors.black),),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,

      ),


     body:  GestureDetector(

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

         Image.asset('assets/signup.gif'),

          
         SizedBox(height: 20,),




         new TextFormField(
            decoration:  InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              labelText: 'Name',
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

           return null;
            

          },
            onSaved: (String val){
              _name = val;
            },
          ),



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
                      send(_email,_password,stopLoading,_name);

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
              color: Color(0xFFfb4747),
            ),
            SizedBox(
              height: 20,
            ),






            //##############################3


            

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


  send(String email, String password, stoploading,String name) async {

   String url = "https://securityapp22.000webhostapp.com/InsertUserInfo.php";

  try{

    final post = await http.post(
      url,
      headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
        },

      body: jsonEncode(<String, String>{
        "name":name,
        "email": email,
        "pass": password
      })

    ).then((http.Response response) async {

      //  var pref = await SharedPreferences.getInstance();

      var data = json.decode(response.body);
      if(data['response']=="success"){
      
     print(data);
     // _showMyDialog("Invalid Credentials", "Check Your email and password and try again");
       
      
       setState(() {
         _isvisible = false;
       });

       _showMyDialog("Success", "Your signup was successful now go back and sign in with your credentials");

       stoploading();
      }

        

      if(data['response']!="success") {
        print(data);

        

       
        print("failed");

       
        stoploading();
        
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
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety/searchpeopleModel.dart';
import 'package:women_safety/signup.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  

  @override
  void initState() { 
    super.initState();

    
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {

        '/login': (context)=>Login(),
        '/home': (context)=>MyHomePage(title: 'Feel Safe'),
        '/signup':(context)=>SignUp(),
      },




      debugShowCheckedModeBanner: false,
      title: 'Feel Safe',
      

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
 

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<FIndPeople> findpeople = [];
   List<Marker> marker69 = [];
   BitmapDescriptor pinLocationIcon;

  var lat=0.0;
  var longi= 0.0;

  String _mapStyle;

  @override
  void initState() { 
    super.initState();
     BitmapDescriptor.fromAssetImage(
         ImageConfiguration(devicePixelRatio: 2.5),
         'assets/marker.png').then((onValue) {
            pinLocationIcon = onValue;
         });

    rootBundle.loadString('assets/map.txt').then((string) {
    _mapStyle = string;
  });
  }

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(26.895144,80.961115),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/alert.png");
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> getMarker1() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/mylocation.jpg");
    return byteData.buffer.asUint8List();
  }
  

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
         // rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: false,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeWidth: 2,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker1();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt: 0,
              zoom: 16.80)));
          updateMarkerAndCircle(newLocalData, imageData);
          lat = newLocalData.latitude;
          longi = newLocalData.longitude;
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.phone_locked,), onPressed: ()async{
          var pref = await SharedPreferences.getInstance();
          pref.clear();
          Navigator.of(context).pushReplacementNamed("/login");
        },),
        
        ],
        title: Text(widget.title,style: GoogleFonts.roboto(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w400)),
        centerTitle: true,
        
        backgroundColor: Color.fromRGBO(0, 60, 153, 0.7),
        elevation: 0,
      ),
      body: SafeArea(
              child: Container(
          child: Stack(
                    children:<Widget>[
                     
                      

                      
                       GoogleMap(
                         zoomControlsEnabled: false,
                         zoomGesturesEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: initialLocation,
              markers: Set.of((marker69 != null) ? marker69 :[]),
              circles: Set.of((circle != null) ? [circle] : []),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                _controller.setMapStyle(_mapStyle);
                
                
              },

            ),
            
             Positioned(
                        bottom: 14,
                        left: 15,
                        child: GestureDetector(
                          onTap: (){
                            _locationSubscription.cancel();

                            _settingModalBottomSheet(context);
                          },
                                                  child: Container(
                            height: 50,
                            padding: EdgeInsets.all(10),
                            child: Row(children:<Widget>[ Icon(Icons.add_alert, color: Colors.white,), Text("Need Assistance",style: GoogleFonts.manrope(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 14),)]),
                           
                            decoration: BoxDecoration(
                               color: Colors.red,
                              borderRadius: BorderRadius.all(Radius.circular(14))
                            ),
                          ),
                        ),
                        ),
              
               Positioned(
                        bottom: 94,
                        left: 15,
                        child: GestureDetector(
                          onTap: (){
                           searchpeople();
                          },
                                                  child: Container(
                            height: 50,
                            padding: EdgeInsets.all(10),
                            child: Row(children:<Widget>[ Icon(Icons.search, color: Colors.white,), Text("Find People",style: GoogleFonts.manrope(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 14),)]),
                           
                            decoration: BoxDecoration(
                               color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(14))
                            ),
                          ),
                        ),
                        ),
                      
            
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_on),
          onPressed: () {
            getCurrentLocation();
          }),
    );
  }


  void _settingModalBottomSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            child: new Wrap(
            children: <Widget>[
new ListTile(
            leading: new Icon(Icons.music_note),
            title: new Text('Music'),
            onTap: () => {}          
          ),
          new ListTile(
            leading: new Icon(Icons.videocam),
            title: new Text('Video'),
            onTap: () => {},          
          ),
            ],
          ),
          );
      }
    );
    
    }




  searchpeople()async {

    _showMyDialog("Searching....", "searching for SOS calls");




  }


  send()async {

    findpeople.clear();
    marker69.clear();
    setState(() {
      
    });

    var pref = await SharedPreferences.getInstance();
    var uid = pref.getString("uid");
    var locallat = lat;
    var locallong = longi;
    print("lat : ${locallat} and longi: ${locallong}");

    String url = "https://securityapp22.000webhostapp.com/getNearbyUsers.php";

    var post = await http.post(url,

      headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
        },

      


        body: jsonEncode(<String, String>{
          "uid": uid,
          "lat": locallat.toString(),
          "longi": locallong.toString(),
          "dist":"5"

        })


    
    ).then((http.Response res) async {

      var data = json.decode(res.body);

      print(data);

        try{

      for(var d in data){
        FIndPeople f = FIndPeople.fromJson(d);
        findpeople.add(f);
      }

      var len = findpeople.length;
      print(len);
       Uint8List imageData1 = await getMarker();

      for(int i = 0; i<len;i++){
      marker69.add(Marker(
        markerId: MarkerId(findpeople[i].uid),
        position: LatLng(double.parse(findpeople[i].lat),double.parse(findpeople[i].longi)),
        icon: BitmapDescriptor.fromBytes(imageData1)

      ));
      }

      setState(() {
        // marker= marker69[0];
        
      });
        }catch(ex){
          print(ex);
          print("nahi hua");

        }

    });

  }




  Future<void> _showMyDialog(String title,String content) async {

    send();

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2),(){
        Navigator.of(context).pop();
      });
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(

          child: ListBody(
            children: <Widget>[
              Row(  children:<Widget>[Text(content), SizedBox(width: 10,), CircularProgressIndicator()   ]),
              
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

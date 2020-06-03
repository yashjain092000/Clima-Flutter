import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState(){
    super.initState();
    getLocation();
  }
  void getLocation() async{
Location location=Location();
await location.getCurrentLocation();//using await here we will get latitude and longitude printed only when it's execution gets completed.
    print(location.latitude);
    print(location.longitude);
    }
    void getData(){

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

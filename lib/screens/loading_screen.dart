import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String apiKey = 'a6c0198e589f0709c878c789bd81aa9e';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    //using await here we will get latitude and longitude printed only when it's execution gets completed.
    latitude = location.latitude;
    longitude = location.longitude;
    NetworkHelper networkHelper=NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

      var weatherData= await networkHelper.getData();
      Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SpinKitDoubleBounce(
        
      )
    );
  }
}

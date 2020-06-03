import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    void getData() async {
      http.Response response = await http.get(
          'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=439d4b804bc8187953eb36d2a8c26a02');
      if (response.statusCode == 200) {
        String data=response.body;
        var decodedData=jsonDecode(data);
        var temperature=decodedData['main']['temp'];
        var condition=decodedData['weather'][0]['id'];
        var cityName=decodedData['name'];
        print(temperature);

      }
      else {
        print(response.statusCode);
      }
    }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}

import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:icon_shadow/icon_shadow.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  String description;
  var time;
  var t;
  int checkTime;
  int sunset;
  int sunrise;
  String imageName;
  String inText;


  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'N/A';
        cityName = '';
        time = null;
        description="Not found!";
        inText="";
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      description=weatherData['weather'][0]['description'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weatherData['weather'][0]['main'];
      cityName = weatherData['name'];
      inText='in';
      t = DateTime.fromMillisecondsSinceEpoch(weatherData['dt'] * 1000);
      checkTime = int.parse(t.toString().substring(11, 13));
      time = DateTimeFormat.format(t, format: DateTimeFormats.american);
      sunset = int.parse(DateTime.fromMillisecondsSinceEpoch(
              weatherData['sys']['sunset'] * 1000)
          .toString()
          .substring(11, 13));
      sunrise = int.parse(DateTime.fromMillisecondsSinceEpoch(
              weatherData['sys']['sunrise'] * 1000)
          .toString()
          .substring(11, 13));
      if (checkTime >= sunrise && checkTime < 12) {
        imageName = 'morning.jpg';
      } else if (checkTime >= 12 && checkTime < sunset)
        imageName = 'noon.jpg';
      else if (checkTime >= sunset && checkTime < sunrise)
        imageName = 'night.jpg';
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$imageName'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
//
                  child: IconShadowWidget(Icon(Icons.room,
                      color: Colors.blueGrey.shade900, size: 50),shadowColor: Colors.white,),



                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },


                    child: IconShadowWidget(Icon(Icons.near_me,
                        color: Colors.blueGrey.shade900, size: 50),shadowColor: Colors.white,),

                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherIcon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$weatherMessage',
                          style: kTempTextStyle,
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$description',
                          style: kDescTextStyle,
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$inText',
                          style: kInTextStyle,
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$cityName',
                          style: kCityTextStyle,
                        ),

                      ],
                    ),
                  ),
                ],

              ),

            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Last updated on :',
                        style: kTimeDataTextStyle,
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$time',
                        style: kTimeTextStyle,
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0,bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'As per your device\'s location.',
                        style: kTimeDataTextStyle,
                      ),

                    ],
                  ),
                ),
              ],

            ),




//              Padding(
//                padding: EdgeInsets.only(right: 15.0),
//                child: Text(
//                  '$time in $cityName',
//                  textAlign: TextAlign.right,
//                  style: kMessageTextStyle,
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}

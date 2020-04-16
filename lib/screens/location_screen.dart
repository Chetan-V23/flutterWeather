//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data);

  final data;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temp;
  String city;
  String mainWeather;
  static DateTime time = DateTime.now();
  Map<String, String> emojiMap = {
    'Rain': '🌧️',
    //'Clear': time.hour < 18 && time.hour > 6 ? '☀️' : '🌙',
    'Clouds': '☁️',
    'Snowy': '🌨️',
    'Thunderstorm': '⛈️',
    'Day': '☀️',
    'Night':'🌙',
    'Haze':'🌫️',
    'Fog':'🌫️',
    'Mist':'🌬',
  };
  @override
  void initState() {
    super.initState();
    print(widget.data);
    temp = widget.data['main']['temp'];
    temp -= 273.15;
    city = widget.data['name'];
    mainWeather=widget.data['weather'][0]['main'];
    if(mainWeather=='Clear')
    {
      mainWeather=time.hour<18 && time.hour>6?'Day':'Night';
    }
    //print("\nWeather from location screen: "+temp.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background$mainWeather.jpg'),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  /*FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),*/
                  FlatButton(
                    onPressed: () 
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen(); 
                      }));
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      temp.toStringAsFixed(0)+'°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      emojiMap[mainWeather].toString(),
                      //emojiMap['Clear'].toString(),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  widget.data['weather'][0]['description']+ ' in $city today!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:weather_app/utilities/getlocation.dart';

//import 'package:flutter/material.dart';
//import 'package:weather_app/screens/location_screen.dart';
class NetworkData {
  //NetworkData(this.url);

  String url;
  GetLocation location;
  final String apiKey = '54f97d2795199a9c8e6e5a3629d0bfb7';

  Future<dynamic> getLocationMain() async {
    location = new GetLocation();
    await location.getLocation();

    url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey';

    return getFromApi();
  }

  Future<dynamic> getLocationFromCity(String city) async {
    url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';
    return getFromApi();
  }

  Future<dynamic> getFromApi() async {
    
    Response response;
    var data;
    response = await get(url);
    data = jsonDecode(response.body);
    
    if(response.statusCode>300)
      data=null;
    
    return data;
  }
}

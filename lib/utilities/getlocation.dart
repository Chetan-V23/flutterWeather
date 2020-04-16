//import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation
{
  double latitude;
  double longitude;
  String city;
 Future<void> getLocation() async
  {
    try{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    latitude=position.latitude;
    longitude=position.longitude;
    city=placemark[0].locality;
    }
    catch(e)
    {
      print(e.toString());
    }
  }
}
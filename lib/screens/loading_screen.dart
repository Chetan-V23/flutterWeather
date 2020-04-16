import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/networking.dart';
import 'city_screen.dart';
//import 'package:path/path.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen(this.city);

  final String city;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude, longitude;
  NetworkData dataObject;
  var receivedData;

  void sendData() async {
    dataObject = new NetworkData();
    receivedData = await dataObject.getLocationMain();
    if(receivedData==null)
    {
      _popUpDialogBox(context);
    }
    else{
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(receivedData);
    }));
    }
  }

  void _popUpDialogBox(BuildContext context) async{
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //shape: CircleBorder(side: BorderSide(width: 30)),
            title: Text(
              'City Not found',
              style: kMessageTextStyle,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Okay',
                  style: kButtonTextStyle,
                ),
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return CityScreen();
                  }));
                },
              ),
            ],
          );
        });
  }

  void sendData2() async {
    dataObject = new NetworkData();
    receivedData = await dataObject.getLocationFromCity(widget.city);

    if (receivedData == null) {
      print('HERE ITS NULL OMG!!!!!!!!!!!!');

      _popUpDialogBox(context);
     // Navigator.pop(context);
      /*AlertDialog(
        title: Text(
          'City Not found',
        style: kMessageTextStyle,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay',style: kMessageTextStyle,),
            onPressed: (){
            Navigator.pop(context);      
            },
          )
        ],
        );*/
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(receivedData);
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.city == null)
      sendData();
    else
      sendData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

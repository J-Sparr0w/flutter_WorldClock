import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:http/http.dart' as http;

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List timezones = [];
  String status = "no connection";
  List availablePlaces = [];
  getTimeZones() async {
    try {
      status = "loading";
      Uri url = Uri.parse("http://worldtimeapi.org/api/timezone");
      http.Response response = await http.get(url);

      List responseBody = jsonDecode(response.body);
      timezones = responseBody;
      timezones.forEach((timezone) {
        List<String> place = timezone.split('/');
        if (place.length == 2) {
          availablePlaces.add(place[1]);
        }
      });
      print(availablePlaces);

      setState(() {
        status = "complete";
      });
    } catch (e) {
      print("error occured : $e");
    }
  }

  void updateTime(place) async {
    WorldTime _instance = WorldTime(location: place);
    await _instance.getTime();
    Navigator.pop(context, {'time': _instance.time, 'place': _instance.place});
  }

  @override
  void initState() {
    super.initState();
    getTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('choose locations'),
          backgroundColor: Colors.cyan,
        ),
        body: ListView.builder(
          itemCount: availablePlaces.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text(
                    availablePlaces[index],
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              onTap: () {
                updateTime(timezones[index]);
              },
            );
          },
        ));
  }
}

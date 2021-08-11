import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTime {
  String time = "";
  String location;
 late String place;

  WorldTime({ required this.location}){
this.place=location.split('/')[1];
  }

  Future getTime() async {
    Uri url = Uri.parse("http://worldtimeapi.org/api/timezone/$location");

    try {
      final http.Response _response = await http.get(url);
      final Map _responseBody = jsonDecode(_response.body);

      final String _dateTime = _responseBody['utc_datetime'];
      final _localTime = DateTime.parse(_dateTime).toLocal();
      final String _currentTime = _localTime.toString().substring(11, 16);
      // final String _location = _responseBody['timezone'].split('/')[1];
      print(_responseBody);
      time = _currentTime;
    } catch (e) {
      print("error occured :$e");
    }
  }
}

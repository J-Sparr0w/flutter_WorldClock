import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTime {
  String time = "";
  String location;
  late String place;

  WorldTime({required this.location}) {
    this.place = location.split('/').last;
  }

  Future getTime() async {
    Uri url = Uri.parse("http://worldtimeapi.org/api/timezone/$location");

    try {
      final http.Response _response = await http.get(url);
      final Map _responseBody = jsonDecode(_response.body);

      final String _dateTime = _responseBody['utc_datetime'];
      String _offsetH = _responseBody['utc_offset'].substring(1,3);
      String _offsetM = _responseBody['utc_offset'].substring(4);

      DateTime _localTime = DateTime.parse(_dateTime);
      _localTime = _localTime.add(Duration(hours: int.parse(_offsetH),minutes:int.parse(_offsetM) ));
      final String _currentTime = _localTime.toString().substring(11, 16);
      // final String _location = _responseBody['timezone'].split('/')[1];
      print(_responseBody);
      time = _currentTime;
      print(time);
    } catch (e) {
      print("error occured :$e");
    }
  }
}

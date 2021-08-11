import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void loadTime() async {
     WorldTime _instance = WorldTime(location: "Asia/Kolkata");
     await _instance.getTime();
    Navigator.pushReplacementNamed(context, '/home',
        arguments: {'time': _instance.time, 'place': _instance.place});
  }

  @override
  void initState() {
    super.initState();
    loadTime();
    print('oninit');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('loading'),
      ),
    );
  }
}

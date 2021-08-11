import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map responseArg = {};
  @override
  Widget build(BuildContext context) {
    responseArg = (responseArg.isNotEmpty)
        ? responseArg
        : (ModalRoute.of(context)!.settings.arguments as Map);
    print("time ${responseArg['time']}");
    print("place ${responseArg['place']}");
    String time = responseArg['time'];
    String place = responseArg['place'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton.icon(
              onPressed: () async {
                dynamic result =
                    await Navigator.pushNamed(context, '/location');
                setState(() {
                  responseArg = {
                    'time': result['time'],
                    'place': result['place']
                  };
                });
              },
              label: Text('Edit Location'),
              icon: Icon(Icons.location_on_rounded),
              style: TextButton.styleFrom(
                primary: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              place,
              style: TextStyle(
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 50.0,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        child: Icon(
          Icons.replay_outlined,
          color: Colors.black38,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

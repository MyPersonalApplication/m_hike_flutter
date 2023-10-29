import 'package:flutter/material.dart';
import 'package:m_hike/page/hike_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage('assets/logo/logo_light.jpg'),
              width: 100,
              height: 100,
            ),
            const Text(
              'Welcome to',
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 24, // Adjust as needed
              ),
            ),
            const Text(
              'MANAGE\nHIKER',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 36, // Adjust as needed
              ),
            ),
            const Image(
              image: AssetImage('assets/home_light.jpg'),
              width: 300,
              height: 300,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HikePage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Adjust button color
                padding: const EdgeInsets.symmetric(
                    horizontal: 25, vertical: 8),
              ),
              child: const Text('START FOR FREE'),
            ),
          ],
        ),
      ),
    );
  }
}
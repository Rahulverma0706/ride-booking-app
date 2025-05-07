import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<bool> isDarkMode = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, darkModeEnabled, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: SplashScreen(isDarkMode: isDarkMode),
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  final ValueNotifier<bool> isDarkMode;
  SplashScreen({required this.isDarkMode});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(isDarkMode: widget.isDarkMode),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car, size: 100, color: Colors.white),
            Text(
              'Zappio',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text('Let\'s Ride', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final ValueNotifier<bool> isDarkMode;
  HomeScreen({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: isDarkMode,
              builder: (context, value, _) {
                return SwitchListTile(
                  title: Text("Dark Mode"),
                  value: value,
                  onChanged: (val) => isDarkMode.value = val,
                );
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Pickup Location"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Drop Location"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RideInfoScreen()),
                );
              },
              child: Text("Book Ride"),
            ),
          ],
        ),
      ),
    );
  }
}

class RideInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ride Info")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Captain: Rahul Verma', style: TextStyle(fontSize: 20)),
            Text('Vehicle No: XYZ123', style: TextStyle(fontSize: 20)),
            Text('Estimated Time: 12 mins', style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                print("Ride Started");
              },
              child: Text("Start Ride"),
            ),
          ],
        ),
      ),
    );
  }
}

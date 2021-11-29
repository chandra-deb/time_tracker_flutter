import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/landing_page.dart';
import './services/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return startMaterialApp(
            Text("Something went Wrong!"),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Provider<AuthBase>(
            create: (_) => Auth(),
            builder: (context, child) => startMaterialApp(LandingPage()),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return startMaterialApp(
          Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  MaterialApp startMaterialApp(Widget home) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Time Tracker",
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: home,
    );
  }
}

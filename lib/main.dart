import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Karar05_connection_check',
      home: const MyHomePage(title: 'Home Page',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool isConnectedToInternet = false;

class _MyHomePageState extends State<MyHomePage> {

  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      print(event);
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnectedToInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
        default:
          setState(() {
            isConnectedToInternet = true;
          });
          break;
      }
    });
  }

  void despose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
      ),
      body: 
      Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            if (isConnectedToInternet == false) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    title: const Text('No Internet Connection'),
                    icon: const Icon(
                      Icons.wifi_off,
                      color: Colors.black,
                      size: 57.3,
                    ),
                    content: Text(
                        'Please check your internet connection and try again.',
                        ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.w600)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ContactPage()));
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text("Go to contact page",
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      )
      );
  }
}

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
      ),
      body: const Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(15.5),
            child: Icon(Icons.emoji_people,color: Colors.red,
            size: 94,),
            ),
            Padding(
              padding: EdgeInsets.all(9.0),
              child: Text("Internet connection is complete, welcome to the contact page",
              style: TextStyle(color: Colors.red,fontSize: 28),),
            )
          ],
        ),
      ),
    );
  }
}
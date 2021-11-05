import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final url = "https://todearhemant.pythonanywhere.com/patient/api/patients/";
  var _postsJson = [];
  void fetchData() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _postsJson = jsonData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data'),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _postsJson.length,
          itemBuilder: (context, i) {
            final post = _postsJson[i];
            return Text(
              "Id:${post["id"]}\nName: ${post["name"]}\nAge: ${post["age"]}\nGender: ${post["gender"]}\n\n",
              style: TextStyle(fontSize: 17),
            );
          },
        ),
      ),
    );
  }
}

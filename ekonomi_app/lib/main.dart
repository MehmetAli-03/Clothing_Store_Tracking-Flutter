import 'package:flutter/material.dart';

import 'logİn.dart';

void main() {
  runApp( Home());
}

class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:login(

      ),
    );
  }
}
import 'package:flutter/material.dart';

class Expandflex extends StatelessWidget {
  const Expandflex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample App')),

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.orange,
            alignment: Alignment.center,
            height: 300,
            child: const Text('First', style: TextStyle(fontSize: 20)),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.lightBlue,
              alignment: Alignment.center,
              height: 150,
              child: const Text('Second', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}

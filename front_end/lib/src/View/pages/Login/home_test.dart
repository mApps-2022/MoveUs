import 'package:flutter/material.dart';

class HomeTest extends StatefulWidget {
  const HomeTest({Key? key}) : super(key: key);

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  int a = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text('hola ${a.toString()}'),
            ),
          ),
          FloatingActionButton(
              onPressed: () => {
                    setState(() {
                      a = a + 2;
                      print(a);
                    }),
                  })
        ],
      ),
    );
  }
}

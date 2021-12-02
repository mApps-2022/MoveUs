import 'dart:ffi';

import 'package:flutter/material.dart';

class ButtomWidget extends StatelessWidget {
  const ButtomWidget({Key? key, this.stream, required this.function, required this.text, required this.enebleColor, required this.disableColor}) : super(key: key);

  final Stream? stream;
  final function;
  final String text;
  final Color enebleColor;
  final Color disableColor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: FloatingActionButton.extended(
            backgroundColor: stream == null
                ? enebleColor
                : snapshot.hasData
                    ? enebleColor
                    : disableColor,
            onPressed: stream == null
                ? function
                : snapshot.hasData
                    ? function
                    : null,
            label: Text(text),
          ),
        );
      },
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

class TestScreen extends StatelessWidget {
  double _sigmaX = 9.0; // from 0-10
  double _sigmaY = 9.0; // from 0-10
  double _opacity = 0.0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, position) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  position.toString(),
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
            );
          },
        ),
      ],
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage('images/location_background.jpg'),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   child: BackdropFilter(
    //     filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
    //     child: Container(
    //       color: Colors.black.withOpacity(_opacity),
    //     ),
    //   ),
    // );
  }
}

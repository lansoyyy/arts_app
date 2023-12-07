import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';

class IntroPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Padding(
          padding: EdgeInsets.all(60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image(
                  image: AssetImage(
                    'assets/images/intro-2.png',
                  ),
                  height: 350.0,
                  width: 300.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Discover Art\nand Technology',
                style: kTitleStyle,
              ),
              SizedBox(height: 15.0),
              Text(
                'Our artwork recognition, powered by Convolutional Neural Networks (CNN), allows you to delve deeper into the stories behind each masterpiece.',
                style: kSubtitleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
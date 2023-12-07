import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:flutter/services.dart';

class IntroPage3 extends StatelessWidget {
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
                    'assets/images/intro-3.png',
                  ),
                  height: 350.0,
                  width: 300.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Unlock A new Museum Experience',
                //'Get a new experience\nof imagination
                style: kTitleStyle,
              ),
              SizedBox(height: 15.0),
              Text(
                'Prepare to be amazed as you unlock a new dimension of exploration with our Augmented Reality feature.',
                //'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                style: kSubtitleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
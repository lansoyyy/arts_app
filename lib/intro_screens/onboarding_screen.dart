import 'package:flutter/material.dart';
import '/intro_screens/intro_page_1.dart';
import '/intro_screens/intro_page_2.dart';
import '/intro_screens/intro_page_3.dart';
import '/ui/pages/main_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/constants.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  PageController _controller = PageController();

  // last page or not
  bool onLastPage = false;


  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          scaffoldBackgroundColor: Colors.white, // Set the background color explicitly to white
        ),
    child: Scaffold(
        body: Stack(
          children: [
            PageView (
              controller: _controller,
              onPageChanged: (index){
                setState(() {
                  onLastPage = (index == 2);
                });
              },

              children: [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
              ],
            ),

            Container(
              alignment: Alignment(0,0.75),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // skip
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return MainPage();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: kPrimaryColor,
                      ),
                      child: Text('Skip'),
                    ),

                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: SlideEffect(
                        activeDotColor: kPrimaryColor, // Set the active dot color to kPrimaryColor
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        if (onLastPage) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return MainPage();
                          }
                          )
                          );
                        } else {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: kPrimaryColor, // Set the button's text color
                      ),
                      child: Text(onLastPage ? 'Get Started' : 'Next'),
                    ),
                  ]
              ),
            ),
          ],
        )
    )
    );
  }
}
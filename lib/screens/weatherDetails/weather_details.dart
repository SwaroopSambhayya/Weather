import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:weather/screens/weatherDetails/components/chart.dart';

class WeatherDetails extends StatefulWidget {
  const WeatherDetails({Key? key}) : super(key: key);

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  double textOpacity = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward()
      ..addListener(() {
        if (animationController.isCompleted) {
          animationController.reverse();
          setState(() {
            textOpacity = 1;
          });
        }
      });

    animation = Tween<double>(begin: 140, end: 120).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    ));
  }

  Widget _floatingPanel(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        margin: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              width: 55,
              height: 4,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.all(20.0).copyWith(left: 30, bottom: 10),
                child: const Text(
                  "Future weather",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const FutureWeatherList(
                temp: "15",
                week: "Monday",
                date: "18th August",
                asset: "assets/3dIcons/cloud/17.png"),
            const FutureWeatherList(
                temp: "20",
                week: "Tuesday",
                date: "19th August",
                asset: "assets/3dIcons/sun/8.png"),
            const FutureWeatherList(
                temp: "18",
                week: "Tuesday",
                date: "19th August",
                asset: "assets/3dIcons/sun/26.png"),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SlidingUpPanel(
        minHeight: Platform.isIOS ? 70 : 50,
        maxHeight: MediaQuery.of(context).size.height * 0.65,
        backdropEnabled: true,
        backdropColor: Colors.blue,
        backdropOpacity: 0.4,
        renderPanelSheet: false,
        panel: _floatingPanel(context),
        body: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: 40,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(vertical: 55),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 56, 96, 228),
                    Color(0xff5375E9),
                    Color(0xff40A0EF),
                    Color(0xff77BBF6)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.3, 0.47, 0.6, 0.8]),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: textOpacity,
                    child: Column(
                      children: const [
                        Text(
                          "Los Angeles",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 30),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Chance of rain: 3%",
                          style: TextStyle(
                              color: Color(0xffC9E6FF),
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          left: 30,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: textOpacity,
                            child: const Text(
                              "23°",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 150,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffEAF3FC),
                              ),
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                    MediaQuery.of(context).size.width / 2 - 80,
                                    animation.value),
                                child: Image.asset(
                                  "assets/3dIcons/moon/20.png",
                                  fit: BoxFit.contain,
                                  width: 170,
                                ),
                              );
                            }),
                        Positioned(
                          bottom: 0,
                          left: 30,
                          child: AnimatedOpacity(
                            opacity: textOpacity,
                            duration: const Duration(milliseconds: 500),
                            child: Column(
                              children: const [
                                Text(
                                  "Wind",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "9 km/h",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 30,
                          child: AnimatedOpacity(
                            opacity: textOpacity,
                            duration: const Duration(milliseconds: 500),
                            child: Column(
                              children: const [
                                Text(
                                  "Humidity",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "80%",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ChartDetails(textOpacity: textOpacity),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FutureWeatherList extends StatelessWidget {
  final String temp;
  final String week;
  final String date;
  final String asset;
  const FutureWeatherList({
    Key? key,
    required this.temp,
    required this.week,
    required this.date,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          margin:
              const EdgeInsets.only(left: 30, right: 20, top: 15, bottom: 15),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffE8F2FA), Colors.white],
                  stops: [0.3, 0.9],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              shape: BoxShape.circle),
          child: Center(
            child: Image.asset(
              asset,
              width: 40,
            ),
          ),
        ),
        Flexible(
          child: Container(
            width: 180,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.grey[200]!)),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 25),
              leading: Text(
                "$temp°",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
              title: Text(
                week,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(date, style: const TextStyle(fontSize: 10)),
            ),
          ),
        ),
      ],
    );
  }
}

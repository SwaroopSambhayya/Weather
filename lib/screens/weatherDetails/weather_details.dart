import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/screens/weatherDetails/components/chart.dart';
import 'package:weather/screens/weatherDetails/components/floatingpanel.dart';

class WeatherDetails extends StatefulWidget {
  final Weather weather;
  const WeatherDetails({Key? key, required this.weather}) : super(key: key);

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
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
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

  String getAsset() {
    if (widget.weather.weather![0].icon.contains('d')) {
      return "assets/3dIcons/day/${widget.weather.weather?[0].icon}.png";
    }
    return File("assets/3dIcons/night/${widget.weather.weather?[0].icon}.png")
            .existsSync()
        ? "assets/3dIcons/night/${widget.weather.weather?[0].icon}.png"
        : "assets/3dIcons/day/${widget.weather.weather?[0].icon.replaceFirst("n", "d")}.png";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SlidingUpPanel(
        minHeight: Platform.isIOS ? 70 : 50,
        maxHeight: MediaQuery.of(context).size.height * 0.70,
        backdropEnabled: true,
        backdropColor: Colors.blue,
        backdropOpacity: 0.4,
        renderPanelSheet: false,
        panel: FloatingPanel(
          location: widget.weather.coord!,
        ),
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
                      children: [
                        Text(
                          widget.weather.name!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 30),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.weather.weather![0].description.replaceRange(
                              0,
                              1,
                              widget.weather.weather![0].description[0]
                                  .toUpperCase()),
                          style: const TextStyle(
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
                            child: Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text: '${widget.weather.main!.temp!.floor()}',
                                  style: const TextStyle(
                                    fontSize: 150,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffEAF3FC),
                                  ),
                                ),
                                const WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 40.0,
                                    ),
                                    child: Text(
                                      '°',
                                      style: TextStyle(
                                        fontSize: 80,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 239, 244, 250),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                    MediaQuery.of(context).size.width * 0.6 -
                                        MediaQuery.of(context).size.width / 2.5,
                                    animation.value),
                                child: Image.asset(
                                  getAsset(),
                                  fit: BoxFit.contain,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
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
                              children: [
                                const Text(
                                  "Wind",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${widget.weather.wind!.speed!.round()} m/s",
                                  style: const TextStyle(color: Colors.white),
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
                              children: [
                                const Text(
                                  "Humidity",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${widget.weather.main!.humidity}%",
                                  style: const TextStyle(color: Colors.white),
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

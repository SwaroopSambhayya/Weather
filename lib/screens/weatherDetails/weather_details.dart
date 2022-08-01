import 'package:flutter/material.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                "Los Angeles",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Chance of rain: 3%",
                style: TextStyle(
                    color: Color(0xffC9E6FF),
                    fontWeight: FontWeight.w600,
                    fontSize: 17),
              ),
              Flexible(
                child: SizedBox(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      const Positioned.fill(
                        left: 30,
                        child: Text(
                          "23°",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 150,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffEAF3FC),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        top: 140,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/3dIcons/moon/20.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 30,
                        child: Column(
                          children: const [
                            Text(
                              "Wind",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
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
                      Positioned(
                        bottom: 0,
                        right: 30,
                        child: Column(
                          children: const [
                            Text(
                              "Humidity",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
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
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

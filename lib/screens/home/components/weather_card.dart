import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/screens/weatherDetails/weather_details.dart';

class WeatherCard extends StatelessWidget {
  final double? width;
  final double? height;
  final bool showTimer;
  final String place;
  final double? assetWidth;
  final double? tempFontSize;
  final String temp;
  final EdgeInsetsGeometry? contentPosition;
  const WeatherCard(
      {Key? key,
      this.width,
      this.height,
      this.showTimer = true,
      required this.place,
      required this.temp,
      this.tempFontSize,
      this.contentPosition,
      this.assetWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              child: WeatherDetails(
                weather: Weather(),
              ),
              type: PageTransitionType.fade),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20).copyWith(bottom: 15),
        margin: const EdgeInsets.all(10),
        width: width ?? 260,
        height: height ?? 230,
        decoration: BoxDecoration(
          color: const Color(0xffE8F2FA),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 10,
              child: Image.asset(
                "assets/3dIcons/sun/8.png",
                width: assetWidth ?? 100,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: contentPosition ?? const EdgeInsets.only(left: 10.0),
                  child: Text(
                    place,
                    style: const TextStyle(
                        color: Color(0xff9098AA), fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: contentPosition ?? const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "$temp°",
                    style: TextStyle(
                        fontSize: tempFontSize ?? 45,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (showTimer)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        HourMin(
                          title: "12 :",
                          subtitle: "Hour",
                        ),
                        HourMin(
                          title: "30 :",
                          subtitle: "Min",
                        ),
                        HourMin(
                          title: "56",
                          subtitle: "Sec",
                        )
                      ],
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HourMin extends StatelessWidget {
  final String title;
  final String subtitle;

  const HourMin({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
        ),
        Text(
          subtitle,
          style:
              TextStyle(fontSize: 10, color: Theme.of(context).disabledColor),
        )
      ],
    );
  }
}

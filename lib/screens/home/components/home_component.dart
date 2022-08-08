import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:weather/screens/home/components/weather_card.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({
    Key? key,
    required Animation<Offset> animation,
  })  : _animation = animation,
        super(key: key);

  final Animation<Offset> _animation;

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  getGreeting() {
    if (DateTime.now().hour > 12 && DateTime.now().minute > 0) {
      return "Good Evening";
    }
    return "Good Morning";
  }

  Future<void> getWeather() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget._animation,
      transformHitTests: true,
      textDirection: TextDirection.ltr,
      child: RefreshIndicator(
        onRefresh: getWeather,
        color: const Color(0xff5375E9),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Text(
                    getGreeting(),
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.w600, height: 1.2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    intl.DateFormat('dd MMMM, EEEE').format(DateTime.now()),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                //ErrorComponent(),
                const WeatherLocations(),
                const Favourite()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherLocations extends StatelessWidget {
  const WeatherLocations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) => Container(
              padding: const EdgeInsets.only(left: 10),
              child: const WeatherCard(
                place: "New York",
                temp: "23",
              ),
            )),
        itemCount: 5,
      ),
    );
  }
}

class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your favourite",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15,
          ),
          WeatherCard(
            place: "Los Angeles",
            contentPosition: const EdgeInsets.only(left: 20, top: 5),
            temp: "25",
            assetWidth: 120,
            tempFontSize: 50,
            showTimer: false,
            width: MediaQuery.of(context).size.width,
            height: 175,
          )
        ],
      ),
    );
  }
}

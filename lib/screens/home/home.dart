import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:weather/screens/home/components/weather_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _controller;
  late Animation<Offset> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(1, 0.0),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          setState(() {
            currentIndex = index;
          });
          // controller.animateToPage(selectedIndex,
          //     duration: const Duration(milliseconds: 400),
          //     curve: Curves.easeOutQuad);
        },
        iconSize: 22,
        fontSize: 14,
        activeColor: Theme.of(context).textTheme.bodyText1!.color!,
        selectedIndex: currentIndex,
        barItems: [
          BarItem(
            icon: IconlyLight.home,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.explore_outlined,
            title: 'Explore',
          ),
          BarItem(
            icon: IconlyLight.search,
            title: 'Search',
          ),

          /// Add more BarItem if you want
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: SlideTransition(
            position: _animation,
            transformHitTests: true,
            textDirection: TextDirection.ltr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10),
                  child: Text(
                    "Good Morning",
                    style: TextStyle(
                        fontSize: 35, fontWeight: FontWeight.w600, height: 1.2),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "27 March, Monday",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                WeatherLocations(),
                Favourite()
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

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:weather/screens/home/components/home_component.dart';
import 'package:weather/screens/home/components/search/search_component.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _controller;
  late Animation<Offset> _animation;
  PageController pageController = PageController(initialPage: 0);
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
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
          setState(() {
            currentIndex = index;
          });
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
            icon: IconlyLight.search,
            title: 'Search',
          ),

          /// Add more BarItem if you want
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeComponent(
                animation: _animation,
              ),
              const Search()
            ],
          ),
        ),
      ),
    );
  }
}

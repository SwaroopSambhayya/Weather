import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/api/get_forecast.dart';
import 'package:weather/models/forecast.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/screens/home/components/error_component.dart';

class FloatingPanel extends StatefulWidget {
  final Coord location;

  const FloatingPanel({Key? key, required this.location}) : super(key: key);

  @override
  State<FloatingPanel> createState() => _FloatingPanelState();
}

class _FloatingPanelState extends State<FloatingPanel> {
  late Forecast forecast;
  late bool loading;
  DioError? error;
  late Map<String, List<ListElement>> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getForeCastDetails();
  }

  Future<void> getForeCastDetails() async {
    setState(() {
      loading = true;
    });
    var result = await getForeCast(widget.location);

    if (result is DioError) {
      setState(() {
        error = result;
      });
    } else {
      setState(() {
        forecast = result;
        data = groupBy(
            forecast.list!.toList(), (ListElement e) => e.dtTxt!.split(" ")[0]);
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      margin: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          if (loading)
            const Center(
              child: CupertinoActivityIndicator(
                color: Colors.blue,
              ),
            )
          else ...[
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
            if (error != null)
              Column(
                children: [
                  ErrorComponent(
                    error: error!,
                    illustartionHeight: 250,
                    titleFontSize: 20,
                    subtitleFontSize: 12,
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              )
            else ...[
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
              ...data.entries.map(
                (e) {
                  return FutureWeatherList(
                      temp: e.value[0].main!.temp!.toStringAsPrecision(2),
                      date: e.value[0].dtTxt!,
                      asset: "assets/3dIcons/cloud/17.png");
                },
              ).toList(),
              const SizedBox(height: 50)
            ]
          ],
        ],
      ),
    );
  }
}

class FutureWeatherList extends StatelessWidget {
  final String temp;

  final String date;
  final String asset;
  const FutureWeatherList({
    Key? key,
    required this.temp,
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
                DateFormat('EEEE').format(
                  DateTime.parse(date),
                ),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                  DateFormat('dd, MMMM').format(
                    DateTime.parse(date),
                  ),
                  style: const TextStyle(fontSize: 10)),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather/api/auto_complete.dart';
import 'package:weather/models/place_detail.dart';
import 'package:weather/screens/home/components/error_component.dart';
import 'package:weather/screens/home/components/search/model.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textEditingController = TextEditingController();
  Timer? debounce;
  List<Prediction> predictions = [];

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            "Something went wrong, please try again and make sure you are connectd to network"),
      ),
    );
  }

  search(String input) async {
    var result = await getAutoCompleteList(input);
    if (result is DioError) {
      showSnackBar();
    } else {
      setState(() {
        predictions = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchWeather>(
      create: (context) => SearchWeather(),
      builder: (context, child) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<SearchWeather>(builder: (context, weather, child) {
          return Column(
            children: [
              TextField(
                controller: textEditingController,
                autofocus: true,
                onChanged: (text) {
                  if (text.length >= 3) {
                    if (debounce?.isActive ?? false) debounce!.cancel();
                    debounce = Timer(const Duration(milliseconds: 500), (() {
                      weather.reset();
                      search(text);
                    }));
                  } else {
                    setState(() {
                      predictions = [];
                    });
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: const SizedBox(
                    width: 70,
                    child: Icon(IconlyLight.search),
                  ),
                  hintText: "Search Location",
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none),
                ),
              ),
              Expanded(
                child: weather.error != null
                    ? SingleChildScrollView(
                        child: ErrorComponent(error: weather.error!))
                    : weather.loading
                        ? Lottie.asset('assets/weather.json', width: 200)
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 1,
                              );
                            },
                            itemBuilder: (context, index) => ListTile(
                              onTap: () async {
                                await weather.getWeather(
                                    predictions[index].placeId, this.context);
                              },
                              title: Text(predictions[index]
                                      .structuredFormatting
                                      ?.mainText ??
                                  ""),
                              subtitle: Text(predictions[index]
                                      .structuredFormatting
                                      ?.secondaryText ??
                                  ""),
                            ),
                            itemCount: predictions.length,
                          ),
              )
            ],
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextField(
            controller: textEditingController,
            autofocus: true,
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
          )
        ],
      ),
    );
  }
}

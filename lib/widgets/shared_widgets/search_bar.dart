import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/themes/light_color.dart';

class SearchBar extends StatefulWidget {
  SearchBar(this.filterResults, {Key key}) : super(key: key);

  Function filterResults;

  _SearchBarState searchBarState = _SearchBarState();

  @override
  _SearchBarState createState() {
    return new _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
  bool clearIconVisable = false;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    searchController.addListener(checkText);
    searchController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        height: 65,
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: LightColor.darkgrey,
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Card(
          color: LightColor.moreLightGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                color: Color(0xFF2d2d2d),
                onPressed: () {
                  print("filterResults() -> ${searchController.text}");
                  String searchText = searchController.text;
                  searchController.text = "";
                  widget.filterResults(searchText);
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: TextField(
                    autofocus: false,
                    style: LightColor.blackHintText(),
                    controller: searchController,
                    onChanged: (text) {
                      checkText();
                      print("filterResults()");
                      // widget0.filterResults(searchController.text);
                    },
                    textInputAction: TextInputAction.search,
                    onSubmitted: (text) {
                      print("filterResults() submit");
                      // widget.filterResults(searchController.text);
                    },
                    decoration: InputDecoration.collapsed(
                      filled: true,
                      fillColor: LightColor.moreLightGrey,
                      hintText: tr("SearchProduct"),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: clearIconVisable,
                child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    clearSearchBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkText() {
    setState(() {
      if (searchController.text.isEmpty) {
        clearIconVisable = false;
      } else {
        clearIconVisable = true;
      }
    });
  }

  void clearSearchBox() {
    searchController.clear();
    checkText();
    // widget.filterResults(searchController.text);
  }
}

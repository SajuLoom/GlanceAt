import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glance_at/data/data.dart';
import 'package:glance_at/models/wallpaperModel.dart';
import 'package:glance_at/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;

  const Search({Key key, this.searchQuery}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = new TextEditingController();

  searchWallpaper(String query) async{
    var response =  await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=50"),
        headers: {
          "Authorization" : apiKey,
        }
    );
    // print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      //print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {

    });

  }
  @override
  void initState() {
    searchWallpaper(widget.searchQuery);
    super.initState();
    searchController.text= widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        title: AppName(),
        elevation: 0.0,
        backgroundColor: Colors.white,

      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        searchWallpaper(searchController.text);

                      },
                      child: Container(
                          child: Icon(Icons.search)
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16,),

              wallpaperList(wallpapers: wallpapers,context: context),

            ],
          ),
        ),
      ),
    );
  }
}


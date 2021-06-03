import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glance_at/models/wallpaperModel.dart';
import 'package:glance_at/views/search.dart';
import 'package:glance_at/widgets/widget.dart';
import 'package:glance_at/data/data.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = new TextEditingController();

  homeWallpaper() async{
    var response =  await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=50"),
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
    homeWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search(
                            searchQuery: searchController.text,
                          )));
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



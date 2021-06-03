import 'package:flutter/material.dart';
import 'package:glance_at/models/wallpaperModel.dart';
import 'package:glance_at/views/image.dart';
import 'package:google_fonts/google_fonts.dart';


Widget AppName(){
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, fontFamily: 'Pacifico'),
      children: const <TextSpan>[
        TextSpan(text: 'Glance', style:TextStyle(color: Colors.black45)),
        TextSpan(text: 'At', style: TextStyle(color: Colors.red)),
      ],
    ),
  );
}

Widget wallpaperList({List<WallpaperModel> wallpapers, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(crossAxisCount: 2,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((e){
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(
                imgUrl: e.src.portrait,
              )));
            },
            child: Hero(
              tag: e.src.portrait,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                    child: Image.network(e.src.portrait, fit: BoxFit.cover,)),
              ),
            ),
          ),
      );
      }).toList(),
    ),
  );
}
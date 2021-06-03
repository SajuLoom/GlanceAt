import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';


class ImageView extends StatefulWidget {
  final String imgUrl;
  const ImageView({Key key, this.imgUrl}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

   var filepath;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.imgUrl, fit: BoxFit.cover,)),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    _save();
                  },
                  child: Stack(
                    children: [
                      Container(
                        height : 50 ,
                        width: MediaQuery.of(context).size.width/2,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff1C1B1B).withOpacity(0.8),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0x36FFFFFF),
                                  Color(0x0FFFFFFF)
                                ]
                            )
                        ),
                        child: Column(
                          children: [
                            Text("Download Wallpaper", style: TextStyle(fontSize: 15,color: Colors.white), ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Text("Cancel", style: TextStyle(color: Colors.white),),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ],

      ),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  bool permissionGranted;

  Future _askPermission() async {
    if(await Permission.storage.request().isGranted){
      setState(() {
        permissionGranted = true;
      });
    }
  }


}

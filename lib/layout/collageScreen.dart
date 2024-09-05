import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/img_Providers.dart';

class CollageScreen extends StatefulWidget {
  static const String rountName = 'Collage Screen';

  @override
  State<CollageScreen> createState() => _CollageScreenState();
}

class _CollageScreenState extends State<CollageScreen> {
  List imgs = [];

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ImgProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Colors.black38,
          title: Text("Collage imges",style: TextStyle(
              fontSize: 50,
              fontFamily: "Gemunu Libre",
              // fontWeight: FontWeight.w800,
              color: Colors.pink),),
          centerTitle: true,
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns

          ),
          itemCount: pro.images.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Ink.image(
                image: FileImage(io.File(pro.images[index].path)),
                fit: BoxFit.cover,
                width: 100, // Adjust width as needed
                height: 100, // Adjust height as needed
              ),
            );
          },
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picsart/shared/components/Custom_ElevatedButton.dart';
import 'package:picsart/shared/style/color_manager.dart';
import 'package:provider/provider.dart';
import '../Providers/img_Providers.dart';
import 'dart:io' as io;

import '../shared/components/Custem_showDialog.dart';
import 'collageScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ImgProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'picsart',
          style: TextStyle(
              fontSize: 50, fontFamily: "Gemunu Libre", color: Colors.pink),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: pro.imagePath != null
              ? DecorationImage(
                  image: FileImage(io.File(pro.imagePath!.path)),
                  fit: BoxFit.cover,
                )
              : null,
          gradient: pro.imagePath == null
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.pink,
                    Colors.blueGrey,
                  ],
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                width: 250,
                colorBorder: Colors.black38,
                colorButton: const Color.fromRGBO(0, 0, 0, 0.8),
                colorText: ColorManager.colorWhit,
                text: 'base backgrount',
                OnPressed: () {
                  pro.imagePath = null;
                  setState(() {});
                },
              ), //cancel
              CustomElevatedButton(
                width: 250,
                colorBorder: Colors.black38,
                colorButton: Color.fromRGBO(0, 0, 0, 0.8),
                colorText: ColorManager.colorWhit,
                text: 'Take to backgrount',
                OnPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => CustemshowDialog(
                            onPressedCamera: () {
                              pro.pickImageCamera(context);
                            },
                            onPressedGallary: () {
                              pro.pickImageGallery(context);
                            },
                          ));
                },
              ), //backgrount
              CustomElevatedButton(
                width: 250,
                colorBorder: Colors.black38,
                colorButton: Color.fromRGBO(0, 0, 0, 0.8),
                colorText: ColorManager.colorWhit,
                text: 'Take imgs to collage',
                OnPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => CustemshowDialog(
                            onPressedCamera: () {
                              pro.pickImageCameraCollage(context);
                            },
                            onPressedGallary: () {
                              pro.pickImageGalleryCollage(context);
                              pro.pickImageGalleryCollage(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (C) => CollageScreen()));
                            },
                          ));
                },
              ), //Collage
            ],
          ),
        ),
      ),
    );
  }

  @override
  void NavigateToPhoto() {
    Navigator.pushNamed(context, CollageScreen.rountName);
  }
}

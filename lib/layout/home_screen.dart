import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picsart/shared/components/Custom_ElevatedAccountFill.dart';
import 'package:picsart/shared/components/Custom_ElevatedButton.dart';
import 'package:picsart/shared/style/color_manager.dart';
import 'package:provider/provider.dart';
import '../Providers/img_Providers.dart';
import 'dart:io' as io;

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
              fontSize: 50,
              fontFamily: "Gemunu Libre",
              // fontWeight: FontWeight.w800,
              color: Colors.pink),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration:  BoxDecoration(
          image: pro.imagePath != null
              ? DecorationImage(
            image: FileImage(io.File(pro.imagePath!.path)),
            fit: BoxFit.cover, // Adjust the fit as needed
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
          ) : null,
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
                colorButton: Color.fromRGBO(0, 0, 0, 0.8),
                colorText: ColorManager.colorWhit,
                text: 'Take to backgrount',
                OnPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Choose best way . . . ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                CustomElevatedAccountFill(
                                  icon: Icons.camera_alt_outlined,
                                  text: 'Camera',
                                  onPressed: () {
                                    pro.pickImageCamera();
                                  },
                                  dividerColor: Colors.transparent,
                                ), //Camera
                                SizedBox(
                                  height: 5,
                                ),
                                CustomElevatedAccountFill(
                                  icon: Icons.photo_library_outlined,
                                  text: 'Gallery',
                                  onPressed: () {
                                    pro.pickImageGallery(context);
                                  },
                                  dividerColor: Colors.transparent,
                                ), //Gallery
                                Row(
                                  children: [
                                    SizedBox(width: 200),
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(fontSize: 14),
                                        )) //
                                  ],
                                ) //Cancel
                              ],
                            ),
                          ));
                },
              ),
              CustomElevatedButton(
                width: 250,
                colorBorder: Colors.black38,
                colorButton: Color.fromRGBO(0, 0, 0, 0.8),
                colorText: ColorManager.colorWhit,
                text: 'Take imgs to collage',
                OnPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Choose best way . . . ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 25),

                                CustomElevatedAccountFill(
                                  icon: Icons.camera_alt_outlined,
                                  text: 'Camera',
                                  onPressed: () {
                                     // pro.pickImageCollageCamera(context);
                                  },
                                  dividerColor: Colors.transparent,
                                ), //Camera
                                SizedBox(
                                  height: 5,
                                ),

                                CustomElevatedAccountFill(
                                  icon: Icons.photo_library_outlined,
                                  text: 'Gallery',
                                  onPressed: () {
                                    // pro.pickImageCollageGallery(context);
                                  },
                                  dividerColor: Colors.transparent,
                                ), //Gallery
                                Row(
                                  children: [
                                    SizedBox(width: 200),
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(fontSize: 14),
                                        )) //
                                  ],
                                ) //Cancel
                              ],
                            ),
                          ));
                },
              ),
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

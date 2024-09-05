import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

import '../layout/collageScreen.dart';
import '../layout/photoNavigator.dart';

class ImgProvider extends ChangeNotifier {
  XFile? image;
  XFile? imagePath;
  late PhotoNavigator navigator;
  final picker = ImagePicker();
  List<XFile> images = [];
  List<XFile>? imagePathCollage;

  Future<bool> requestPermissions() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    } else {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        return true;
      } else if (result.isPermanentlyDenied) {
        openAppSettings();
      }
      return false;
    }
  }

  Future<void> pickImageCamera(BuildContext context) async {
    requestPermissions();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      imagePath = imageTemp;
      notifyListeners();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on PlatformException catch (e) {
      return print('Failed to pick image: $e');
    }
  }

  Future<void> pickImageGallery(BuildContext context) async {
    await requestPermissions();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final extension = image.path.split('.').last.toLowerCase();
      if (extension == 'gif') {
        showGifNotAllowedGIF(context);
        return;
      }
      final imageTemp = XFile(image.path);
      imagePath = imageTemp;
      notifyListeners();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> imgPath(bool isCamera) async {
    imagePath = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    print("image path $imagePath");
    notifyListeners();
  }

  Future<bool> confirmAddAnotherImage(BuildContext context) async {
    bool shouldContinue = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you want to capture another image?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (C) => CollageScreen()));
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              shouldContinue = true;
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );

    return shouldContinue;
  }
  Future<void> pickImageCameraCollage(BuildContext context) async {
    final permissionsGranted = await requestPermissions();
    if (!permissionsGranted) {
      print('Permissions not granted');
      return;
    }

    images.clear(); // Clear previous images
    bool shouldContinue = true;

    while (shouldContinue) {
      try {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);
        if (image == null) {
          shouldContinue = false;
          break;
        }

        images.add(XFile(image.path));


        shouldContinue = await confirmAddAnotherImage(context);
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
        shouldContinue = false;
      }
    }

    if (images.isNotEmpty) {
      imagePathCollage =
      List<XFile>.from(images);
      notifyListeners();
      navigator.NavigateToPhoto();
    }
  }

  Future<void> pickImageGalleryCollage(BuildContext context) async {
    final permissionsGranted = await requestPermissions();
    if (!permissionsGranted) {
      print('Permissions not granted');
      return;
    }
    images.clear();

    try {
      final resultList = await MultiImagePicker.pickImages();
      if (resultList == null || resultList.isEmpty) return;

      for (var asset in resultList) {

        final byteData = await asset.getByteData();
        final file = File('${Directory.systemTemp.path}/${asset.name}');
        await file.writeAsBytes(byteData.buffer.asUint8List());
        final extension = file.path.split('.').last.toLowerCase();
        if (extension == 'gif') {
          showGifNotAllowedGIF(context);
          return;
        }
        Navigator.of(context).popUntil((route) => route.isFirst);
        images.add(XFile(file.path));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CollageScreen(),
          ),
        );
      }
      if (images.isNotEmpty) {
        imagePathCollage = List<XFile>.from(images);
        notifyListeners();
      }
    } on Exception catch (e) {
      print('Failed to pick images: $e');
    }
  }

  void showGifNotAllowedGIF(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
          'sorry GIF images are not allowed.',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
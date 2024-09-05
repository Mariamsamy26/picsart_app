import 'package:flutter/material.dart';

import 'Custom_ElevatedAccountFill.dart';
class CustemshowDialog extends StatelessWidget{
  final void Function()? onPressedCamera;
  final void Function()? onPressedGallary;



  const CustemshowDialog({
    required this.onPressedCamera,
    required this.onPressedGallary,
  }) ;

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
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
                  if (onPressedCamera != null) {
                    onPressedCamera!();  // Ensure the function is called
                  }
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
                  if (onPressedGallary != null) {
                    onPressedGallary!();  // Ensure the function is called
                  }
                },

                dividerColor: Colors.transparent,
              ), //Gallery
              Row(
                children: [
                  Spacer(),
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
        );
  }

}
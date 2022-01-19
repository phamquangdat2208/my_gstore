import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

class CustomModalBottomSheet extends StatefulWidget {
  const CustomModalBottomSheet({Key? key}) : super(key: key);

  @override
  _CustomModalBottomSheetState createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  File? imageFile;

  _openGallery(BuildContext context) async {
    var picture =
    await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(picture!.path);
      // injector<LocalApp>().saveStringSharePreference(
      //     KeySaveDataLocal.keySaveImage, imageFile!.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundIconBack,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            height: 48,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 14),
            padding: const EdgeInsets.only(left: 16, top: 13, bottom: 13),
            child: Row(
              children: const [
                Icon(Icons.camera),
                SizedBox(
                  width: 14,
                ),
                Text(
                  "Máy ảnh",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grey9,
                      fontWeight: FontWeight.w400),
                )
              ],
            )),
        CustomGestureDetector(
          child: Container(
              decoration: const BoxDecoration(
                color: AppColors.backgroundIconBack,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              height: 48,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 14),
              padding: const EdgeInsets.only(left: 16, top: 13, bottom: 13),
              child: Row(
                children: const [
                  Icon(Icons.image),
                  SizedBox(
                    width: 14,
                  ),
                  Text(
                    "Thư viện",
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey9,
                        fontWeight: FontWeight.w400),
                  )
                ],
              )),
          onTap: () {
            _openGallery(context);
          },
        ),
      ],
    );
  }
}

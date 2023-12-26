import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/image_list_model.dart';
import '../utils/colors.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//!controller.value.isInitialized

// Function to handle picture taking and gallery selection
/*
// This is using SetState

Future<void> _takeOrPickPicture(ImageSource source) async {
    XFile? pickedFile;
    print('testing');
    // Utilize ImagePicker for both camera and gallery
    final ImagePicker picker = ImagePicker();
    pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      pictures.add(pickedFile);
      setState(() {});
      print('testing 1');
    }
  }*/

// This is using Provider State management
  Future<void> _takeOrPickPicture(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      // Use Provider to manage the image list
      Provider.of<ImageListModel>(context, listen: false).addImage(image);
    }
  }

  // Helper to show dialog to choose between camera and gallery
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Choose option",
            style: TextStyle(color: greenColor, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Text(
                        "Camera",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(
                        (Icons.camera),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  onTap: () {
                    _takeOrPickPicture(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Row(
                    children: [
                      Text(
                        "Gallery",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Icon(
                        (Icons.browse_gallery_outlined),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  onTap: () {
                    _takeOrPickPicture(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      appBar: AppBar(
        backgroundColor: greenColor,
        actions: [
          IconButton(
            onPressed: () {
              _showChoiceDialog(context);
            },
            icon: Icon(
              Icons.add_box_rounded,
              color: Colors.white,
              size: 50.sp,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Image Gallery",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              margin: EdgeInsets.only(top: 30.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recently Added",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Consumer<ImageListModel>(
                        builder: (context, imageList, child) {
                          return imageList.images.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        "No Images\nLet's Take some Image",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: greenColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    InkWell(
                                      onTap: () {
                                        _showChoiceDialog(context);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.h),
                                        child: Card(
                                          elevation: 8.0,
                                          child: Container(
                                            height: 60.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: greenColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Take A Picture",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : GridView.builder(
                                  //itemCount: pictures.length,
                                  itemCount: imageList.images
                                      .length, // Use the length of images from Provider
                                  padding: EdgeInsets.only(top: 10.h),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                  ),
                                  itemBuilder: (ctx, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      child: Image.file(
                                        //File(pictures[index].path),
                                        File(imageList.images[index]
                                            .path), // Use the file from the Provider
                                        height: 60.h,
                                        width: 60.h,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

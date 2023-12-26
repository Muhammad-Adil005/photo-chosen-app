import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'model/image_list_model.dart';
import 'screens/home_screen.dart';

late List<CameraDescription> cameras;
List<XFile> pictures = []; // A global variable to hold the pictures

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const PhotoGalleryApp());
}

class PhotoGalleryApp extends StatelessWidget {
  const PhotoGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return ChangeNotifierProvider(
          create: (context) => ImageListModel(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Photo Gallery App',
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: MyHomePage(),
          ),
        );
      },
    );
  }
}

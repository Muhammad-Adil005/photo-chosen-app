// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'colors.dart';
//
// class CameraPage extends StatefulWidget {
//   CameraPage({super.key, required this.cameras});
//
//   List<CameraDescription> cameras;
//
//   @override
//   State<CameraPage> createState() => _CameraPageState();
// }
//
// class _CameraPageState extends State<CameraPage> {
//   late CameraController controller;
//   void _takePicture() async {
//     int cameraSide = 0;
//     print(controller.description.name);
//     if (controller.description.name == "1") {
//       cameraSide = 0;
//     } else {
//       cameraSide = 1;
//     }
//     controller = CameraController(
//         widget.cameras[cameraSide], ResolutionPreset.max,
//         enableAudio: false);
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       print("INFO: ERROR: Camera error = $e");
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             // Handle access errors here.
//             break;
//           default:
//             // Handle other errors here.
//             break;
//         }
//       }
//     });
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(widget.cameras[0], ResolutionPreset.max,
//         enableAudio: false);
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       print("INFO: ERROR: Camera error = $e");
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             // Handle access errors here.
//             break;
//           default:
//             // Handle other errors here.
//             break;
//         }
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return !controller.value.isInitialized
//         ? const Center(
//             child: CircularProgressIndicator(),
//           )
//         : Scaffold(
//             body: Stack(
//               children: [
//                 Positioned.fill(child: CameraPreview(controller)),
//                 Positioned(
//                   bottom: 30.h,
//                   left: 20.w,
//                   right: 20.w,
//                   child: InkWell(
//                     onTap: () async {
//                       XFile picture = await controller.takePicture();
//                       Navigator.of(context).pop(picture);
//                     },
//                     child: Card(
//                       elevation: 8.0,
//                       child: Container(
//                         height: 60.h,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: greenColor,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(8),
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Take A Picture",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//   }
// }

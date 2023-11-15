// import 'dart:io';
//
// import 'package:travel/src/data/datasources/remote/universal_response.dart';
// Future<UniversalData> imageUploader(XFile xFile) async {
//   String downloadUrl = "";
//   try {
//     final storageRef = FirebaseStorage.instance.ref();
//     var imageRef = storageRef.child("images/profileImages/${xFile.name}");
//     await imageRef.putFile(File(xFile.path));
//     downloadUrl = await imageRef.getDownloadURL();
//
//     return UniversalData(data: downloadUrl);
//   } catch (error) {
//     return UniversalData(error: error.toString());
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart'; //https://pub.dev/packages/path_provider/install

class DartUtils {

  static Future<String?> createFileFromString({required String base64String, required String fileExtension}) async {
    try{
      Uint8List bytes = base64.decode(base64String);
      String dir = (await getApplicationDocumentsDirectory()).path;

      if(fileExtension.contains('.')){
        fileExtension.replaceAll('.', '');
      }

      File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.$fileExtension");
      await file.writeAsBytes(bytes);
      return file.path;
    } catch (error){
      debugPrint('error createFileFromString -> ${error.toString()}');
      return null;
    }
  }

  static Future<String?> getBase64FromFile(String filePath) async {
    try{
      File aux = File.fromUri(Uri.parse(filePath));
      Uint8List? bytesFile;
      await aux.readAsBytes().then((value) {
        bytesFile = Uint8List.fromList(value);
        debugPrint('reading of bytes is completed');
      }).catchError((onError) {
        debugPrint('Exception Error while reading file from path: $onError');
      });
      return base64Encode(bytesFile!);
    } catch (error){
      debugPrint('error getBase64FromFile -> ${error.toString()}');
      return null;
    }
  }

}

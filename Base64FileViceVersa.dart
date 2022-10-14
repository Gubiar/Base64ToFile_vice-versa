import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart'; //https://pub.dev/packages/path_provider/install

class Base64FileViceVersa {

    static Future<String> createPngFileFromString(String encodedStr) async {
    try{
      Uint8List bytes = base64.decode(encodedStr);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
      await file.writeAsBytes(bytes);
      return file.path;
    } catch (error){
      debugPrint('error createPngFileFromString -> ${error.toString()}');
      return null;
    }
  }

  static Future<String> getBase64FromFIle(String filePath) async {
    try{
      File aux = File.fromUri(Uri.parse(filePath));
      Uint8List bytesFile;
      await aux.readAsBytes().then((value) {
        bytesFile = Uint8List.fromList(value);
        debugPrint('reading of bytes is completed');
      }).catchError((onError) {
        debugPrint('Exception Error while reading audio from path: $onError');
      });
      return base64Encode(bytesFile);
    } catch (error){
      debugPrint('error getBase64FromFIle -> ${error.toString()}');
      return null;
    }
  }

}
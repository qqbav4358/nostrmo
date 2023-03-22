import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'string_util.dart';

class StoreUtil {
  String? _basePath;

  static StoreUtil? _storeUtil;

  static Future<StoreUtil> getInstance() async {
    if (_storeUtil == null) {
      _storeUtil = StoreUtil();
      Directory appDocDir = await getApplicationDocumentsDirectory();
      _storeUtil!._basePath = appDocDir.path;
    }
    return _storeUtil!;
  }

  static Future<String> getBasePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return appDocDir.path;
  }

  static Future<String> saveBS2TempFile(String extension, List<int> uint8list,
      {String? randFolderName, String? filename}) async {
    var tempDir = await getTemporaryDirectory();
    var folderPath = tempDir.path;
    if (StringUtil.isNotBlank(randFolderName)) {
      folderPath = folderPath + "/" + randFolderName!;
      checkAndCreateDir(folderPath + "/");
    }
    var tempFilePath =
        folderPath + "/" + StringUtil.rndNameStr(12) + "." + extension;
    if (StringUtil.isNotBlank(filename)) {
      tempFilePath = folderPath + "/" + filename! + "." + extension;
    }

    var tempFile = File(tempFilePath);
    await tempFile.writeAsBytes(uint8list);

    return tempFilePath;
  }

  static Future<void> save2File(String filepath, List<int> uint8list) async {
    var tempFile = File(filepath);
    await tempFile.writeAsBytes(uint8list);
  }

  static String bytesToShowStr(int bytesLength) {
    double bl = bytesLength.toDouble();
    if (bl < 1024) {
      return bl.toString() + " B";
    }

    bl = bl / 1024;
    if (bl < 1024) {
      return bl.toStringAsFixed(2) + " KB";
    }

    bl = bl / 1024;
    if (bl < 1024) {
      return bl.toStringAsFixed(2) + " MB";
    }

    bl = bl / 1024;
    if (bl < 1024) {
      return bl.toStringAsFixed(2) + " GB";
    }

    return "";
  }

  static void checkAndCreateDir(String dirPath) {
    var dir = Directory(dirPath);
    if (!dir.existsSync()) {
      dir.createSync();
    }
  }

  static bool checkDir(String dirPath) {
    var dir = Directory(dirPath);
    return dir.existsSync();
  }
}

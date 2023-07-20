import 'package:dio/dio.dart';
import 'package:nostrmo/util/spider_util.dart';

import '../../consts/base64.dart';

class NostrBuildUploader {
  static var dio = Dio();

  static final String UPLOAD_ACTION = "https://nostr.build/upload.php";

  static Future<String?> upload(String filePath, {String? fileName}) async {
    MultipartFile? multipartFile;
    if (BASE64.check(filePath)) {
      var bytes = BASE64.toData(filePath);
      multipartFile = await MultipartFile.fromBytes(
        bytes,
        filename: fileName,
      );
    } else {
      multipartFile = await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      );
    }

    var formData = FormData.fromMap({"fileToUpload": multipartFile});
    var response = await dio.post<String>(UPLOAD_ACTION, data: formData);
    var body = response.data;
    // TODO this rule need to update by api
    var uploadResult = SpiderUtil.subUntil(body!, "<a id=\"theList\">", "</a>");

    return uploadResult;
  }
}

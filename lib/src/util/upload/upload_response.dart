import 'dart:convert';

import 'package:nosso/src/core/model/uploadFileResponse.dart';

class UploadRespnse {
  response(UploadFileResponse response, String url) {
    var parseJson = json.decode(url);

    response.fileName = parseJson['fileName'];
    response.fileDownloadUri = parseJson['fileDownloadUri'];
    response.fileType = parseJson['fileType'];
    response.size = parseJson['size'];
    return response;
  }
}

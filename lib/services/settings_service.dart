import 'package:mentor_app/models/https/contact_list_upload.dart';
import 'package:mentor_app/models/https/versioning_model.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

class SettingService with Service {
  Future<void> uploadContactList({required UploadContact contacts}) async {
    await repository.callRequest(
        requestType: RequestType.post,
        methodName: MethodNameConstant.uploadContactList,
        postBody: contacts);
  }

  Future<Versioning> getVersions() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.versions,
      queryParam: {"platform": "mentor"},
    );

    return Versioning.fromJson(response);
  }
}

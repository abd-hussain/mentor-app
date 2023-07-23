import 'package:mentor_app/models/https/categories_model.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/models/https/suffix_model.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

import '../models/https/referal_code_request.dart';

class FilterService with Service {
  Future<Suffix> suffix() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.suffix,
    );
    return Suffix.fromJson(response);
  }

  Future<CountriesModel> countries() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      queryParam: {"limit": 100},
      methodName: MethodNameConstant.countries,
    );
    return CountriesModel.fromJson(response);
  }

  Future<CategoriesModel> categories() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.categories,
    );
    return CategoriesModel.fromJson(response);
  }

  Future<bool> validateReferalCode(String code) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.referalCode,
      postBody: ReferalCodeRequest(code: code),
    );
    print(response["data"]);
    return response["data"];
  }
}

import 'package:dio/dio.dart';
import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/models/state.dart';

import 'api_key.dart';

class FilterProvider {
  static const baseUrl = BASE_URL;
  var dio = Dio();

  final _apiKey = APIKEY;

  Future<State> fetchProviderType() async {
    Response response;
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = 'Bearer $_apiKey';

    try {
      response = await dio.get(baseUrl + "/provider-types");
    } on DioError catch (e) {
      if (e.response != null) {
        return State<String>.error(e.response.data['message']);
      } else {
        print(e.request);
        print(e.message);
      }
    }

    List<ProviderType> results = [];
    results = response.data
        .map<ProviderType>((x) => ProviderType.fromJson(x))
        .toList();
    return State<List<ProviderType>>.success(results);
  }

  Future<List> getUnboardingStatus() => Future.delayed(
      Duration(milliseconds: 1), () => ['Pending', 'Active', 'Deleted']);
}

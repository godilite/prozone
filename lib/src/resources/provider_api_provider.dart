import 'package:dio/dio.dart';
import 'package:prozone/src/models/provider_model.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/api_key.dart';

class ProviderApiProvider {
  static const baseUrl = BASE_URL;
  var dio = Dio();

  final _apiKey = APIKEY;

  Future<State> fetchProviderList() async {
    Response response;
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = 'Bearer $_apiKey';

    try {
      response = await dio.get(baseUrl + "/providers");
    } on DioError catch (e) {
      if (e.response != null) {
        return State<String>.error(e.response.data['message']);
      } else {
        print(e.request);
        print(e.message);
      }
    }

    List<ProviderModel> providers = [];
    providers = response.data
        .map<ProviderModel>((x) => ProviderModel.fromJson(x))
        .toList();
    return State<List<ProviderModel>>.success(providers);
  }

  Future<State> searchProviderByName(String name) async {
    Response response;
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = 'Bearer $_apiKey';

    try {
      response = await dio
          .get(baseUrl + "/providers", queryParameters: {"name": name});
    } on DioError catch (e) {
      if (e.response != null) {
        return State<String>.error(e.response.data['message']);
      } else {
        print(e.request);
        print(e.message);
      }
    }

    List<ProviderModel> results = [];
    results = response.data
        .map<ProviderModel>((x) => ProviderModel.fromJson(x))
        .toList();
    return State<List<ProviderModel>>.success(results);
  }

  updateProvider(data, id) async {
    Response response;
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = 'Bearer $_apiKey';

    try {
      response = await dio.put(baseUrl + "/providers/$id", data: data);
    } on DioError catch (e) {
      if (e.response != null) {
        return State<String>.error(e.response.data['message']);
      } else {
        print(e.request);
        print(e.message);
      }
    }

    return State.success(response.statusCode.toString());
  }
}

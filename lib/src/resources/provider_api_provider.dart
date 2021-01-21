import 'package:dio/dio.dart';
import 'package:prozone/src/models/provider_model.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/api_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderApiProvider {
  static const baseUrl = BASE_URL;
  var dio = Dio();

  final _apiKey = APIKEY;

  Future createProvider(data) async {
    Response response;
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = 'Bearer $_apiKey';

    try {
      response = await dio.put(baseUrl + "/providers", data: data);
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

  Future<State> fetchProviderList() async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = 'Bearer $_apiKey';
    List listProviderType = [];
    String stringProviderType = prefs.getString('provider_type');
    if (stringProviderType != null) {
      listProviderType = stringProviderType.split(',');
    }

    String stringStatusFilter = prefs.getString('status');
    List listStatusFilter = [];
    if (stringStatusFilter != null) {
      listStatusFilter = stringStatusFilter.split(',');
    }

    try {
      response = await dio.get(baseUrl + "/providers", queryParameters: {
        'provider_type_in': listProviderType,
        'active_status_in': listStatusFilter
      });
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
      response = await dio.get(baseUrl + "/providers",
          queryParameters: {"name_contains": name});
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

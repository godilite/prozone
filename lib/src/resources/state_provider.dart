import 'package:dio/dio.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/models/state_model.dart';

import 'api_key.dart';

class StateProvider {
  static const baseUrl = BASE_URL;
  var dio = Dio();

  final _apiKey = APIKEY;

  Future<State> fetchProviderStates() async {
    Response response;
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = 'Bearer $_apiKey';

    try {
      response = await dio.get(baseUrl + "/states");
    } on DioError catch (e) {
      if (e.response != null) {
        return State<String>.error(e.response.data['message']);
      } else {
        print(e.request);
        print(e.message);
      }
    }

    List<StateModel> results = [];
    results =
        response.data.map<StateModel>((x) => StateModel.fromJson(x)).toList();
    return State<List<StateModel>>.success(results);
  }
}

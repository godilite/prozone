import 'package:dio/dio.dart';
import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/models/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    List<ProviderType> results = await markFilter(response);
    return State<List<ProviderType>>.success(results);
  }

  Future<List> getUnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringStatusFilter = prefs.getString('status');
    List listStatusFilter = [];
    if (stringStatusFilter != null) {
      listStatusFilter = stringStatusFilter.split(',');
    }

    List onBoardingStatus = ['Pending', 'Active', 'Deleted'];

    final Map<String, dynamic> mapOnBoardingStatus = {};
    List mapOnBoardingStatusList = [];
    mapOnBoardingStatusList = onBoardingStatus.map((e) {
      Map store = new Map.from(mapOnBoardingStatus);
      store['title'] = e;
      if (listStatusFilter.contains(e)) {
        store['status'] = true;
      } else {
        store['status'] = false;
      }
      return store;
    }).toList();
    return Future.delayed(
        Duration(milliseconds: 1), () => mapOnBoardingStatusList);
  }

  Future saveFilter(List selectedItems, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //convert list to string
    String selectedItemsString = selectedItems.join(',');
    if (type == 'provider_type') {
      prefs.setString('provider_type', selectedItemsString);
    } else if (type == 'status') {
      prefs.setString('status', selectedItemsString);
    }
    return;
  }

  Future resetFilters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //convert list to string
    prefs.remove('provider_type');
    prefs.remove('status');
    return;
  }

  Future<List<ProviderType>> markFilter(Response response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<ProviderType> results = [];

    List listProviderType = [];

    String stringProviderType = prefs.getString('provider_type');

    if (stringProviderType != null) {
      listProviderType = stringProviderType.split(',');
    }
    results = response.data.map<ProviderType>((x) {
      ProviderType providerType = ProviderType.fromJson(x);
      if (listProviderType.contains(providerType.id.toString())) {
        providerType.status = true;
      } else {
        providerType.status = false;
      }
      return providerType;
    }).toList();
    return results;
  }
}

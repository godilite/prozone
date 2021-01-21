import 'dart:io';

import 'package:dio/dio.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/api_key.dart';

class ImageProvider {
  static const baseUrl = BASE_URL;
  var dio = Dio();

  final _apiKey = APIKEY;

  List<Asset> images = [];
  Future<List<Asset>> loadAssets() async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
            actionBarColor: "#FAB70A",
            actionBarTitle: "Select photos",
            lightStatusBar: true,
            allViewTitle: "All Photos",
            useDetailsView: true,
            startInAllView: true,
            statusBarColor: "#000000",
            selectCircleStrokeColor: "#FAB70A",
            textOnNothingSelected: 'Select atleast one file'),
      );
    } on Exception {}
    images = resultList;
    return images;
  }

  Future uploadProviderImages(List<File> images, id, model) async {
    Response response;
    dio.options.headers['authorization'] = 'Bearer $_apiKey';

    var formData = FormData(); //Create an instance of formData
    if (images == null || images.isEmpty) {
      return;
    }

    //Add files to formData to remove braket (files[]) in request
    for (File image in images) {
      formData.files.add(
        MapEntry(
          "files",
          MultipartFile.fromFileSync("${image.path}",
              filename: image.path.split('/').last),
        ),
      );
    }

    //Add all fields to formData
    formData.fields.addAll([
      MapEntry(
        "refId",
        id.toString(),
      ),
      MapEntry("ref", model),
      MapEntry("field", 'images')
    ]);

    try {
      response = await dio.post(baseUrl + "/upload/", data: formData);
    } on DioError catch (e) {
      if (e.response != null) {
        return State<String>.error(e.response.statusMessage);
      } else {
        return State<String>.error('Poor internet connection');
      }
    }

    return State.success(response.data);
  }
}

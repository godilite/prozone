import 'package:multi_image_picker/multi_image_picker.dart';

class ImageProvider {
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
}

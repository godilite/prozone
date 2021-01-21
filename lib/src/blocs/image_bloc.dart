import 'dart:io';
import 'dart:typed_data';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prozone/src/resources/repository.dart';
import 'package:prozone/src/ui/shared/routes.dart';
import 'package:rxdart/rxdart.dart';
import 'package:prozone/src/app.dart';

class ImageBloc {
  final BehaviorSubject _imageController = BehaviorSubject<List<File>>();
  Stream get images => _imageController.stream;

  Future selectFiles() async {
    List<Asset> assets = await repository.selectFiles();
    List<File> files = [];
    if (assets.isNotEmpty) {
      for (Asset asset in assets) {
        final file = await writeToFile(asset);
        files.add(file);
      }
      _imageController.sink.add(files);
      navigatorKey.currentState.pushNamed(Routes.PreviewImage);
      return;
    }
  }

  Future<File> writeToFile(Asset asset) async {
    String time = DateTime.now().toIso8601String();

    ByteData byteData = await asset.getByteData();
    final buffer = byteData.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var path = tempPath + '/temp$time.png';

    return new File(path).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }

  void dispose() {
    _imageController.close();
  }
}

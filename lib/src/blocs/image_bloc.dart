import 'dart:io';
import 'dart:typed_data';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prozone/src/app.dart';
import 'package:prozone/src/blocs/provider_bloc.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/repository.dart';
import 'package:prozone/src/ui/shared/routes.dart';
import 'package:rxdart/rxdart.dart';

class ImageBloc {
  final PublishSubject _loadingData = PublishSubject<bool>();
  final BehaviorSubject _hasError = BehaviorSubject<String>();

  Stream get hasError => _hasError.stream;

  Stream<bool> get loading => _loadingData.stream;

  Future selectFiles() async {
    List<Asset> assets = await repository.selectFiles();

    List<File> files = [];

    if (assets.isNotEmpty) {
      for (Asset asset in assets) {
        final file = await writeToFile(asset); //Convert Asset to File
        files.add(file);
      }

      return files;
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

  void submit(List<File> images, id, ref) async {
    _loadingData.sink.add(true);
    State state = await repository.updateImage(images, id, ref);
    if (state is SuccessState) {
      providerBloc.fetchAllProviders();
      navigatorKey.currentState.pushNamed('/');
    } else if (state is ErrorState) {
      _hasError.sink.addError(state.msg);
    }
    _loadingData.sink.add(false);
  }

  void dispose() {
    _loadingData.close();
    _hasError.close();
  }
}

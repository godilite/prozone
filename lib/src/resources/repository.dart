import 'dart:io';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:prozone/src/models/state.dart';
import 'package:prozone/src/resources/provider_api_provider.dart';

import 'filter_provider.dart';
import 'image_provider.dart';

class Repository {
  final ProviderApiProvider _providerApiProvider = ProviderApiProvider();
  final FilterProvider _filterProvider = FilterProvider();
  final ImageProvider _imageProvider = ImageProvider();

  Future<State> fetchProviderList() => _providerApiProvider.fetchProviderList();

  Future<State> searchProviderByName(String name) =>
      _providerApiProvider.searchProviderByName(name);

  Future<State> fetchProviderType() => _filterProvider.fetchProviderType();

  Future<List> fetchStatus() => _filterProvider.getUnboardingStatus();

  Future updateProvider(data, id) =>
      _providerApiProvider.updateProvider(data, id);

  Future<List<Asset>> selectFiles() => _imageProvider.loadAssets();

  Future updateImage(List<File> images, id, model) =>
      _imageProvider.uploadProviderImages(images, id, model);
}

final repository = Repository();

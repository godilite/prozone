import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/models/state_model.dart';

import 'image_model.dart';

class ProviderModel {
  ProviderModel({
    this.id,
    this.name,
    this.description,
    this.rating,
    this.address,
    this.activeStatus,
    this.providerType,
    this.createdAt,
    this.updatedAt,
    this.state,
    this.images,
  });

  int id;
  String name;
  String description;
  int rating;
  String address;
  String activeStatus;
  ProviderType providerType;
  DateTime createdAt;
  DateTime updatedAt;
  StateModel state;
  List<ImageModel> images;

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        rating: json["rating"],
        address: json["address"],
        activeStatus: json["active_status"],
        providerType: ProviderType.fromJson(json["provider_type"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        state: StateModel.fromJson(json["state"]),
        images: List<ImageModel>.from(
            json["images"].map((x) => ImageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "rating": rating,
        "address": address,
        "active_status": activeStatus,
        "provider_type": providerType.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "state": state.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

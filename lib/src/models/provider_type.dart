class ProviderType {
  ProviderType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  bool status;

  factory ProviderType.fromJson(Map<String, dynamic> json) => ProviderType(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      status: json['status']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  ///this method will prevent the override of toString
  String typeAsString() {
    return '${this.name}';
  }
}

class Group {
  String id;
  String avatar;
  String name;

  Group({required this.id, required this.avatar, required this.name});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        id: json["g_id"] as String,
        avatar: json["avatar"],
        name: json["name"] as String);
  }
}

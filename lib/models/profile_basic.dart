class Glance {
  String username;
  String avatar;

  Glance({required this.username, required this.avatar});

  factory Glance.fromJson(Map<String, dynamic> json) {
    return Glance(
        username: json["username"] as String, avatar: json["avatar"] as String);
  }
}

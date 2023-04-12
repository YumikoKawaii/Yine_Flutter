class Role {

  String user;
  String coid;
  String role;
  String nickname;
  String status;

  Role({
    required this.user,
    required this.coid,
    required this.role,
    required this.nickname,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'co_id': coid,
      'role': role,
      'nickname': nickname,
      'status': status
    };
  }

  factory Role.fromJSon(Map<String, dynamic> json) {
    return Role(
      user: json['user'] as String,
      coid: json['co_id'] as String,
      role: json['role'] as String,
      nickname: json['nickname'] as String,
      status: json['status'] as String,
    );
  }
}

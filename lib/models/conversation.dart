class Conversation {

  String type;
  String conv_id;
  String conv_name;
  String conv_avatar;
  String lastest_message;
  DateTime recent;
  int newMessage;

  Conversation({
    required this.type,
    required this.conv_id,
    required this.conv_name,
    required this.conv_avatar,
    required this.lastest_message,
    required this.recent,
    required this.newMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'conv_name': conv_name,
      'conv_avatar': conv_avatar,
      'lastest_message': lastest_message,
    };
  }
}

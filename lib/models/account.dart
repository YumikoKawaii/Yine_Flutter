import 'package:sqflite/sqflite.dart';
import 'package:yine/main.dart';

class Account {
  String id;
  String session;

  Account({required this.id,required this.session});

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'session':session,
    };
  }

  @override
  String toString() {
    return 'Account{id: $id, session:$session}';
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(id: json['id'] as String, session: json['session'] as String);
  }

}

Future<void> insertAccount(Account account) async {
  await database.insert('accounts', account.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<Account> getAccount() async {
  var result = await database.rawQuery('select * from accounts');
  if (result.isEmpty()) {
    return Account(id: "", session: "");
  }
  var item = result.first;
  return Account(id: item['id'] as String, session: item['session'] as String);
}
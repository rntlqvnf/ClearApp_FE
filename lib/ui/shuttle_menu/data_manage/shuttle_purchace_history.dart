import 'dart:convert';
import 'dart:core';

import '../../login/login_info.dart';

@deprecated
class ShuttlePrchHstr {
  String key;
  String name;
  int studentId;
  String usage;
  DateTime date;
  int price;
  int amount;
  List<String> shuttleList;
  bool received;
  bool approved;

  ShuttlePrchHstr(String _usage, int _price, int _amount) {
    studentId = LoginInfo().studentId;
    name = LoginInfo().name;
    usage = _usage;
    date = new DateTime.now();
    price = _price;
    amount = _amount;
    shuttleList = new List<String>();
    received = false;
    approved = false;

    key = studentId.toString() +
        'W' +
        date.toString().replaceAll(new RegExp('\\D'), '');
  }

  ShuttlePrchHstr.fromMap(Map<String, dynamic> map)
      : key = (jsonDecode(map['key']) as String),
        name = (jsonDecode(map['name']) as String),
        studentId = (jsonDecode(map['studentId']) as int),
        usage = jsonDecode(map['usage'] as String),
        date = DateTime.parse(jsonDecode(map['date'])),
        price = (jsonDecode(map['price']) as int),
        amount = (jsonDecode(map['amount']) as int),
        shuttleList = (jsonDecode(map['shuttleList'])).cast<String>(),
        received = (jsonDecode(map['received']) as bool),
        approved = (jsonDecode(map['approved']) as bool);

  Map<String, dynamic> toMap() => {
        'key': key,
        'name': name,
        'studentId': studentId,
        'usage': usage,
        'date': date.toIso8601String(),
        'price': price,
        'amount': (amount),
        'shuttleList': shuttleList,
        'received': received,
        'approved': approved,
      };
}

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wyca/features/request/data/models/request_model.dart';

class Storage {
  static FlutterSecureStorage get prefs => const FlutterSecureStorage();
  static Future<void> rsestData() async => prefs.delete(key: 'newRequests');
  // isFirstKey
  static Future<bool> isFirst() async {
    if ((await prefs.read(key: isFirstKey)) == null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> setPassword(String password) async =>
      prefs.write(key: passKey, value: password);
  static Future<List<RequestClass>> setNewRequests(RequestClass request) async {
    var oldList = await getNewRequests();
    oldList = [
      ...oldList.where((element) => element.id != request.id).toList()
    ];
    if (oldList.map((e) => e.id).toList().contains(request.id)) {
      // await updateNewRequests(request);
      // return;
    }
    oldList = [request, ...oldList];

    final data = jsonEncode(oldList.map((r) => r.toMap()).toList());
    await prefs.write(key: 'newRequests', value: data);
    return oldList;
  }

  static Future<void> updateNewRequests(RequestClass request) async {
    var oldList = await getNewRequests();
    oldList = [...oldList].map((r) {
      return r.id == request.id
          ? request.copyWith(
              provider: r.provider,
              userModel: r.userModel,
              providerModel: r.providerModel,
              notificationDate: r.notificationDate,
            )
          : r;
      // return r;
    }).toList();
    final data = jsonEncode(oldList.map((r) => r.toMap()).toList());
    return prefs.write(key: 'newRequests', value: data);
  }

  static Future<void> removeNewRequests(RequestClass request) async {
    var oldList = await getNewRequests();
    oldList = [...oldList].where((r) {
      return r.id != request.id;
      // return r;
    }).toList();
    final data = jsonEncode(oldList.map((r) => r.toMap()).toList());
    return prefs.write(key: 'newRequests', value: data);
  }

  static Future<List<RequestClass>> getNewRequests() async {
    final string = await prefs.read(key: 'newRequests');
    if (string != null) {
      final decoded = json.decode(string) as List<dynamic>;
      print(decoded);
      return decoded
          .map<RequestClass>(
            (dynamic d) => RequestClass.fromMap(
              d as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      return [];
    }
  }

  static Future<void> deleteNewRequests() async {
    final string = await prefs.delete(key: 'newRequests');
  }

  static Future<void> setUserType(String user) async =>
      prefs.write(key: 'userType', value: user);
  static Future<String?> getUserType() async => prefs.read(key: 'userType');
  static Future<void> removeUserType() async => prefs.delete(key: 'userType');
  static Future<void> setLang(String user) async =>
      prefs.write(key: 'lang', value: user);
  static Future<String?> getLang() async => prefs.read(key: 'lang');
  static Future<String?> getPassword() async => prefs.read(key: passKey);
  static Future<void> setIsFirst() async =>
      prefs.write(key: isFirstKey, value: isFirstKey);
  static Future<void> removeIsFirst() async => prefs.delete(key: isFirstKey);
  static Future<void> removePassword() async => prefs.delete(key: passKey);
}

const isFirstKey = 'isFirstKey';
const passKey = 'pass';

// shared storage for app
// singleton class

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationRequestId {
  NotificationRequestId({required this.id, required this.requestId});
  factory NotificationRequestId.fromMap(Map<String, dynamic> map) {
    return NotificationRequestId(
      id: map['id'] as int,
      requestId: map['requestId'] as String,
    );
  }
  final int id;
  final String requestId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'requestId': requestId,
    };
  }

  // to string
  @override
  String toString() {
    return 'NotificationRequestId(id: $id, requestId: $requestId)';
  }
}

class SharedStorage {
  factory SharedStorage() {
    return _instance;
  }
  SharedStorage._internal();
  static final SharedStorage _instance = SharedStorage._internal();
  final notificationsIdsKey = 'notificationsIdsKey';
  final lastIdKey = 'lastIdKey';

  // saved last id
  Future<void> saveLastId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(lastIdKey, id);
  }

  // get last id

  Future<int> getLastId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt(lastIdKey);
    return id ?? 0;
  }

  // get last id

  Future<NotificationRequestId> saveNotificationId(
    NotificationRequestId notificationId,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(notificationsIdsKey);
    final notificationsIds =
        (data != null ? jsonDecode(data) as List : <dynamic>[])
            .map((dynamic e) =>
                NotificationRequestId.fromMap(e as Map<String, dynamic>))
            .toList();

    // is already saved
    if (notificationsIds.any(
      (element) =>
          element.requestId == notificationId.requestId &&
          element.id == notificationId.id,
    )) {
      return notificationId;
    }
    // save new id
    notificationsIds.add(notificationId);
    await prefs.setString(
      notificationsIdsKey,
      jsonEncode(notificationsIds.map((e) => e.toMap()).toList()),
    );
    return notificationId;
  }

  // get last id

  Future<List<NotificationRequestId>> getNotificationsIds() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsIds = prefs.getStringList(notificationsIdsKey) ?? [];
    return notificationsIds
        .map((e) => NotificationRequestId.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  // get notifications id

  Future<NotificationRequestId?> getNotificationReuestId(
    String requestId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(notificationsIdsKey);

    if (data == null) {
      return null;
    }
    print(jsonDecode(data));
    final notificationsIds = (jsonDecode(data) as List<dynamic>)
        .map(
          (dynamic e) =>
              NotificationRequestId.fromMap(e as Map<String, dynamic>),
        )
        .toList();
    // if exist
    if (notificationsIds.any((element) => element.requestId == requestId)) {
      return notificationsIds.firstWhere(
        (element) => element.requestId == requestId,
      );
    }
    return null;
  }

  Future<int> getNotificationsCount() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsIds = prefs.getStringList(notificationsIdsKey) ?? [];
    return notificationsIds.length;
  }

  Future<int> getNotificationId(String requestId) async {
    var reqId = await getNotificationReuestId(requestId);
    print('*************** $reqId');
    if (reqId == null) {
      final lastId = await getLastId();
      final newId = lastId + 1;
      print('newId $newId');
      reqId = await saveNotificationId(
        NotificationRequestId(id: newId, requestId: requestId),
      );
      await saveLastId(
        reqId.id < lastId ? lastId : reqId.id,
      );
      print('reqId.id ${reqId.id}');
      print('lastId $lastId');
      print(await getLastId());
    }

    return reqId.id;
  }
}

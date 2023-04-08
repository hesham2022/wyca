// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'dart:convert' as c;

import 'package:wyca/features/auth/data/models/provider_registeration_response.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/request/data/models/providerLocation.dart';

class RequestClass {
  RequestClass({
    required this.address,
    required this.status,
    required this.order,
    required this.id,
    required this.user,
    this.confirmStatus = 0,
    required this.package,
    this.userModel,
    this.rated = false,
    this.providerModel,
    this.washNumber,
    this.startDate,
    this.endDate,
    this.provider,
    this.note,
    this.notificationDate,
    this.tryOpened,
    this.providerLocation,
    required this.carPhotos,
    this.canceled = false,
  });

  factory RequestClass.fromMap(Map<String, dynamic> json) {
    return RequestClass(
      address: Address.fromJson(json['address']),
      status: json['status'] as int,
      order: json['order'] as String,
      id: json['id'] as String,
      rated: json['rated'] as bool,
      package: json['package'] as String,
      providerLocation: json['providerLocation'] == null
          ? null
          : ProviderLocation.fromMap(
              json['providerLocation'] as Map<String, dynamic>,
            ),
      washNumber: json['washNumber'] as int?,
      canceled: json['canceled'] == null ? false : json['canceled'] as bool,
      user: json['user'] as String,
      note: json['note'] as String?,
      confirmStatus: json['confirmStatus'] as int,
      tryOpened: json['tryOpened'] as bool?,
      carPhotos: json['carPhotos'] == null
          ? []
          : (json['carPhotos'] as List<dynamic>)
              .map((dynamic e) => e as String)
              .toList(),
      provider: json['provider'] as String?,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      notificationDate: json['notificationDate'] != null
          ? DateTime.parse(json['notificationDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      userModel: json['userModel'] != null
          ? UserModel.fromJson(json['userModel'] as Map<String, dynamic>)
          : null,
      providerModel: json['providerModel'] != null
          ? ProviderModel.fromMap(
              json['providerModel'].runtimeType == String
                  ? c.json.decode(json['providerModel'] as String)
                      as Map<String, dynamic>
                  : json['providerModel'] as Map<String, dynamic>,
            )
          : null,
    );
  }
  set setdate(DateTime date) => notificationDate = date;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? tryOpened;
  DateTime? notificationDate;
  final int confirmStatus;
  bool get isOpened => status == 0;
  bool get isAccepetd => status == 1;
  bool get isStarted => status == 2;
  bool get isDone => status == 3;
  bool get isMissed => status == 4;
  bool get isConfirmIntial => confirmStatus == 0;
  bool get isConfired => confirmStatus == 1;
  bool get isDisConfired => confirmStatus == 2;

  bool canceled;
  String package;
  Address address;
  final bool rated;
  int status;
  String order;
  String id;
  String? provider;
  int? washNumber;
  String? note;
  final String user;
  final ProviderLocation? providerLocation;
  List<String> carPhotos;
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'address': address.toJson(),
      'status': status,
      'order': order,
      'package': package,
      'confirmStatus': confirmStatus,
      'canceled': canceled,
      'user': user,
      'rated': rated,
      'washNumber': washNumber,
      'id': id,
      'tryOpened': tryOpened,
      'startDate': startDate?.toIso8601String(),
      'notificationDate': notificationDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'note': note,
      'carPhotos': carPhotos
    };
    if (provider != null) {
      map['provider'] = provider;
    }
    if (providerLocation != null) {
      map['providerLocation'] = providerLocation!.toMap();
    }
    if (userModel != null) {
      map['userModel'] = userModel!.toJson();
    }
    if (providerModel != null) {
      map['providerModel'] = providerModel!.toJson();
    }
    return map;
  }

  final UserModel? userModel;
  final ProviderModel? providerModel;
  RequestClass copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? confirmStatus,
    DateTime? notificationDate,
    String? user,
    Address? address,
    int? status,
    String? order,
    String? package,
    String? id,
    bool? rated,
    bool? canceled,
    bool? tryOpened,
    int? washNumber,
    List<String>? carPhotos,
    UserModel? userModel,
    ProviderModel? providerModel,
    ProviderLocation? providerLocation,
    String? provider,
  }) {
    return RequestClass(
      provider: provider ?? this.provider,
      id: id ?? this.id,
      carPhotos: carPhotos ?? this.carPhotos,
      order: order ?? this.order,
      startDate: startDate ?? this.startDate,
      address: address ?? this.address,
      package: package ?? this.package,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      status: status ?? this.status,
      endDate: endDate ?? this.endDate,
      canceled: canceled ?? this.canceled,
      providerLocation: providerLocation ?? this.providerLocation,
      rated: rated ?? this.rated,
      tryOpened: tryOpened ?? this.tryOpened,
      notificationDate: notificationDate ?? this.notificationDate,
      user: user ?? this.user,
      washNumber: washNumber ?? this.washNumber,
      userModel: userModel ?? this.userModel,
      providerModel: providerModel ?? this.providerModel,
    );
  }
}

class NewRequestClass {
  NewRequestClass({
    required this.request,
    this.user,
    this.provider,
  }) : date = DateTime.now();
  factory NewRequestClass.fromJson(String source) =>
      NewRequestClass.fromMap(c.json.decode(source) as Map<String, dynamic>);

  factory NewRequestClass.fromMap(Map<String, dynamic> map, [DateTime? date]) {
    print(map['provider'].runtimeType);
    print('_' * 100);
    final e = NewRequestClass(
      request: RequestClass.fromMap(map['request'] as Map<String, dynamic>),
      user: map['user'] != null
          ? UserModel.fromJson(map['user'] as Map<String, dynamic>)
          : null,
      provider: map['provider'] != null
          ? ProviderModel.fromMap(
              map['provider'].runtimeType == String
                  ? c.json.decode(map['provider'] as String)
                      as Map<String, dynamic>
                  : map['provider'] as Map<String, dynamic>,
            )
          : null,
    );
    if (date != null) {
      e.setdate = date;
    }

    return e;
  }
  final RequestClass request;
  final UserModel? user;
  final ProviderModel? provider;

  DateTime date;
  // ignore: avoid_setters_without_getters
  set setdate(DateTime date) => this.date = date;
  NewRequestClass copyWith({
    RequestClass? request,
    UserModel? user,
    ProviderModel? provider,
    DateTime? date,
  }) {
    final r = NewRequestClass(
      request: request ?? this.request,
      user: user ?? this.user,
      provider: provider ?? this.provider,
    )..setdate = this.date;
    return r;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'request': request.toMap(),
      'date': date.toIso8601String()
    };

    if (user != null) {
      map['user'] = user!.toJson();
    }
    if (provider != null) {
      map['provider'] = provider!.toJson();
    }
    return map;
  }

  String toJson() => c.json.encode(toMap());

  @override
  String toString() => 'NewRequestClass(request: $request, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewRequestClass &&
        other.request == request &&
        other.user == user &&
        other.provider == provider;
  }

  @override
  int get hashCode => request.hashCode ^ user.hashCode;
}

import 'package:wyca/features/auth/data/models/user_model.dart';

class CreateRequestParams {
  CreateRequestParams({
    required this.address,
    required this.order,
    this.date,
  });
  factory CreateRequestParams.fromMap(Map<String, dynamic> json) =>
      CreateRequestParams(
        address: Address.fromJson(json['address']),
        order: json['order'] as String,
      );
  final DateTime? date;

  Address address;
  String order;

  Map<String, dynamic> toMap() {
   
    final map = <String, dynamic>{
      'address': address.toJson(),
      'order': order,
    };
    if (date != null) {
      map['date'] = date!.toIso8601String();
    }
    return map;
  }
}

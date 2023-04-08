import 'dart:convert';

class OrderModel {
  OrderModel({
    required this.package,
    required this.washNumber,
    required this.user,
    required this.id,
    this.paymentLink,
  });
  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      package: map['package'] as String? ?? '',
      washNumber: map['washNumber'] as int,
      user: map['user'] as String? ?? '',
      id: map['id'] as String,
      paymentLink: map['paymentLink'] as String?,
    );
  }
  final String package;
  final String? paymentLink;

  final int washNumber;
  final String user;
  final String id;

  OrderModel copyWith({
    String? package,
    int? washNumber,
    String? user,
    String? id,
    String? paymentLink,
  }) {
    return OrderModel(
      package: package ?? this.package,
      washNumber: washNumber ?? this.washNumber,
      user: user ?? this.user,
      paymentLink: paymentLink ?? this.paymentLink,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'package': package,
      'washNumber': washNumber,
      'user': user,
      'id': id,
      'paymentLink': paymentLink
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'OrderModel(package: $package, washNumber: $washNumber, user: $user, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.package == package &&
        other.washNumber == washNumber &&
        other.user == user &&
        other.id == id &&
        other.paymentLink == paymentLink;
  }

  @override
  int get hashCode {
    return package.hashCode ^
        washNumber.hashCode ^
        user.hashCode ^
        id.hashCode ^
        paymentLink.hashCode;
  }
}

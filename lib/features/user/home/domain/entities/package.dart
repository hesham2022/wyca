import 'package:wyca/features/user/home/data/models/package_model.dart';

class Package {
  Package({
    required this.isOffer,
    required this.name,
    required this.price,
    required this.priceDiscount,
    required this.washNumber,
    required this.description,
     this.byPoint,
    required this.image,
    required this.features,
    required this.id,
  });

  final int? byPoint;
  final bool isOffer;
  final String name;
  final int price;
  final int priceDiscount;
  final int washNumber;
  final String description;
  final String image;
  final List<Feature> features;
  final String id;
}

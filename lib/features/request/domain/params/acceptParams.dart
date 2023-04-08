class AcceptParams {
  AcceptParams({
    required this.id,
    required this.coordinates,
  });

  final String id;
  final List<double> coordinates;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      
      'coordinates': coordinates,
    };
  }
}


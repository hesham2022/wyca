import 'dart:convert';

class RatingParams {
  RatingParams({
    required this.review,
    required this.request,
    required this.rating,
    required this.provider,
  });

  final String review;
  final String request;

  final double rating;
  final String provider;

  RatingParams copyWith({
    String? review,
    double? rating,
    String? provider,
    String? request,
    String? appointmentId,
  }) {
    return RatingParams(
      review: review ?? this.review,
      rating: rating ?? this.rating,
      provider: provider ?? this.provider,
      request: request ?? this.request,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'review': review,
      'rating': rating,
      'provider': provider,
      'request': request,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'RatingParams(review: $review, rating: $rating, provider: $provider)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RatingParams &&
        other.review == review &&
        other.rating == rating &&
        other.provider == provider;
  }

  @override
  int get hashCode => review.hashCode ^ rating.hashCode ^ provider.hashCode;
}

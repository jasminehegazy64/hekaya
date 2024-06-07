import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final int maxRating;
  final double starSize;
  final Color filledStarColor;
  final Color emptyStarColor;

  StarRating({
    Key? key,
    required this.rating,
    this.maxRating = 5,
    this.starSize = 24.0,
    this.filledStarColor = Colors.yellow,
    this.emptyStarColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(maxRating, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: starSize,
          color: index < rating ? filledStarColor : emptyStarColor,
        );
      }),
    );
  }
}

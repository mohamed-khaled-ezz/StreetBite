import 'package:flutter/material.dart';

/// Loads a TheMealDB thumbnail (the API supports /small, /medium, /large).
class NetworkMealImage extends StatelessWidget {
  const NetworkMealImage({super.key, required this.url, this.size = 'medium'});

  final String url;
  final String size;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Center(child: Icon(Icons.restaurant)),
    );
    if (url.isEmpty) return placeholder;

    return Image.network(
      '$url/$size',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => placeholder,
      loadingBuilder: (_, child, progress) =>
          progress == null ? child : placeholder,
    );
  }
}

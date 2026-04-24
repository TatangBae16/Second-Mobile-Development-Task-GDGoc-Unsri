import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded mencegah overflow di dalam GridView
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Bonus: Hero Animation
                  Hero(
                    tag: 'image_${product.id}',
                    child: Container(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Icon(Icons.shopping_bag, size: 60, color: Theme.of(context).colorScheme.onSecondaryContainer),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Semantics(
                      label: 'Tombol Favorit',
                      child: IconButton(
                        icon: Icon(
                          product.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: product.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: onFavoriteToggle,
                        style: IconButton.styleFrom(backgroundColor: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${product.price.toStringAsFixed(0)}',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
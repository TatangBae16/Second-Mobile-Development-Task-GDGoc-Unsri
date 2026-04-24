import 'package:flutter/material.dart';
import '../models/product.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Product product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ambil data argument, lalu cari referensi terbarunya di list lokal
    final args = ModalRoute.of(context)!.settings.arguments as Product;
    product = dummyProducts.firstWhere((p) => p.id == args.id, orElse: () => args);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Tombol Edit di pojok kanan atas
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Produk',
            onPressed: () async {
              // Buka halaman form dengan mengirim data produk saat ini
              final result = await Navigator.pushNamed(context, '/form', arguments: product);

              // Jika result true (ada yang di-save), refresh halaman detail
              if (result == true) {
                setState(() {
                  product = dummyProducts.firstWhere((p) => p.id == product.id);
                });
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'image_${product.id}',
                child: Container(
                  height: 300,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Icon(Icons.shopping_bag, size: 100, color: Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            product.name,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold, // 👈 Bisa diubah jadi FontWeight.w900 atau normal
                              fontSize: 24, // 👈 Bisa tambah parameter fontSize manual jika ingin lebih besar
                            ),
                          ),
                        ),
                        Icon(
                          product.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: product.isFavorite ? Colors.red : Colors.grey,
                          size: 32,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        product.category,
                        style: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Rp ${product.price.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: 24),
                    Text('Deskripsi Produk', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
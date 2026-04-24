import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Fungsi dipanggil untuk mereload halaman home jika ada data baru/favorit berubah
  void _refreshData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Pengaturan',
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Ringkasan Data
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.inventory),
                  const SizedBox(width: 8),
                  Text('Total Produk: ${dummyProducts.length}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/form');
                      _refreshData(); // Refresh jika ada produk baru ditambah
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah'),
                  )
                ],
              ),
            ),
            // Responsive Grid Layout
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 1;
                  // Breakpoints sesuai tugas
                  if (constraints.maxWidth >= 1000) {
                    crossAxisCount = 4; // Desktop
                  } else if (constraints.maxWidth >= 600) {
                    crossAxisCount = 2; // Tablet
                  } // else Mobile (1)

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: dummyProducts.length,
                    itemBuilder: (context, index) {
                      final product = dummyProducts[index];
                      return ProductCard(
                        product: product,
                        onFavoriteToggle: () {
                          setState(() {
                            product.isFavorite = !product.isFavorite;
                          });
                        },
                        onTap: () async {
                          // Bonus: Custom Transition dengan PageRouteBuilder
                          await Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const DetailScreen(),
                              settings: RouteSettings(arguments: product),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                            ),
                          );
                          _refreshData(); // Refresh state favorit saat kembali
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
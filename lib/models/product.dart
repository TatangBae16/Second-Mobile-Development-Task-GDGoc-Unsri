class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    this.isFavorite = false,
  });
}

// Data lokal hardcoded (Tanpa API/Database)
List<Product> dummyProducts = [
  Product(id: '1', name: 'Sepatu Sneakers X', category: 'Sepatu', price: 750000, description: 'Sepatu casual cocok untuk jalan-jalan dengan bahan kanvas premium.'),
  Product(id: '2', name: 'Tas Ransel Pro', category: 'Tas', price: 450000, description: 'Tas ransel laptop 15 inch anti air dengan banyak kompartemen.'),
  Product(id: '3', name: 'Jaket Denim Vintage', category: 'Pakaian', price: 550000, description: 'Jaket denim tebal gaya retro, cocok untuk udara dingin.'),
  Product(id: '4', name: 'Jam Tangan Minimalis', category: 'Aksesoris', price: 1200000, description: 'Jam tangan analog dengan strap kulit asli dan kaca safir.'),
  Product(id: '5', name: 'Topi Baseball Polo', category: 'Aksesoris', price: 150000, description: 'Topi baseball katun dengan strap yang bisa disesuaikan.'),
];
import 'package:flutter/material.dart';
import '../models/product.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _category = '';
  String _price = '';
  String _description = '';

  bool _isDataChanged = false;
  Product? _existingProduct; // Untuk menyimpan data jika sedang mode Edit
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Menangkap argument jika form dibuka dari tombol Edit
    if (!_isInit) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Product) {
        _existingProduct = args;
        _name = _existingProduct!.name;
        _category = _existingProduct!.category;
        _price = _existingProduct!.price.toStringAsFixed(0);
        _description = _existingProduct!.description;
      }
      _isInit = true;
    }
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_existingProduct != null) {
        // MODE EDIT
        final index = dummyProducts.indexWhere((p) => p.id == _existingProduct!.id);
        if (index != -1) {
          dummyProducts[index] = Product(
            id: _existingProduct!.id, // ID tetap sama
            name: _name,
            category: _category,
            price: double.tryParse(_price) ?? 0,
            description: _description,
            isFavorite: _existingProduct!.isFavorite, // Status favorit dipertahankan
          );
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produk berhasil diperbarui!')),
        );
      } else {
        // MODE TAMBAH
        final newProduct = Product(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: _name,
          category: _category,
          price: double.tryParse(_price) ?? 0,
          description: _description,
        );
        dummyProducts.add(newProduct);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produk berhasil ditambahkan!')),
        );
      }

      Navigator.pop(context, true); // Kembali dan kirim sinyal 'true' bahwa ada perubahan
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ubah judul AppBar dinamis
    final isEditMode = _existingProduct != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Produk' : 'Tambah Produk'),
      ),
      body: PopScope(
        canPop: !_isDataChanged,
        onPopInvoked: (didPop) async {
          if (didPop) return;

          final bool? shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Batal menyimpan?'),
              content: const Text('Perubahan data yang belum disimpan akan hilang.'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Tidak')),
                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Ya')),
              ],
            ),
          );

          if (shouldPop ?? false) {
            if (context.mounted) Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              onChanged: () {
                if (!_isDataChanged) {
                  setState(() => _isDataChanged = true);
                }
              },
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _name, // Tampilkan data lama jika ada
                    decoration: const InputDecoration(labelText: 'Nama Produk', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Nama produk tidak boleh kosong';
                      if (value.length < 3) return 'Nama minimal 3 karakter';
                      return null;
                    },
                    onSaved: (value) => _name = value!,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _category,
                    decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder()),
                    validator: (value) => value == null || value.isEmpty ? 'Kategori harus diisi' : null,
                    onSaved: (value) => _category = value!,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _price,
                    decoration: const InputDecoration(labelText: 'Harga', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Harga harus diisi';
                      if (double.tryParse(value) == null) return 'Harga harus berupa angka';
                      return null;
                    },
                    onSaved: (value) => _price = value!,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _description,
                    decoration: const InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
                    maxLines: 4,
                    validator: (value) => value == null || value.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
                    onSaved: (value) => _description = value!,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: _saveProduct,
                      child: Text(isEditMode ? 'Simpan Perubahan' : 'Simpan Produk', style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
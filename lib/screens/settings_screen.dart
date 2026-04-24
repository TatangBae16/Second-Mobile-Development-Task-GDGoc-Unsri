import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil state dari _MyAppState untuk mengubah tema
    final appState = MyApp.of(context);
    final isDark = appState?.isDarkMode ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tampilan', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Aktifkan mode gelap aplikasi'),
                // Accessibility: Semantics digunakan untuk pembaca layar (Screen Reader)
                trailing: Semantics(
                  label: 'Toggle mode gelap',
                  child: Switch.adaptive( // Bonus: Adaptive widget (tampilan menyesuaikan iOS/Android)
                    value: isDark,
                    onChanged: (bool value) {
                      appState?.changeTheme(value ? ThemeMode.dark : ThemeMode.light);
                    },
                  ),
                ),
              ),
              const Divider(),
              const Spacer(), // Layout dasar
              const Center(
                child: Text('App Version 1.0.0', style: TextStyle(color: Colors.grey)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
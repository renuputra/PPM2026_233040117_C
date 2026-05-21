import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello Flutter'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Emoji
              const Text('👋', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),

              // Nama
              const Text(
                'Halo, Renu!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Deskripsi
              const Text(
                'Selamat datang di dunia Flutter.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

              // 🔥 Kartu Profil
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NIM: 233040117'),
                    SizedBox(height: 4),
                    Text('Prodi: Teknik Informatika'),
                    SizedBox(height: 4),
                    Text('Semester: 6'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 🔥 Tombol
              ElevatedButton(
                onPressed: () {
                  print('Tombol ditekan!');
                },
                child: const Text('Tap Saya'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
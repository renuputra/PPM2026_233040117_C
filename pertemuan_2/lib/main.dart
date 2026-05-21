import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TUGAS MANDIRI 2: Mengubah theme color Scaffold menjadi warna soft
      backgroundColor: const Color(0xFFF4F6F9), // Warna abu-abu kebiruan soft

      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Menyesuaikan warna teks dengan appbar terang
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader( // Menambahkan const agar rapi
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            const ListTile(leading: Icon(Icons.home), title: Text('Beranda')),
            const ListTile(leading: Icon(Icons.person), title: Text('Profil')),

            // TUGAS MANDIRI 5: AlertDialog pada item Pengaturan
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer terlebih dahulu
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Pengaturan'),
                    content: const Text('Fitur pengaturan belum tersedia.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const ListTile(leading: Icon(Icons.info), title: Text('Tentang')),

            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context); // Menutup drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GalleryHome()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  // TUGAS MANDIRI 1: Mengganti CircleAvatar dengan AssetImage dari folder lokal
                  const CircleAvatar(
                    radius: 50,
                    // Pastikan nama file di bawah ini sesuai dengan foto di folder assets Anda
                    backgroundImage: AssetImage('asset/foto_saya1.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Renu Resdina Putra',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mahasiswa Teknik Informatika Unpas',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(child: StatBox(label: 'Post', value: '10')),
                Expanded(child: StatBox(label: 'Teman', value: '978')),
                Expanded(child: StatBox(label: 'Like', value: '2k')),
              ],
            ),
            const SizedBox(height: 24),
            const SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',
              content: 'Saat ini saya berfokus pada pengembangan MVP dashboard sistem keuangan klinik dan pembuatan aplikasi Word Reminder.',
            ),
            const SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content: 'Teknik Informatika\nFokus: UI/UX Design & Mobile Dev',
            ),

            // TUGAS MANDIRI 3: Section ke-5 berjudul "Skills" berisi Wrap dan 5 Chip
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.star, color: Colors.blue, size: 28),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Skills', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8, // Jarak horizontal
                            runSpacing: 8, // Jarak vertikal jika turun baris
                            children: const [
                              Chip(label: Text('Flutter')),
                              Chip(label: Text('Android Studio')),
                              Chip(label: Text('UI/UX Design')),
                              Chip(label: Text('Dart')),
                              Chip(label: Text('Figma')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),

      // TUGAS MANDIRI 4: Menampilkan SnackBar saat FAB ditekan
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Edit profil belum tersedia'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        label: const Text('Edit'),
        icon: const Icon(Icons.edit),
      ),

      // TUGAS MANDIRI 6: Mengganti BottomNavigationBar menjadi NavigationBar (Material 3)
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (int index) {},
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
          NavigationDestination(icon: Icon(Icons.message), label: 'Pesan'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}

// === HELPER WIDGETS ===
class StatBox extends StatelessWidget {
  final String label;
  final String value;
  const StatBox({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const SectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white, // Menyamakan warna latar dengan card Skills
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(content, style: const TextStyle(height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      ('Display', Icons.image, Colors.indigo),
      ('Input', Icons.edit, Colors.teal),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Gallery')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final (name, icon, color) = categories[i];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
              title: Text(name),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage(name: name)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String name;
  const CategoryPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    Widget bodyContent = Center(child: Text('Konten kategori $name'));

    if (name == 'Display') bodyContent = const DisplayDemo();
    if (name == 'Input') bodyContent = const InputDemo();

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: bodyContent,
      ),
    );
  }
}

class DisplayDemo extends StatelessWidget {
  const DisplayDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Card', style: TextStyle(fontWeight: FontWeight.bold)),
        Card(
          child: ListTile(
            leading: Icon(Icons.album),
            title: Text('Judul Item'),
            subtitle: Text('Sub-judul'),
          ),
        ),
        SizedBox(height: 16),
        Text('Chip', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          children: [
            Chip(label: Text('Flutter')),
            Chip(label: Text('Dart')),
            Chip(label: Text('Mobile')),
          ],
        ),
        SizedBox(height: 16),
        Text('Badge (Widget Tambahan)', style: TextStyle(fontWeight: FontWeight.bold)),
        Badge(
          label: Text('3'),
          child: Icon(Icons.notifications, size: 40),
        ),
      ],
    );
  }
}

class InputDemo extends StatelessWidget {
  const InputDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('TextField'),
        SizedBox(height: 4),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nama',
            hintText: 'Ketik nama Anda',
          ),
        ),
      ],
    );
  }
}
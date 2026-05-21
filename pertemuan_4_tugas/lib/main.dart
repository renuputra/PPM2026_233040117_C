import 'package:flutter/material.dart';

// ============================================================
// ENTRY POINT
// ============================================================
void main() {
  runApp(const MyApp());
}

// ============================================================
// MODEL — Catatan
// ============================================================
class Catatan {
  final String judul;
  final String isi;
  final String kategori;
  final DateTime dibuatPada;

  Catatan({
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.dibuatPada,
  });
}

// ============================================================
// ROOT APP — MaterialApp + Named Routes
// ============================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/tambah':
          // arguments bisa null (mode tambah) atau Catatan (mode edit)
            final catatanLama = settings.arguments as Catatan?;
            return MaterialPageRoute(
              builder: (_) => TambahCatatanPage(catatanLama: catatanLama),
            );
          case '/detail':
            final catatan = settings.arguments as Catatan;
            return MaterialPageRoute(
              builder: (_) => DetailCatatanPage(catatan: catatan),
            );
        }
        return null;
      },
    );
  }
}

// ============================================================
// HALAMAN 1 — HomePage (StatefulWidget)
// ============================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Catatan> _catatan = [
    Catatan(
      judul: 'Belajar Flutter',
      isi: 'Mempelajari Stateful Widget, Form, dan Navigation.',
      kategori: 'Kuliah',
      dibuatPada: DateTime.now(),
    ),
  ];

  String _formatTanggal(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}  '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }

  // Mode TAMBAH — tidak kirim arguments
  Future<void> _bukaTambahCatatan() async {
    final hasil = await Navigator.pushNamed(context, '/tambah');
    if (hasil is Catatan) {
      setState(() => _catatan.add(hasil));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan "${hasil.judul}" ditambahkan!')),
      );
    }
  }

  // Mode EDIT — kirim catatan lama sebagai arguments, lalu replace di index
  Future<void> _bukaEditCatatan(int index) async {
    final hasil = await Navigator.pushNamed(
      context,
      '/tambah',
      arguments: _catatan[index], // <-- kirim data lama
    );
    if (hasil is Catatan) {
      setState(() => _catatan[index] = hasil); // replace, bukan add
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan "${hasil.judul}" diperbarui!')),
      );
    }
  }

  void _hapusCatatan(int index) {
    final judul = _catatan[index].judul;
    setState(() => _catatan.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Catatan "$judul" dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Mahasiswa'),
        centerTitle: true,
      ),
      body: _catatan.isEmpty
          ? const _EmptyState()
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _catatan.length,
        itemBuilder: (context, i) {
          final c = _catatan[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                child: Text(c.judul[0].toUpperCase()),
              ),
              title: Text(
                c.judul,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Chip(
                    label: Text(c.kategori,
                        style: const TextStyle(fontSize: 11)),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                  Text(
                    _formatTanggal(c.dibuatPada),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              // Tombol Edit & Hapus berdampingan
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined,
                        color: Colors.indigo),
                    onPressed: () => _bukaEditCatatan(i),
                    tooltip: 'Edit',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.red),
                    onPressed: () => _hapusCatatan(i),
                    tooltip: 'Hapus',
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/detail', arguments: c);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaTambahCatatan,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }
}

// Widget empty state
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_alt_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('Belum ada catatan',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600)),
          const SizedBox(height: 8),
          Text('Tekan tombol Tambah untuk mulai',
              style: TextStyle(color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}

// ============================================================
// HALAMAN 2 — TambahCatatanPage (reuse untuk Tambah & Edit)
// ============================================================
class TambahCatatanPage extends StatefulWidget {
  // Kalau null = mode Tambah, kalau ada isinya = mode Edit
  final Catatan? catatanLama;
  const TambahCatatanPage({super.key, this.catatanLama});

  @override
  State<TambahCatatanPage> createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judulCtrl;
  late final TextEditingController _isiCtrl;
  late String _kategori;

  final _kategoriOpsi = const ['Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];

  // Cek apakah sedang mode edit
  bool get _isEdit => widget.catatanLama != null;

  @override
  void initState() {
    super.initState();
    // Kalau mode edit: isi field dengan data lama
    // Kalau mode tambah: field kosong
    _judulCtrl =
        TextEditingController(text: widget.catatanLama?.judul ?? '');
    _isiCtrl =
        TextEditingController(text: widget.catatanLama?.isi ?? '');
    _kategori = widget.catatanLama?.kategori ?? 'Kuliah';
  }

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final hasil = Catatan(
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      // Mode edit: pertahankan tanggal asli. Mode tambah: pakai sekarang.
      dibuatPada: widget.catatanLama?.dibuatPada ?? DateTime.now(),
    );

    Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Judul AppBar berubah sesuai mode
        title: Text(_isEdit ? 'Edit Catatan' : 'Tambah Catatan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Indikator mode edit
            if (_isEdit)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        size: 16, color: Colors.indigo.shade700),
                    const SizedBox(width: 8),
                    Text(
                      'Mode Edit — ubah data lalu tekan Simpan',
                      style: TextStyle(
                          color: Colors.indigo.shade700, fontSize: 13),
                    ),
                  ],
                ),
              ),

            // Field Judul
            TextFormField(
              controller: _judulCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Judul',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Judul wajib diisi';
                if (v.trim().length < 3) return 'Minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Dropdown Kategori
            DropdownButtonFormField<String>(
              value: _kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: _kategoriOpsi
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (v) => setState(() => _kategori = v!),
            ),
            const SizedBox(height: 16),

            // Field Isi
            TextFormField(
              controller: _isiCtrl,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Isi',
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Isi wajib diisi' : null,
            ),
            const SizedBox(height: 24),

            // Tombol Simpan (labelnya berubah sesuai mode)
            FilledButton.icon(
              onPressed: _simpan,
              icon: Icon(_isEdit ? Icons.update : Icons.save),
              label: Text(_isEdit ? 'Perbarui Catatan' : 'Simpan'),
            ),
            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Batal'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailCatatanPage extends StatelessWidget {
  final Catatan catatan;
  const DetailCatatanPage({super.key, required this.catatan});

  String _formatTanggal(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}  '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        actions: [
          // Tombol Edit di AppBar — buka form dengan data catatan ini
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit catatan ini',
            onPressed: () async {
              final hasil = await Navigator.pushNamed(
                context,
                '/tambah',
                arguments: catatan, // kirim data catatan ke form
              );
              // Setelah edit, kembali ke Home sambil bawa hasil baru
              // agar HomePage bisa update list-nya
              if (hasil is Catatan && context.mounted) {
                Navigator.pop(context, hasil);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              catatan.judul,
              style: const TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Chip(
                  label: Text(catatan.kategori),
                  avatar: const Icon(Icons.label_outline, size: 16),
                ),
                const SizedBox(width: 12),
                Text(
                  _formatTanggal(catatan.dibuatPada),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 32),
            Text(
              catatan.isi,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Daftar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
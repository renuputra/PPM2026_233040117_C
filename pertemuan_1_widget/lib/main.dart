import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedLatihan = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Latihan Widget'),
          backgroundColor: Colors.blue,
        ),

        body: Column(
          children: [
            // 🔽 Dropdown pilih latihan
            Padding(
              padding: const EdgeInsets.all(16),
              child: DropdownButton<int>(
                value: selectedLatihan,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Latihan 1 - Text')),
                  DropdownMenuItem(value: 2, child: Text('Latihan 2 - Container')),
                  DropdownMenuItem(value: 3, child: Text('Latihan 3 - Row')),
                  DropdownMenuItem(value: 4, child: Text('Latihan 4 - Icon')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedLatihan = value!;
                  });
                },
              ),
            ),

            // 🔥 Tampilan latihan
            Expanded(
              child: Center(
                child: buildLatihan(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 SWITCH LATIHAN
  Widget buildLatihan() {
    switch (selectedLatihan) {
      case 1:
        return latihan1();
      case 2:
        return latihan2();
      case 3:
        return latihan3();
      case 4:
        return latihan4();
      default:
        return const Text('Pilih latihan');
    }
  }

  // =========================
  // 🧪 LATIHAN 1
  // =========================
  Widget latihan1() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hello Flutter!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Ini teks biasa dengan ukuran kecil',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  // =========================
  // 🧪 LATIHAN 2
  // =========================
  Widget latihan2() {
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'Box',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  // =========================
  // 🧪 LATIHAN 3
  // =========================
  Widget latihan3() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.home, size: 40),
        Icon(Icons.favorite, size: 40),
        Icon(Icons.person, size: 40),
      ],
    );
  }

  // =========================
  // 🧪 LATIHAN 4
  // =========================
  Widget latihan4() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.home, size: 32, color: Colors.red),
          Icon(Icons.receipt_long, size: 32, color: Colors.green),
          Icon(Icons.favorite, size: 32, color: Colors.purple),
          Icon(Icons.person, size: 32, color: Colors.blue),
        ],
      ),
    );
  }
}
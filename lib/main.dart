
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Data produk
class Product {
  final String name;
  final int price;
  final String description;

  const Product(this.name, this.price, this.description);
}

// Daftar 3 produk
const List<Product> products = [
  Product('Laptop', 7500000, 'Laptop untuk belajar dan bekerja.'),
  Product('Ipad', 3500000, 'Ipad dengan fitur modern.'),
  Product('Headphone', 500000, 'Headphone untuk mendengarkan musik.'),
];

// Halaman utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Navigasi Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // Named Routes
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/tentang': (context) => const AboutPage(),
        '/detail': (context) {
          final product =
          ModalRoute.of(context)!.settings.arguments as Product;

          return DetailPage(product: product);
        },
      },
    );
  }
}

// Halaman utama dengan Bottom Navigation
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const ProfilePage(),
  ];

  final List<String> titles = [
    'Beranda',
    'Cari Produk',
    'Profil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: pages[selectedIndex],

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// HALAMAN 1: BERANDA
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.home,
            size: 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 15),
          const Text(
            'Selamat Datang!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text('Ini adalah halaman Beranda.'),

          const SizedBox(height: 25),

          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/tentang');
            },
            child: const Text('Halaman Tentang'),
          ),
        ],
      ),
    );
  }
}

// HALAMAN 2: TENTANG
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 15),
            const Text(
              'Halaman Tentang',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Ini adalah halaman informasi aplikasi.'),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}

// HALAMAN 3: CARI PRODUK
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Daftar Produk',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        ...products.map((product) {
          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.shopping_bag,
                color: Colors.blue,
                size: 35,
              ),
              title: Text(product.name),
              subtitle: Text(
                'Rp ${product.price}',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),

              // Mengirim argumen ke halaman detail
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: product,
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

// HALAMAN DETAIL PRODUK
class DetailPage extends StatelessWidget {
  final Product product;

  const DetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag,
              size: 90,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            Text(
              product.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Harga: Rp ${product.price}',
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 10),

            Text(product.description),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

// HALAMAN PROFIL
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.person,
              size: 60,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Nawwar Antarun Asady',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text('Nama: naasady_'),
          const Text('Status: Store Abal-Abal'),
        ],
      ),
    );
  }
}

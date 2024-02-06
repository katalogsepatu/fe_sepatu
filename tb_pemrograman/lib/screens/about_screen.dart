import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SHOE CATALOG',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 197, 238, 177),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Selamat Datang di Katalog Sepatu!',
              style: TextStyle(fontSize: 23),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/sepatu.png',
                  width: 200,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Aplikasi ini adalah tempat terbaik untuk menemukan berbagai macam sepatu dari berbagai merek terkemuka di satu tempat yang nyaman. Dengan aplikasi ini, dapat menjelajahi koleksi sepatu terbaru, mencari model yang sesuai dengan gaya dan kebutuhan, serta menemukan penawaran spesial yang eksklusif.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 10),
                    Text(
                      'Memberikan pengguna kemudahan dalam mencari dan menemukan sepatu dengan berbagai merek terkemuka. Menyajikan koleksi sepatu terbaru dengan pilihan model sesuai dengan gaya dan kebutuhan pengguna.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showProfileDialog(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 160, 219, 142)),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: const Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

void _showProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return ProfileDialog();
    },
  );
}

class ProfileDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Profile'),
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/agita.jpg'),
            ),
          ),
          SizedBox(height: 10),
          Text('Nama : Agita Nurfadillah'),
          Text('NPM : 1214029'),
          Text('Kelas : 3B'),
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/marlina.jpg'),
            ),
          ),
          SizedBox(height: 10),
          Text('Nama : Marlina Magdalena'),
          Text('NPM : 1214040'),
          Text('Kelas : 3B'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tb_pemrograman/models/katalog_sepatu.dart';

class KatalogSepatuCard extends StatelessWidget {
  final KatalogSepatuResponse katalogsepatuRes;
  final Function() onDismissed;

  const KatalogSepatuCard({Key? key, required this.katalogsepatuRes, required this.onDismissed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(katalogsepatuRes.message),
      onDismissed: (direction) {
        onDismissed();
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.lightBlue[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (katalogsepatuRes.insertedId != null) _buildDataRow("ID", katalogsepatuRes.insertedId),
            _buildDataRow("Message", katalogsepatuRes.message),
            _buildDataRow("Status", katalogsepatuRes.status),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, dynamic value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10), // Jarak antara label dan titik dua
        Expanded(
          child: Text(
            ': $value',
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
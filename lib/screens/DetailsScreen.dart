import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final double amount;
  final DateTime date;

  const DetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.category,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: $title',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Description: $description',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Category: $category', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Amount: $amount \$', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Date: ${date.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

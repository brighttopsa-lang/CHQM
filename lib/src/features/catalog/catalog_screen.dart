import 'package:flutter/material.dart';

import '../../data/mock_repository.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key, required this.repository});

  final MockRepository repository;

  @override
  Widget build(BuildContext context) {
    final courses = repository.getCourses();

    return Scaffold(
      appBar: AppBar(title: const Text('Programs Catalog')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, index) {
          final course = courses[index];
          return Card(
            child: ListTile(
              title: Text(course.title),
              subtitle: Text('${course.category} • ${course.durationHours}h'),
              trailing: Text('\$${course.price.toStringAsFixed(0)}'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Enrolled (demo): ${course.title}'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

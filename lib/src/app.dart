import 'package:flutter/material.dart';

import 'data/mock_repository.dart';
import 'features/catalog/catalog_screen.dart';
import 'features/certificates/certificates_screen.dart';
import 'features/exam/exam_screen.dart';
import 'features/profile/profile_screen.dart';

class ChqmTrainingApp extends StatelessWidget {
  const ChqmTrainingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = const MockRepository();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CHQM Training',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: HomeShell(repository: repo),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.repository});

  final MockRepository repository;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      CatalogScreen(repository: widget.repository),
      ExamScreen(repository: widget.repository),
      CertificatesScreen(repository: widget.repository),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'Catalog'),
          NavigationDestination(icon: Icon(Icons.quiz), label: 'Exam'),
          NavigationDestination(icon: Icon(Icons.workspace_premium), label: 'Certificates'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

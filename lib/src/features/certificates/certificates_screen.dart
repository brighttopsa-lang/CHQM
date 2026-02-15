import 'package:flutter/material.dart';

import '../../data/mock_repository.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key, required this.repository});

  final MockRepository repository;

  @override
  Widget build(BuildContext context) {
    final certificates = repository.getCertificates();

    return Scaffold(
      appBar: AppBar(title: const Text('My Certificates')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: certificates.length,
        itemBuilder: (_, index) {
          final cert = certificates[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: Text(cert.courseTitle),
              subtitle: Text(
                'Issued: ${cert.issueDate.toIso8601String().split('T').first}\nVerification: ${cert.verificationCode}',
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.qr_code),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('QR verify: ${cert.verificationCode}')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

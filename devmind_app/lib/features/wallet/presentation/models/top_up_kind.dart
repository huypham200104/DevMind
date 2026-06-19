import 'package:flutter/material.dart';

enum TopUpKind {
  explain(
    title: 'Lượt giải thích AI',
    description: '5 lượt giải thích / 3.000 VND',
    icon: Icons.eco_outlined,
    unitCredits: 5,
    creditType: 'explain',
  ),
  cvScan(
    title: 'Lượt quét CV',
    description: '1 lượt scan CV / 3.000 VND',
    icon: Icons.document_scanner_outlined,
    unitCredits: 1,
    creditType: 'cv_scan',
  );

  const TopUpKind({
    required this.title,
    required this.description,
    required this.icon,
    required this.unitCredits,
    required this.creditType,
  });

  static const packagePriceVnd = 3000;

  final String title;
  final String description;
  final IconData icon;
  final int unitCredits;
  final String creditType;

  int totalCredits(int quantity) => unitCredits * quantity;
}

import 'package:flutter/material.dart';
import '../Homepage/Experts1.dart';
import '../Homepage/Experts2.dart';
import '../Homepage/Experts3.dart';
import 'package:material_symbols_icons/symbols.dart';

class Columns extends StatelessWidget {
  final int index;

  const Columns({super.key, required this.index});

  Widget _getContentWidget(int index) {
    switch (index) {
      case 1:
        return Experts1();
      case 2:
        return Experts2();
      case 3:
        return Experts3();
      default:
        return const Center(
          child: Text(
            '상세 정보를 확인해 주세요.',
            style: TextStyle(fontSize: 24),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getContentWidget(index),
    );
  }
}

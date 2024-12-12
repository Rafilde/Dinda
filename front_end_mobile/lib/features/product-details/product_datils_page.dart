import 'package:flutter/material.dart';

class ProductDatilsPage extends StatefulWidget {
  const ProductDatilsPage({super.key});

  @override
  State<ProductDatilsPage> createState() => _ProductDatilsPageState();
}

class _ProductDatilsPageState extends State<ProductDatilsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
      ),
      body: const Center(
        child: Text('Detalhes do Produto'),
      ),
    );
  }
}
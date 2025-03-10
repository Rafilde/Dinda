import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ProductListServices {
  Future<List<Map<String, dynamic>>> fetchProducts() async  {
    try {
      CollectionReference products = FirebaseFirestore.instance.collection('products');
      QuerySnapshot snapshot = await products.get();
      return snapshot.docs.map((doc) => {
        ...doc.data() as Map<String, dynamic>,
      }).toList();
    } catch (e) {
      debugPrint('Erro ao buscar produtos: $e');
      return [];
    }
  }
}
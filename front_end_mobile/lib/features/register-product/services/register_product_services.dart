import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/models/product_model.dart';

final supabase = Supabase.instance.client;
class RegisterProductServices {

  Future<String?> uploadImage(File imageFile) async {
    try {
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      await supabase.storage
          .from('products')
          .upload('img/$fileName', imageFile);

      final publicUrl = supabase.storage
          .from('products')
          .getPublicUrl('img/$fileName');

      return publicUrl;
    } catch (e) {
      print('Erro ao fazer upload: $e');
      return null;
    }
  }

  Future<void> saveProduct(ProductModel product) async {
    final productRef = FirebaseFirestore.instance.collection('products').doc(product.id);

    await productRef.set(product.toMap());
  }

  Future<void> createProduct(
      String name, double price, int quantity, List<String> imagePaths) async {

    List<String> imageUrls = [];
    for (final imagePath in imagePaths) {
      try {
        File file = File(imagePath);
        final imageUrl = await uploadImage(file);

        if (imageUrl != null) {
          imageUrls.add(imageUrl);
        } else {
          print('Erro ao processar a imagem: $imagePath');
        }
      } catch (e) {
        print('Erro ao processar a imagem $imagePath: $e');
      }
    }

    if (imageUrls.isEmpty) {
      throw Exception('Nenhuma imagem foi carregada com sucesso.');
    }

    final newProduct = ProductModel(
      id: FirebaseFirestore.instance.collection('products').doc().id,
      name: name,
      price: price,
      quantity: quantity,
      imageUrl: imageUrls,
      createdAt: Timestamp.now(),
    );

    try {
      await saveProduct(newProduct);
    } catch (e) {
      print('Erro ao criar o produto: $e');
      throw Exception('Erro ao criar o produto: $e');
    }
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../shared/models/product_model.dart';

class RegisterProductServices {

  Future<void> saveProduct(ProductModel product) async {
    final productRef = FirebaseFirestore.instance.collection('products').doc(product.id);

    await productRef.set(product.toMap());
  }

  Future<void> createProduct(String name, String price, int quantity, List<String> imageUrl) async {
    final productRef = FirebaseFirestore.instance.collection('products').doc();

    final newProduct = ProductModel(
      id: productRef.id,
      name: name,
      price: price,
      quantity: quantity,
      imageUrl: imageUrl,
      createdAt: Timestamp.now()
    );

    await RegisterProductServices().saveProduct(newProduct);
  }

}
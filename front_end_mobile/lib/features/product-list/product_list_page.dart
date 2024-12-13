import 'package:flutter/material.dart';
import 'package:front_end_mobile/features/product-details/product_datils_page.dart';
import 'package:front_end_mobile/features/register-product/register_product_page.dart';
import '../../shared/colors.dart';
import '../../shared/widgets/app_bar.dart';
import '../../shared/widgets/stylish_float_action_button.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Produto 1',
      'quantity': 10,
      'price': 19.99,
      'imageUrls': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPjdt3COye-stiyIAoH6hDjC9NWKFcVwizog&s'
      ],
    },
    {
      'id': 2,
      'name': 'Produto 2',
      'quantity': 5,
      'price': 29.99,
      'imageUrls': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPjdt3COye-stiyIAoH6hDjC9NWKFcVwizog&s'
      ],
    },
    {
      'id': 3,
      'name': 'Produto 3',
      'quantity': 15,
      'price': 9.99,
      'imageUrls': ['https://via.placeholder.com/150'],
    },
    {
      'id': 3,
      'name': 'Produto 3',
      'quantity': 15,
      'price': 9.99,
      'imageUrls': ['https://via.placeholder.com/150'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton: StylishFAB(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterProductPage(),
            ),
          );
        },
        icon: Icons.add,
        color: AppColors.primaryColor,
        iconColor: AppColors.white,
      ),
      body: Column(
        children: <Widget>[
          const AppBarWidget(title: 'Produtos'),
          Expanded(child: productsListInfo),
        ],
      ),
    );
  }

  Widget get productsListInfo {
    if (products.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum produto cadastrado',
          style: TextStyle(color: AppColors.blackLight),
        ),
      );
    }

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product = products[index];
        return Card(
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: AppColors.cardBackgroundColor,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              hoverColor: AppColors.cardBackgroundColorHover,
              onTap: () {
                navigateToItemDetail(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        product['imageUrls'].isNotEmpty
                            ? product['imageUrls'][0]
                            : '',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.image_not_supported,
                          size: 50,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              color: AppColors.productTitle,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Quantidade: ${product['quantity']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.productDescription,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                'Preço: R\$${product['price']}',
                                style: const TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Future navigateToItemDetail(BuildContext context) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProductDetailsPage(productName: 'OI', price: 234, quantity: 234, imageUrls: ['https://delicious.com.br/wp-content/uploads/2020/10/WhatsApp-Image-2022-07-18-at-11.39.00-1.jpeg', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZZ3beQj_u4ST1UXT_xQEVtRtizxFn4bmVuw&s'],);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}

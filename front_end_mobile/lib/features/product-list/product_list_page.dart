import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_mobile/features/product-details/product_datils_page.dart';
import 'package:front_end_mobile/features/product-list/cubit/product_list_cubit.dart';
import 'package:front_end_mobile/features/register-product/register_product_page.dart';
import 'package:front_end_mobile/shared/models/product_model.dart';
import '../../shared/colors.dart';
import '../../shared/widgets/app_bar.dart';
import '../../shared/widgets/stylish_float_action_button.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  @override
  void initState() {
    super.initState();
    context.read<ProductListCubit>().getListOfProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        floatingActionButton: _buildFloatingActionButton(),
        body: Column(
          children: <Widget>[
            const AppBarWidget(title: 'Produtos'),
            Expanded(
              child: BlocBuilder<ProductListCubit, ProductListState>(
                builder: (context, state) {
                  if (state is InitialProductListState || state is LoadingProductListState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SuccessProductListState) {
                    return _buildProductListInfo(state.products);
                  } else if (state is ErrorProductListState) {
                    return Center(child: Text(state.message));
                  } else {
                    return SizedBox();
                  }
                },
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return StylishFAB(
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
    );
  }

  Widget _buildProductListInfo(List<ProductModel> products) {
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
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.cardBackgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        hoverColor: AppColors.cardBackgroundColorHover,
        onTap: () {
          navigateToItemDetail(context, product);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              _buildProductImage(product),
              const SizedBox(width: 20),
              _buildProductDetails(product),
              const SizedBox(width: 20),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(ProductModel product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        product.imageUrl.isNotEmpty ? product.imageUrl[0] : '',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>  Container(
          width: 100,
          height: 100,
          color: AppColors.greyLight,
          child: const Icon(
            Icons.error_outline,
            color: AppColors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(ProductModel product) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: AppColors.productTitle,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Quantidade: ${product.quantity}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.productDescription,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 5),
          _buildProductPrice(product),
        ],
      ),
    );
  }

  Widget _buildProductPrice(ProductModel product) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greenLight,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(5),
      child: Center(
        child: Text(
          'Preço: R\$${product.price}',
          style: const TextStyle(
            color: AppColors.green,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Future navigateToItemDetail(BuildContext context, ProductModel product) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProductDetailsPage(
            productName: product.name,
            price: product.price,
            quantity: product.quantity,
            imageUrls: List<String>.from(product.imageUrl),
          );
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

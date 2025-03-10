import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:front_end_mobile/shared/colors.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productName;
  final double price;
  final int quantity;
  final List<String> imageUrls;

  const ProductDetailsPage({
    super.key,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.imageUrls,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late MoneyMaskedTextController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productName);
    _quantityController = TextEditingController(text: widget.quantity.toString());
    _priceController = MoneyMaskedTextController(
      leftSymbol: 'R\$',
      decimalSeparator: ',',
      thousandSeparator: '.',
      initialValue: widget.price,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          _backAndDeleteButtons(),
          _carrousel(),
          const SizedBox(height: 10),
          _infoText(),
          const SizedBox(height: 20),
          _forms(),
        ],
      ),
    ));
  }

  // Widget de texto informativo
  Widget _infoText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Aqui você pode visualizar os detalhes do produto e realizar modificações.',
        style: TextStyle(
          fontSize: 16,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _backAndDeleteButtons() {
    return Padding(padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: AppColors.white,
            onPressed: _deleteProduct,
          ),
        ],
      ),
    );
  }

  Widget _carrousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: widget.imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _forms() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _formFields(),
                const SizedBox(height: 40),
                _saveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formFields() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          _inputField(
            controller: _nameController,
            hintText: "Informe o nome do produto",
          ),
          _inputField(
            controller: _quantityController,
            hintText: "Informe a quantidade",
            inputType: TextInputType.number,
          ),
          _inputField(
            controller: _priceController,
            hintText: "Informe o preço do produto",
            inputType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType inputType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.greyLight),
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _saveButton() {
    return MaterialButton(
      onPressed: _saveChanges,
      height: 50,
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Center(
        child: Text(
          "Salvar Alterações",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _deleteProduct() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Deletar Produto',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.black,
          ),
        ),
        content: const Text(
          'Tem certeza que deseja deletar este produto?',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.blackLight,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColors.white,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Volta à lista de produtos após deletar
              _deleteMessage(context, 'Produto deletado com sucesso!');
            },
            child: const Text(
              'Deletar',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    String updatedName = _nameController.text.trim();
    String? updatedPrice = _priceController.text;
    int? updatedQuantity = int.tryParse(_quantityController.text);

    if (updatedName.isEmpty || updatedPrice.isEmpty || updatedQuantity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos corretamente.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Salvar Alterações',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.black,
          ),
        ),
        content: const Text(
          'Deseja salvar as alterações feitas neste produto?',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.blackLight,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColors.white,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Volta à lista de produtos após salvar
              _successMessage(context, 'Produto atualizado com sucesso!');
            },
            child: const Text(
              'Salvar',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

  }

  _deleteMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.error,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.close, color: AppColors.white),
              const SizedBox(width: 10),
              Text(
                message,
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
    );
  }

  _successMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.success,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.check, color: AppColors.white),
              const SizedBox(width: 10),
              Text(
                message,
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
    );
  }

}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:front_end_mobile/shared/colors.dart';
import 'package:image_picker/image_picker.dart';

import 'cubit/register_product_cubit.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _quantityController = TextEditingController();
  final MoneyMaskedTextController _priceController = MoneyMaskedTextController(
    leftSymbol: 'R\$',
    decimalSeparator: ',',
    thousandSeparator: '.',
  );
  final List<String> images = [];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    setState(() {
      images.clear();
      images.addAll(pickedFiles.map((file) => file.path));
    });
    }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterProductCubit(),
      child: BlocListener<RegisterProductCubit, RegisterProductState>(
        listener: (context, state) {
          if (state is ErrorRegisterProductState) {
            _errorSnackBar(context, state.message);
          }
          if (state is SuccessRegisterProductState) {
            _successMessage(context, 'Produto cadastrado com sucesso!');
            Navigator.of(context).pop();
          }
          if (state is LoadingRegisterProductState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Cadastrando produto...',
                        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                backgroundColor: AppColors.primaryColor,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: AppColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCloseButton(context),
                  _buildTitleSection(),
                  const SizedBox(height: 20),
                  Expanded(child: _buildFormSection()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildCloseButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      padding: const EdgeInsets.all(20),
      icon: const Icon(Icons.close),
      color: AppColors.white,
    );
  }

  void _saveChanges() {
    final name = _nameController.text.trim();
    final price = _priceController.numberValue;
    final quantityText = _quantityController.text;
    final quantity = int.tryParse(quantityText);

    if (name.isEmpty || price <= 0 || quantity == null || images.isEmpty) {
      _incompleteFieldsSnackbar(context);
      return;
    }

    debugPrint('Name: ${_nameController.text.trim()}' 'Price: ${_priceController.numberValue}' 'Quantity: ${int.tryParse(_quantityController.text)!}' 'Image: $images');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Cadastrar Produto',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.black,
          ),
        ),
        content: const Text(
          'Deseja cadastrar esse produto?',
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
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                 BlocProvider.of<RegisterProductCubit>(context).createProduct(
                  name,
                  price,
                  quantity,
                  images,
                );
              } catch (e) {
                debugPrint('Erro ao cadastrar produto: $e');
              }
            },
            child: const Text(
              'Cadastrar',
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

  Widget _buildTitleSection() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Registrar Produto",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Preencha os campos abaixo para cadastrar um novo produto",
            style: TextStyle(color: AppColors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
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
              _buildProductInfoForm(),
              const SizedBox(height: 40),
              _buildImagePreview(),
              const SizedBox(height: 40),
              _buildAddImageButton(),
              const SizedBox(height: 50),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfoForm() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          _buildTextField(
            controller: _nameController,
            hintText: "Informe o nome do produto",
          ),
          _buildTextField(
            controller: _quantityController,
            hintText: "Informe a quantidade de produtos",
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4),],
          ),
          _buildTextField(
            controller: _priceController,
            hintText: "Informe o preço do produto",
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.greyLight)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (images.isEmpty) {
      return const Center(
        child: Text(
          "Nenhuma imagem adicionada",
          style: TextStyle(
            color: AppColors.productDescription,
          ),
        ),
      );
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return _buildImagePreviewItem(index);
        },
      ),
    );
  }

  Widget _buildImagePreviewItem(int index) {
    return Stack(
      children: [
        Image.file(
          File(images[index]),
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: () {
              setState(() {
                images.removeAt(index);
              });
            },
            color: AppColors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildAddImageButton() {
    return OutlinedButton.icon(
      onPressed: () {
        pickImages();
      },
      icon: const Icon(Icons.camera_alt, color: AppColors.productDescription),
      label: const Text(
        "Adicionar Foto",
        style: TextStyle(
          color: AppColors.productDescription,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.productDescription),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return MaterialButton(
      onPressed: () {
        _saveChanges();
      },
      height: 50,
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Center(
        child: Text(
          "Cadastrar produto",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
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

  _errorSnackBar(BuildContext context, String message) {
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
              const Icon(Icons.error, color: AppColors.white),
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

  _incompleteFieldsSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.error, color: AppColors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Por favor, preencha todos os campos corretamente.',
                style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: AppColors.white,
          onPressed: () {},
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:front_end_mobile/shared/colors.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  final MoneyMaskedTextController _moneyController = MoneyMaskedTextController(
    leftSymbol: 'R\$',
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

  final List<String> images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ65blU_xkxMQHgy2STZTc5n9GA2oyP8paukg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLLoWFrrn79xSUSqaxh1JguzEXQasMQuhbTA&s'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: AppColors.primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCloseButton(context),
            _buildTitleSection(),
            const SizedBox(height: 20),
            Expanded(
              child: _buildFormSection(),
            ),
          ],
        ),
      ),
    ),);
  }

  Widget _buildCloseButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      padding: const EdgeInsets.all(20),
      icon: const Icon(Icons.close),
      color: AppColors.white,
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
            hintText: "Informe o nome do produto",
          ),
          _buildTextField(
            hintText: "Informe a quantidade de produtos",
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          ),
          _buildTextField(
            controller: _moneyController,
            hintText: "Informe o preço do produto",
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
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
        Image.network(
          images[index],
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
      onPressed: () {},
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
      onPressed: () {},
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
}

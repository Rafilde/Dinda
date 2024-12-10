import 'package:flutter/material.dart';
import 'package:front_end_mobile/shared/app_routes.dart';
import '../../shared/colors.dart';
import '../../shared/widgets/app_bar.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.HOME);
          },
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return ListView(
      children: <Widget>[
        const AppBarWidget(title: 'Registrar Produto'),
        buildForm,
      ],
    );
  }

  Widget get appBarRow {
    return Row(
      children: <Widget>[
        titleTextAppBar,
      ],
    );
  }

  Widget get titleTextAppBar {
    return Flexible(
      child: Container(
        alignment: Alignment.center,
        child: const Text(
          "Registrar Produto",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.blackLight,
          ),
        ),
      ),
    );
  }

  Widget get buildForm {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProductNameField(),
            const SizedBox(height: 16),
            _buildQuantityField(),
            const SizedBox(height: 16),
            _buildPriceField(),
            const SizedBox(height: 16),
            _buildImagePreview(),
            const SizedBox(height: 16),
            buildElevatedButton(
              text: "Adicionar Foto(s)",
            ),
            const SizedBox(height: 16),
            buildElevatedButton(
              text: "Cadastrar Produto",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildElevatedButton({
    required String text,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(15),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
      ),
      onPressed: null,
      child: Text(text),
    );
  }

  Widget _buildProductNameField() {
    return TextFormField(
      controller: _nameController,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        labelText: "Nome",
        labelStyle: TextStyle(color: AppColors.blackLight),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blackLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blackLight),
        ),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor, insira o nome do produto";
        }
        return null;
      },
    );
  }

  Widget _buildQuantityField() {
    return TextFormField(
      controller: _quantityController,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        labelText: "Quantidade",
        labelStyle: TextStyle(color: AppColors.blackLight),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blackLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blackLight),
        ),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor, insira a quantidade do produto";
        }
        if (int.tryParse(value) == null) {
          return "Por favor, insira um número válido";
        }
        return null;
      },
    );
  }

  Widget _buildPriceField() {
    return TextFormField(
      controller: _priceController,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        labelText: "Preço",
        labelStyle: TextStyle(color: AppColors.blackLight),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blackLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blackLight),
        ),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Por favor, insira o preço do produto";
        }
        return null;
      },
    );
  }

  Widget _buildImagePreview() {
    final images = <String>[];
    if (images.isEmpty) {
      return Center(child: const Text("Nenhuma imagem selecionada"));
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Icon(Icons.image),
              Positioned(
                right: 0,
                child: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () => null,
                    color: AppColors.red),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/widgets/app_bar.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:  Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: body(),
    ));
  }

  Widget body() {
    return ListView(
      children: const <Widget>[AppBarWidget(title: 'Pedidos')],
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
          "Pedidos",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.blackLight,
          ),
        ),
      ),
    );
  }
}

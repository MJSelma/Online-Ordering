import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _MerchantPageState();
}

class _MerchantPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(child: Image.asset('assets/images/products_sample.png'),),
      ]
    );
  }
}
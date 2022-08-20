import 'package:flutter/material.dart';
import 'package:simple_delivery/models/product_models.dart';

class Cart extends StatefulWidget {
  final List<Products> products;
  final Function(Products, int) removeProduct;
  const Cart({
    Key? key,
    required this.products,
    required this.removeProduct,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Widget productCard(Products product, index) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: FittedBox(
              child: Image.network(
                product.image,
                width: 80,
                height: 80,
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            product.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "ราคา: ${product.price}",
          ),
          IconButton(
            onPressed: () {
              widget.removeProduct(product, index);
            },
            icon: const Icon(
              Icons.remove_circle,
              color: Colors.red,
            ),
          )
        ],
      ),
    );

    // return Card(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Center(
    //         child: Image.network(
    //           product.image,
    //         ),
    //       ),
    //       Text(product.title),
    //       Text("${product.price}")
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
      itemBuilder: (context, index) =>
          productCard(widget.products[index], index),
    );
  }
}

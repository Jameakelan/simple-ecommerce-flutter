import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api/api.dart';
import 'models/product_models.dart';

class Home extends StatefulWidget {
  final Function(Products) selectProduct;

  const Home({Key? key, required this.selectProduct}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Products> products;

  List<Products> productCart = [];

  @override
  void initState() {
    super.initState();
  }

  Widget productCard(Products product) {
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
              widget.selectProduct(product);
            },
            icon: const Icon(
              Icons.shopping_basket_rounded,
              color: Colors.blue,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-commerce"),
      ),
      body: FutureBuilder<http.Response>(
        future: API.get("products"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List productList = jsonDecode(snapshot.data!.body);
            products =
                productList.map((model) => Products.fromJson(model)).toList();

            // return ListView.builder(
            //   itemCount: products.length,
            //   itemBuilder: (context, index) => productCard(products[index]),
            // );

            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3 / 3.5,
              children: List<Widget>.generate(
                products.length,
                (index) => productCard(products[index]),
              ),
            );
          }
          return const Center(
            child: Text("Loading"),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:simple_delivery/cart.dart';
import 'package:simple_delivery/home.dart';
import 'package:simple_delivery/models/product_models.dart';
import 'package:simple_delivery/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Products> productCart = [];

  int _currentIndex = 0;

  // final pages = [
  //   Home(
  //     selectProduct: (products) {
  //       setState(() {
  //         productCart.add(products);
  //       });
  //     },
  //   ),
  //   const Cart(),
  //   const Profile()
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _currentIndex,
        marginR: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
        onTap: changePage,
        backgroundColor: Colors.green,
        items: [
          DotNavigationBarItem(
              icon: const Icon(
                Icons.home,
              ),
              selectedColor: Colors.white),
          DotNavigationBarItem(
              icon: const Icon(
                Icons.add_shopping_cart_rounded,
              ),
              selectedColor: Colors.white),
          DotNavigationBarItem(
              icon: const Icon(
                Icons.account_circle,
              ),
              selectedColor: Colors.white)
        ],
      ),
      body: (_currentIndex == 0)
          ? Home(
              selectProduct: (product) {
                setState(() {
                  productCart.add(product);
                });
              },
            )
          : (_currentIndex == 1)
              ? Cart(
                  products: productCart,
                  removeProduct: (product, index) {
                    setState(() {
                      // productCart.removeWhere((p) => p.id == product.id);
                      productCart.removeAt(index);
                    });
                  },
                )
              : const Profile(),
    );
  }
}

import 'package:flutter/material.dart';

class Product {
  String name;
  double unitPrice;
  List<String> availableSizes;

  Product({required this.name, required this.unitPrice, required this.availableSizes});
}

List<Product> products = [
  Product(name: 'Product 1', unitPrice: 10.0, availableSizes: ['S','M', 'L', 'XL', 'XXL', 'XXXL']),
];

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  String selectedSize = '';
  int selectedProductIndex = 0;

  void showSnackbar(BuildContext context, String size) {
    final snackBar = SnackBar(
      content: Text('Size $size selected. Color changed!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Number of columns in each row
            childAspectRatio: 1.5, // Aspect ratio of each item (width / height)
          ),
          shrinkWrap: true,
          itemCount: products[selectedProductIndex].availableSizes.length,
          itemBuilder: (context, index) {
            String size = products[selectedProductIndex].availableSizes[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = size;
                });
                showSnackbar(context, size);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: selectedSize == size ? Colors.orange : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    size,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: ShoppingCart(),
));

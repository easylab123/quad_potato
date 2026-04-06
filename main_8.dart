import 'package:flutter/material.dart';
import 'product.dart';
import 'cart.dart';
import 'cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Cart cart = Cart();

  final List<Product> products = [

    Product(id:1,name:"Laptop",price:50000),
    Product(id:2,name:"Mobile Phone",price:20000),
    Product(id:3,name:"Headphones",price:2000),
    Product(id:4,name:"Keyboard",price:1500),
    Product(id:5,name:"Mouse",price:800),

  ];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Shopping App",
      home: ProductPage(products: products, cart: cart),
    );
  }
}

class ProductPage extends StatefulWidget {

  final List<Product> products;
  final Cart cart;

  ProductPage({required this.products, required this.cart});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Simple Shopping App"),

        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context)=>CartScreen(cart: widget.cart),
                ),
              );
            },
          )
        ],
      ),

      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context,index){

          final product = widget.products[index];

          return Card(
            margin: EdgeInsets.all(10),

            child: ListTile(
              title: Text(product.name),
              subtitle: Text("Price: ₹${product.price}"),

              trailing: ElevatedButton(
                child: Text("Add"),
                onPressed: (){
                  setState(() {
                    widget.cart.addProduct(product);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${product.name} added to cart"))
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
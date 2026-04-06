import 'package:flutter/material.dart';
import 'cart.dart';

class CartScreen extends StatefulWidget {

  final Cart cart;

  CartScreen({required this.cart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),

      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.items.length,
              itemBuilder: (context,index){

                final product = widget.cart.items[index];

                return ListTile(
                  title: Text(product.name),
                  subtitle: Text("₹${product.price}"),

                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      setState(() {
                        widget.cart.removeProduct(product);
                      });
                    },
                  ),
                );
              },
            ),
          ),

          Text(
            "Total: ₹${widget.cart.getTotalPrice()}",
            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
          ),

          SizedBox(height:20)

        ],
      ),
    );
  }
}
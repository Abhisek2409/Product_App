import 'package:flutter/material.dart';
import 'package:task/model/product.dart';

class DeletePage extends StatelessWidget {
  final Product product;
  
  DeletePage({required this.product});

  @override
  Widget build(BuildContext context) {
    // You can use product.id to perform delete operation
    return Scaffold(
      appBar: AppBar(title: Text('Delete Product')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Call your ApiService deleteProduct method
          },
          child: Text('Confirm Delete ${product.name}'),
        ),
      ),
    );
  }
}

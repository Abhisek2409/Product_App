import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/model/product.dart';
import 'package:task/provider/productprovider.dart';
import 'package:task/services/api_services.dart';
// Import your API service

class UpdatePage extends StatefulWidget {
  final Product product;

  UpdatePage({required this.product});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    priceController = TextEditingController(text: widget.product.price.toString());
    descriptionController = TextEditingController(text: widget.product.description);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _updateProduct() async {
    final newName = nameController.text.trim();
    final newPrice = double.tryParse(priceController.text.trim()) ?? 0.0;
    final newDescription = descriptionController.text.trim();

    if (newName.isEmpty || newDescription.isEmpty || newPrice <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid product details')),
      );
      return;
    }

    // Call your API service
    await ApiService.updateProduct(widget.product.id, newName, newPrice, newDescription);

    // Refresh product list
    Provider.of<ProductsProvider>(context, listen: false).fetchProducts();

    // Go back and show confirmation
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Product Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProduct,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

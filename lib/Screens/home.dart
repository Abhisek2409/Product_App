import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Screens/add.dart';
import 'package:task/Screens/delete.dart';
import 'package:task/Screens/update.dart';
import 'package:task/provider/productprovider.dart';
import 'package:task/services/api_services.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: Text("Product Viewer", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF212121),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF212121)),
              child: Text(
                "Welcome!! What services are you looking for...",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Product"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.update),
              title: Text("Edit Product"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : productProvider.errorMessage != null
              ? Center(child: Text(productProvider.errorMessage!))
              : ListView.builder(
                  itemCount: productProvider.products.length,
                  itemBuilder: (context, index) {
                    final product = productProvider.products[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(product.name),
                        subtitle: Text("₹${product.price.toStringAsFixed(2)}"),
                        isThreeLine: true,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(product.name),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Price: ₹${product.price.toStringAsFixed(2)}"),
                                  SizedBox(height: 10),
                                  Text("Description:\n${product.description}"),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: Text("Close"),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdatePage(product: product),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Confirm Deletion'),
                                    content: Text('Are you sure you want to delete ${product.name}?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.of(ctx).pop();
                                          await ApiService.deleteProduct(product.id);
                                          Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
                                        },
                                        child: Text('Delete', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
        },
        icon: Icon(Icons.add),
        label: Text('Add Product'),
        backgroundColor: Color(0xFF212121),
        foregroundColor: Colors.white,
      ),
    );
  }
}

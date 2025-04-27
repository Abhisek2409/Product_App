import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/provider/productprovider.dart';
import 'package:task/services/api_services.dart';
 // Don't forget this import!

class AddPage extends StatefulWidget {
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController NameTextcontroller = TextEditingController();
  TextEditingController PriceTextcontroller = TextEditingController();
  TextEditingController DesTextcontroller = TextEditingController();

  void submit() async {
    if (NameTextcontroller.text.isEmpty ||
        PriceTextcontroller.text.isEmpty ||
        DesTextcontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are mandatory")),
      );
      return;
    }

    try {
      final provider = Provider.of<ProductsProvider>(context, listen: false);

      await ApiService.addProduct(
        NameTextcontroller.text,
        double.parse(PriceTextcontroller.text),
        DesTextcontroller.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product added successfully!")),
      );

      provider.fetchProducts(); // refresh the list after adding
      Navigator.pop(context); // now go back
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add product: $e")),
        
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const Text(
          "Add Products",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF212121),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: NameTextcontroller,
              decoration: const InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: PriceTextcontroller,
              keyboardType: TextInputType.number, // important
              decoration: const InputDecoration(
                labelText: "Product Price",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: DesTextcontroller,
              decoration: const InputDecoration(
                labelText: "Product Description",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF212121),
              foregroundColor: Colors.white,
            ),
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task/Screens/add.dart';
import 'package:task/Screens/delete.dart';
import 'package:task/Screens/update.dart';
import 'package:task/Screens/view.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: Text("Product_Viewer", style: TextStyle(color: Color(0xFFFFFFFF)),),
        backgroundColor: Color(0xFF212121),
        iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        centerTitle: true,
      ),

      drawer: Drawer(
        backgroundColor: Color(0xFFFFFFFF),
        
        child: ListView(
          children: [
            DrawerHeader(
              
              decoration: BoxDecoration(
                color: Color(0xFF212121),
                
              ),
              child:Container(
                child: Text("Welcome!! What servies are you looking for...", style: TextStyle(color: Color(0xFFFFFFFF)),)),
            ),
            ListTile(
              leading: Icon(Icons.add,),
              title: Text("Add Product"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
              },
            ),
            

            ListTile(
              leading: Icon(Icons.view_list,),
              title: Text("View Product"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPage()));
              },
            ),

            ListTile(
              leading: Icon(Icons.update,),
              title: Text("Edit Product"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage()));
              },
            ),

            ListTile(
              leading: Icon(Icons.delete,),
              title: Text("Delete Product"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DeletePage()));
              },
            ),
          ],
        ),
      ),
      
    );
  }
}
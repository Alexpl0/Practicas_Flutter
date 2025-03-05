
import 'package:flutter/material.dart';

class ProductosGrid extends StatelessWidget {
  const ProductosGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    String user = args?['user'] ?? 'No user';
    String password = args?['password'] ?? 'No password';

    return TiendaScreen(user: user, password: password);
  }
}

class TiendaScreen extends StatelessWidget {
  final String user;
  final String password;
  final List<Product> productos = [
    Product(
      nombre: 'Camisa',
      precio: 29.99,
      imagenUrl: 'https://safetydepot.com.mx/cdn/shop/files/Mesadetrabajo1_b4cafa52-24a2-405d-8b39-0b39ab0b3710_1024x1024.jpg?v=1720021404',
    ),
    Product(
      nombre: 'Pantalones',
      precio: 49.99,
      imagenUrl: 'https://vittorioforti.com.mx/cdn/shop/products/VSA03038GC-VCA06535AZ-VPN03064GC4.jpg?v=1617635791&width=700',
    ),
    Product(
      nombre: 'Zapatos',
      precio: 69.99,
      imagenUrl: 'https://pakar.com/cdn/shop/files/120507-CE-12.jpg?v=1722924835',
    ),
  ];

  TiendaScreen({super.key, required this.user, required this.password});

  @override
  Widget build(BuildContext context) {
    print("password $password");
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido $user'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas en la cuadrícula
          childAspectRatio: 0.7, // Relación de aspecto del hijo (ajusta altura)
          crossAxisSpacing: 10, // Espacio horizontal entre elementos
          mainAxisSpacing: 10, // Espacio vertical entre elementos
        ),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return ProductCard(producto: productos[index]);
        },
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product producto;

  const ProductCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detalles',
          arguments: producto,
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              producto.imagenUrl,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              producto.nombre,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '\$${producto.precio.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            IconButton(
              icon: Icon(Icons.add_shopping_cart, color: Colors.blue),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${producto.nombre} añadido al carrito')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String nombre;
  final double precio;
  final String imagenUrl;

  Product({
    required this.nombre,
    required this.precio,
    required this.imagenUrl,
  });
}

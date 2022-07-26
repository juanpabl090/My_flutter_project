import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key, 
    required this.titulo
  }) : super(key: key);

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/My_project_logo.png'),
          const Text('¡Hola!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Text('Para continuar, $titulo',
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

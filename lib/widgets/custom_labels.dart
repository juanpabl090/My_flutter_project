// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({
      Key? key, 
      required this.ruta, 
      required this.titulo,
      required this.subTitulo, 
    }) : super(key: key);

  final String ruta;
  final String titulo;
  final String subTitulo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(titulo,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, ruta);
          },
          child: Text(subTitulo,
              style: TextStyle(color: Colors.blue[600])),
        ),
      ],
    );
  }
}

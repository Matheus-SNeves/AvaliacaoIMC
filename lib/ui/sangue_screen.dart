import 'package:flutter/material.dart';

class SangueScreen extends StatefulWidget {
  const SangueScreen({super.key});

  @override
  State<SangueScreen> createState() => _SangueScreenState();
}

class _SangueScreenState extends State<SangueScreen> {
  String nome = '';
  String tipo = '';
  String tipos = '';

  validar(BuildContext context) {
    if (nome.isEmpty || tipo.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Atenção'),
            content: Text('Preencha todos os campos'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        if (tipo.toUpperCase() == 'O-') {
          tipos = 'A+, A-, B+, B-, AB+, AB-, O+, O-';
        } else if (tipo.toUpperCase() == 'O+') {
          tipos = 'A+, B+, AB+, O+';
        } else if (tipo.toUpperCase() == 'A-') {
          tipos = 'A+, A-, AB+, O-';
        } else if (tipo.toUpperCase() == 'A+') {
          tipos = 'A+, AB+';
        } else if (tipo.toUpperCase() == 'B-') {
          tipos = 'B+, B-, AB+, O-';
        } else if (tipo.toUpperCase() == 'B+') {
          tipos = 'B+, AB+';
        } else if (tipo.toUpperCase() == 'AB-') {
          tipos = 'AB+, O-';
        } else if (tipo.toUpperCase() == 'AB+') {
          tipos = 'AB+';
        } else {
          tipos = 'Nenhum tipo';
        }
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(nome),
            content: Text('Seu sangue pode ser doado para os tipos: $tipos'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doação de sangue", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Nome do doador'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu nome',
              ),
              onChanged: (value) {
                setState(() {
                  nome = value;
                });
              },
            ),
            Text('Tipo sanguíneo'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu tipo sanguíneo',
              ),
              onChanged: (value) {
                setState(() {
                  tipo = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                validar(context);
              },
              child: Text('Calcular'),
            ),
            Text('Você $nome pode doar sangue para os tipos:$tipos'),
          ],
        ),
      ),
    );
  }
}
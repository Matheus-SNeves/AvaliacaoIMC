import 'package:flutter/material.dart';

// Tela principal para a aplicação da Calculadora de IMC
class IMCCalculatorScreen extends StatefulWidget {
  const IMCCalculatorScreen({super.key});

  @override
  State<IMCCalculatorScreen> createState() => _IMCCalculatorScreenState();
}

class _IMCCalculatorScreenState extends State<IMCCalculatorScreen> {
  // Controladores para os campos de texto de peso e altura
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  // Variáveis para armazenar o valor do IMC e sua classificação
  String imcResult = '';
  String imcClassification = '';

  @override
  void dispose() {
    // Libera os controladores de texto quando o widget é descartado para evitar vazamentos de memória
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  // Função para calcular o IMC
  void _calculateIMC() {
    // Tenta converter os valores de peso e altura para double
    final double? weight = double.tryParse(_weightController.text.replaceAll(',', '.')); // Troca vírgula por ponto para parsing
    final double? height = double.tryParse(_heightController.text.replaceAll(',', '.')); // Troca vírgula por ponto para parsing

    // Verifica se os valores são válidos (não nulos e altura maior que zero)
    if (weight == null || height == null || height <= 0) {
      // Exibe um AlertDialog se os valores forem inválidos
      _showAlertDialog(context, 'Erro de Entrada', 'Por favor, insira valores numéricos válidos para peso e altura (altura > 0).');
      return;
    }

    // Calcula o IMC usando a fórmula: peso / (altura * altura)
    final double imc = weight / (height * height);

    // Determina a classificação do IMC
    String classification;
    if (imc < 18.5) {
      classification = 'Abaixo do peso';
    } else if (imc >= 18.5 && imc < 24.9) {
      classification = 'Peso normal';
    } else if (imc >= 25.0 && imc < 29.9) {
      classification = 'Sobrepeso';
    } else if (imc >= 30.0 && imc < 34.9) {
      classification = 'Obesidade Grau I';
    } else if (imc >= 35.0 && imc < 39.9) {
      classification = 'Obesidade Grau II';
    } else {
      classification = 'Obesidade Grau III';
    }

    setState(() {
      imcResult = imc.toStringAsFixed(2); // Formata o IMC para 2 casas decimais
      imcClassification = classification;
    });

    // Exibe o resultado do IMC em um AlertDialog
    _showAlertDialog(
      context,
      'Resultado do IMC',
      'Seu IMC é $imcResult\n$imcClassification',
    );
  }

  // Função auxiliar para exibir um AlertDialog
  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title), // Título do AlertDialog
          content: Text(content), // Conteúdo do AlertDialog (resultado do IMC ou mensagem de erro)
          actions: <Widget>[
            TextButton(
              child: const Text('OK'), // Botão OK para fechar o AlertDialog
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o AlertDialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar com o título "Calculadora de IMC"
      appBar: AppBar(
        title: const Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.white), // Define a cor do texto do título
        ),
        backgroundColor: Colors.brown, // Define a cor de fundo da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Adiciona um padding em torno do conteúdo
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Alinha os elementos verticalmente ao centro
            crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os elementos horizontalmente
            children: <Widget>[
              const Text(
                'Peso:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8), // Espaçamento vertical
              TextField(
                controller: _weightController, // Controlador para o peso
                keyboardType: TextInputType.number, // Tipo de teclado numérico
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Borda do campo de texto
                  hintText: 'Ex: 70.5', // Dica de texto
                  suffixText: 'kg', // Sufixo (unidade)
                ),
                onChanged: (value) {
                  // Atualiza o resultado em tempo real (opcional, pode ser removido se preferir apenas no botão)
                  setState(() {
                    // Limpa resultados anteriores se o usuário mudar a entrada
                    if (imcResult.isNotEmpty || imcClassification.isNotEmpty) {
                      imcResult = '';
                      imcClassification = '';
                    }
                  });
                },
              ),
              const SizedBox(height: 20), // Espaçamento vertical

              const Text(
                'Altura:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8), // Espaçamento vertical
              TextField(
                controller: _heightController, // Controlador para a altura
                keyboardType: TextInputType.number, // Tipo de teclado numérico
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Borda do campo de texto
                  hintText: 'Ex: 1.75', // Dica de texto
                  suffixText: 'm', // Sufixo (unidade)
                ),
                onChanged: (value) {
                  // Atualiza o resultado em tempo real (opcional, pode ser removido se preferir apenas no botão)
                  setState(() {
                    // Limpa resultados anteriores se o usuário mudar a entrada
                    if (imcResult.isNotEmpty || imcClassification.isNotEmpty) {
                      imcResult = '';
                      imcClassification = '';
                    }
                  });
                },
              ),
              const SizedBox(height: 30), // Espaçamento vertical

              // Botão para calcular o IMC
              ElevatedButton(
                onPressed: _calculateIMC, // Chama a função de cálculo ao pressionar
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Cor do texto do botão
                  backgroundColor: Colors.brown, // Cor de fundo do botão
                  padding: const EdgeInsets.symmetric(vertical: 15), // Preenchimento vertical do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                  ),
                  elevation: 5, // Sombra do botão
                ),
                child: const Text(
                  'Calcular', // Texto do botão
                  style: TextStyle(fontSize: 18), // Tamanho da fonte
                ),
              ),
              const SizedBox(height: 20), // Espaçamento vertical

              // Texto que mostra o resultado em tempo real (atualizado no setState)
              Text(
                imcResult.isNotEmpty
                    ? 'Seu IMC é $imcResult\n$imcClassification'
                    : 'Aguardando cálculo do IMC...',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _FinanciamentoScreenState();
}

class _FinanciamentoScreenState extends State<Login> {
  final TextEditingController valorController = TextEditingController();
  final TextEditingController parcelasController = TextEditingController();
  final TextEditingController taxaController = TextEditingController();

  double valorParcela = 0.0;
  double montanteTotal = 0.0;

  void calcularFinanciamento() {
    double valorBem = double.tryParse(valorController.text) ?? 0.0;
    int numeroParcelas = int.tryParse(parcelasController.text) ?? 0;
    double taxaJuros = double.tryParse(taxaController.text) ?? 0.0 / 100;

    if (valorBem > 0 && numeroParcelas > 0 && taxaJuros >= 0) {
      double taxaMensal = taxaJuros / 12;
      double montante = valorBem * (1 + taxaMensal * numeroParcelas);
      double parcela = montante / numeroParcelas;

      setState(() {
        valorParcela = parcela;
        montanteTotal = montante;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, insira valores válidos!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Will Investimentos'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: valorController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Valor do Bem',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: parcelasController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Número de Parcelas',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: taxaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Taxa de Juros Mensal (%)',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: calcularFinanciamento,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text(
              'Valor da Parcela: R\$ ${valorParcela.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            Text(
              'Montante Total: R\$ ${montanteTotal.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
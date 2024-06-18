import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/navigation/settings/payment/credit_card.dart';
import 'package:levaeu_mobile/screens/navigation/settings/payment/money.dart';
import 'package:levaeu_mobile/screens/navigation/settings/payment/pix.dart';
import 'package:levaeu_mobile/utils/elevated_buttons.dart';

class Payment extends StatefulWidget{
  const Payment({super.key});

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Metódo de Pagamento",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            
            Container(
              constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButtonsForms.buildElevatedButtonIcon(
                Icons.credit_card, 
                "Cartão de crédito", 
                context, 
                () => const CreditCard(), 
                rootNavigator: true
              ),
            ),

            Container(
              constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
              alignment: Alignment.center,
              child: ElevatedButtonsForms.buildElevatedButtonIcon(
                Icons.attach_money_outlined, 
                "Dinheiro", 
                context, 
                () => const Money(), 
                rootNavigator: true
              ),
            ),
            
            Container(
              constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
              alignment: Alignment.center,
              child: ElevatedButtonsForms.buildElevatedButtonIcon(
                Icons.pix, 
                "Pix", 
                context, 
                () => const Pix(), 
                rootNavigator: true
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
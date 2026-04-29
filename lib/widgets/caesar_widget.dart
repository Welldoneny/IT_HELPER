import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_helper/liba/caesar.dart';

class CaesarWidget extends StatefulWidget {
  const CaesarWidget({super.key});

  @override
  State<CaesarWidget> createState() => _CaesarWidgetState();
}

class _CaesarWidgetState extends State<CaesarWidget> {
  final plainTextController = TextEditingController();
  final cipherTextController = TextEditingController();
  final shiftController = TextEditingController();
  Caesar caesar = Caesar();

  @override
  void dispose() {
    plainTextController.dispose();
    cipherTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    plainTextController.addListener(_encrypt);
    cipherTextController.addListener(_decrypt);
    shiftController.addListener(_onKeyChanged);
  }

  void _encrypt() {
    final plaintext = plainTextController.text;
    final key = int.tryParse(shiftController.text) ?? 0;
    final ciphertext = caesar.encryptWithSpaces(plaintext, key);
    cipherTextController.value = TextEditingValue(
      text: ciphertext,
      selection: TextSelection.collapsed(offset: ciphertext.length),
    );
  }

  void _decrypt() {
    final ciphertext = cipherTextController.text;
    final key = int.tryParse(shiftController.text) ?? 0;
    final plaintext = caesar.decryptWithSpaces(ciphertext, key);
    plainTextController.value = TextEditingValue(
      text: plaintext,
      selection: TextSelection.collapsed(offset: plaintext.length),
    );
  }

  void _onKeyChanged() {
    _encrypt();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Шифр Цезаря (лат. Notae Caesarianae), также известный как шифр сдвига или код Цезаря — разновидность шифра подстановки, в котором каждый символ в открытом тексте заменяется символом, находящимся на некотором постоянном числе позиций левее или правее него в алфавите.',
          ),
          Align(
            alignment: Alignment.center,
            child: Image(
              height: 300,
              alignment: Alignment.center,
              image: AssetImage('assets/images/Caesar.png'),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("Прямой текст:"),
                    SizedBox(height: 8),
                    TextField(
                      controller: plainTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Что зашифровать',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    Text("Ключ"),
                    SizedBox(height: 8),
                    TextField(
                      controller: shiftController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Разрешает только цифры
                      ],
                      decoration: InputDecoration(
                        labelText: "Введите число",
                        hintText: "0",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text("Шифротекст:"),
                    SizedBox(height: 8),
                    TextField(
                      controller: cipherTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Что расшифровать',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

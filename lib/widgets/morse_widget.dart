import 'package:flutter/material.dart';
import 'package:it_helper/liba/morse.dart';

class MorseWidget extends StatefulWidget {
  const MorseWidget({super.key});

  @override
  State<MorseWidget> createState() => _MorseWidgetState();
}

class _MorseWidgetState extends State<MorseWidget> {
  final plainTextController = TextEditingController();
  final cipherTextController = TextEditingController();
  final morse = Morse();

  @override
  void dispose() {
    plainTextController.dispose();
    cipherTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Азбука Мо́рзе, код Мо́рзе, разг. морзя́нка — способ знакового кодирования, в котором буквы, цифры, знаки препинания и другие символы представляются в виде последовательностей коротких и длинных сигналов, называемых «точками» и «тире». Предназначена для передачи по последовательным каналам связи.',
          ),

          Align(
            alignment: Alignment.center,
            child: Image(
              alignment: Alignment.center,
              image: AssetImage('assets/images/International_Morse_Code.png'),
            ),
          ),

          const SizedBox(height: 16),
          Divider(),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Человеческая речь:"),
                    SizedBox(height: 8),
                    TextField(
                      onChanged: (text) {
                        final encoded = morse.encode(text);
                        cipherTextController.value = TextEditingValue(
                          text: encoded,
                          selection: TextSelection.collapsed(
                            offset: encoded.length,
                          ),
                        );
                      },
                      controller: plainTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Что зашифровать',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Код Морзе:"),
                    SizedBox(height: 8),
                    TextField(
                      onChanged: (text) {
                        final decoded = morse.decode(text);

                        plainTextController.value = TextEditingValue(
                          text: decoded,

                          selection: TextSelection.collapsed(
                            offset: decoded.length,
                          ),
                        );
                      },
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

import 'package:flutter_test/flutter_test.dart';
import 'package:it_helper/liba/morse.dart';

void main() {
  group('Test encoding', () {
    Morse morse = Morse();
    test(
      'Hello World! encode should be .... . .-.. .-.. --- / .-- --- .-. .-.. -.. -.-.--',
      () {
        expect(
          morse.encode("Hello World!"),
          ".... . .-.. .-.. --- / .-- --- .-. .-.. -.. -.-.--",
        );
      },
    );

    test('SOS encode should be ... --- ...', () {
      expect(morse.encode("SOS"), "... --- ...");
    });

    test('Unsupported characters encode should be empty string', () {
      expect(morse.encode('Неподходящий'), "");
    });
  });
}

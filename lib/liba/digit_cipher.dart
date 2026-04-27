import 'permutation.dart';

class DigitCipher {
  final String _alphabetWithSpace = " ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final String _russianAlphabet = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЭЮЯ_";
  final PermutationCipher _permutationCipher = PermutationCipher();

  String _findIndex(List<List<String>> matrix, String letter) {
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == letter) {
          return "$i$j";
        }
      }
    }
    return ""; // буква не найдена
  }

  String encodeTable(String plaintext, int key) {
    String cipherAlphabet = _permutationCipher.encryptSkitalla(
      _russianAlphabet,
      key,
    );
    //cipherAlphabet = cipherAlphabet.replaceAll('*', '');
    String ciphertext = "";
    int n = (_russianAlphabet.length - 1) ~/ key + 1;
    List<List<String>> matrix = List.generate(key, (_) => List.filled(n, ' '));
    for (int i = 0; i < key; i++) {
      for (int j = 0; j < n; j++) {
        matrix[i][j] = cipherAlphabet[i * n + j];
      }
    }
    for (int i = 0; i < plaintext.length; i++) {
      ciphertext += _findIndex(matrix, plaintext[i]);
      ciphertext += ' ';
    }
    return ciphertext.substring(0, ciphertext.length - 1);
  }

  String decodeTable(String ciphertext, int key) {
    String plaintext = "";
    String cipherAlphabet = _permutationCipher.encryptSkitalla(
      _russianAlphabet,
      key,
    );
    int n = (_russianAlphabet.length - 1) ~/ key + 1;
    List<List<String>> matrix = List.generate(key, (_) => List.filled(n, ' '));
    for (int i = 0; i < key; i++) {
      for (int j = 0; j < n; j++) {
        matrix[i][j] = cipherAlphabet[i * n + j];
      }
    }
    List<String> digits = ciphertext.split(' ');
    for(String digit in digits){
      try{
        int index = int.parse(digit);
        int rows = index ~/ 10;
        int cols = index % 10;
        plaintext += matrix[rows][cols];
      } catch (e){
        plaintext += digit;
      }
    }
    return plaintext;
  }

  String encodeAlphabet(String plaintext) {
    String ciphertext = "";
    plaintext = plaintext.toUpperCase();
    for (int i = 0; i < plaintext.length; i++) {
      ciphertext += _alphabetWithSpace.indexOf(plaintext[i]).toString();
      ciphertext += " ";
    }
    return ciphertext;
  }

  String decodeAlphabet(String ciphertext) {
    List<String> digits = ciphertext.split(' ');
    String plaintext = "";
    for (String digit in digits) {
      int index = -1;
      try {
        index = int.parse(digit);
        plaintext += _alphabetWithSpace[index];
      } catch (e) {
        plaintext += digit;
      }
    }
    return plaintext;
  }
}

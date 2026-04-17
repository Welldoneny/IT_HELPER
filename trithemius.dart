class Trithemius {
  static const String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  /// Шифрование текста методом Тритимуса
  static String encrypt(String plaintext) {
    plaintext = plaintext.toUpperCase();
    String ciphertext = '';

    for (int i = 0; i < plaintext.length; i++) {
      String char = plaintext[i];
      if (alphabet.contains(char)) {
        int p = alphabet.indexOf(char);
        int shift = i;
        int c = (p + shift) % alphabet.length;
        ciphertext += alphabet[c];
      } else {
        ciphertext += char;
      }
    }
    return ciphertext;
  }

  /// Дешифрование текста
  static String decrypt(String ciphertext) {
    ciphertext = ciphertext.toUpperCase();
    String plaintext = '';

    for (int i = 0; i < ciphertext.length; i++) {
      String char = ciphertext[i];
      if (alphabet.contains(char)) {
        int c = alphabet.indexOf(char);
        int shift = i;
        int p = (c - shift + alphabet.length) % alphabet.length;
        plaintext += alphabet[p];
      } else {
        plaintext += char;
      }
    }
    return plaintext;
  }
}

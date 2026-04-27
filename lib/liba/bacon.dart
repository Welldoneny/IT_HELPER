class Bacon {
  final String _alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
  final Map<String, String> _letters = {
    "A": "00000",
    "B": "00001",
    "C": "00010",
    "D": "00011",
    "E": "00100",
    "F": "00101",
    "G": "00110",
    "H": "00111",
    "I": "01000",
    "J": "01001",
    "K": "01010",
    "L": "01011",
    "M": "01100",
    "N": "01101",
    "O": "01110",
    "P": "01111",
    "Q": "10000",
    "R": "10001",
    "S": "10010",
    "T": "10011",
    "U": "10100",
    "V": "10101",
    "W": "10110",
    "X": "10111",
    "Y": "11000",
    "Z": "11001",
    " ": "11010",
  };

  Map<String, String> _buildReverseMap() {
    return _letters.map((key, value) => MapEntry(value, key));
  }

  String decrypt(String ciphertext) {
    String codes = "";
    String plaintext = "";
    var reverse = _buildReverseMap();
    ciphertext = ciphertext.toUpperCase();
    for (int i = 0; i < ciphertext.length; i++) {
      codes += _alphabet.indexOf(ciphertext[i]) % 2 == 0 ? "0" : "1";
    }
    for (int i = 0; i < codes.length; i += 5) {
      String code = codes.substring(i, i + 5);
      plaintext += reverse[code]!;
    }

    return plaintext;
  }
}

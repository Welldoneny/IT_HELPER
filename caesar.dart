// A class implementing the classic Caesar cipher for the English alphabet
class Caesar {
  final String _alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final String _alphabetWithSpace = " ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final int indexofE = 4;
  final int indexOfA = 0;
  // ignore: unused_field
  final Map<String, double> _letterFrequencies = {
    'A': 0.0817,
    'B': 0.0149,
    'C': 0.0278,
    'D': 0.0425,
    'E': 0.1270,
    'F': 0.0223,
    'G': 0.0202,
    'H': 0.0609,
    'I': 0.0697,
    'J': 0.0015,
    'K': 0.0077,
    'L': 0.0403,
    'M': 0.0241,
    'N': 0.0675,
    'O': 0.0751,
    'P': 0.0193,
    'Q': 0.0010,
    'R': 0.0599,
    'S': 0.0633,
    'T': 0.0906,
    'U': 0.0276,
    'V': 0.0098,
    'W': 0.0236,
    'X': 0.0015,
    'Y': 0.0197,
    'Z': 0.0007,
  };
  final String _frequencies = "ETAOINSHRDLCUMWFGYPBVKJXQZ";

  /*
  Shifts the letters in the message by the number specified by the key, 
  ignoring spaces and characters outside the alphabet
  */
  String encrypt(String plaintext, [int key = 3]) {
    plaintext = plaintext.toUpperCase();
    String ciphertext = "";
    for (int i = 0; i < plaintext.length; i++) {
      if (plaintext[i] == " ") {
        ciphertext += " ";
        continue;
      }
      int positionInAlphabet;
      positionInAlphabet = _alphabet.indexOf(plaintext[i]);
      if (positionInAlphabet == -1) {
        ciphertext += plaintext[i];
        continue;
      }
      ciphertext += _alphabet[(positionInAlphabet + key) % _alphabet.length];
    }
    return ciphertext;
  }

  /*
  Shifts the value of the key alphabetically with a space, 
  ignoring all other characters
  */
  String encryptWithSpaces(String plaintext, [int key = 3])
  {
    plaintext = plaintext.toUpperCase();
    String ciphertext = "";
    for (int i = 0; i < plaintext.length; i++) {
      int positionInAlphabet;
      positionInAlphabet = _alphabetWithSpace.indexOf(plaintext[i]);
      if (positionInAlphabet == -1) {
        continue;
      }
      ciphertext += _alphabetWithSpace[(positionInAlphabet + key) % _alphabetWithSpace.length];
    }
    return ciphertext;    
  }

  /*
  Shifts back the value of the key alphabetically with a space, 
  ignoring all other characters
  */
  String decryptWithSpaces(String ciphertext, [int key = 3])
  {
    ciphertext = ciphertext.toUpperCase();
    String plaintext = "";
    for (int i = 0; i < ciphertext.length; i++) {
      int positionInAlphabet;
      positionInAlphabet = _alphabetWithSpace.indexOf(ciphertext[i]);
      if (positionInAlphabet == -1) {
        continue;
      }
      plaintext += _alphabetWithSpace[(positionInAlphabet - key) % _alphabetWithSpace.length];
    }
    return plaintext;    
  }
  /*
  Shifts letters back in the message by the number specified by the key,
  ignoring spaces and characters outside the alphabet
  */
  String decrypt(String ciphertext, [int key = 3]) {
    ciphertext = ciphertext.toUpperCase();
    String plaintext = "";
    for (int i = 0; i < ciphertext.length; i++) {
      if (ciphertext[i] == " ") {
        plaintext += " ";
        continue;
      }
      int positionInAlphabet;
      positionInAlphabet = _alphabet.indexOf(ciphertext[i]);
      if (positionInAlphabet == -1) {
        plaintext += ciphertext[i];
        continue;
      }
      plaintext += _alphabet[(positionInAlphabet - key) % _alphabet.length];
    }
    return plaintext;
  }

  // Matches letters by frequency
  String frequencyMerge(String ciphertext) {
    String plaintext = "";
    var cipherLetterFrequencies = getFrequencies(ciphertext);
    String cipherFrequencies = _mapToString(cipherLetterFrequencies);
    for (int i = 0; i < ciphertext.length; i++){
      if (_alphabet.contains(ciphertext[i])){
        int position = cipherFrequencies.indexOf(ciphertext[i]);
        plaintext += _frequencies[position];
      }
      else{
        plaintext += ciphertext[i];
      }
    }

    return plaintext;
  }

  /* 
  Computes the key by matching the position 
  of the most frequent letter with the letter E 
  */
  String frequencyShift(String ciphertext, [int suggestion = 0]){
    var cipherLetterFrequencies = getFrequencies(ciphertext);
    String cipherFrequencies = _mapToString(cipherLetterFrequencies); 

    String firstChar = cipherFrequencies[suggestion];
    int position = _alphabet.indexOf(firstChar);
    int shift = position - indexofE;
    String plaintext = decrypt(ciphertext, shift);
    return plaintext;
  }

  // Converts frequency map to th string
  String _mapToString(Map<String, double> map){
    List<MapEntry<String, double>> entries = map.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    String result = entries.map((e) => e.key).join();
    return result;
  }

  /*
  Suggests that the articles the and a are the most frequent words
  */
  String frequencyWord(String ciphertext){
    String plaintext = "";
    ciphertext = ciphertext.toUpperCase();
    String withSpaces = ciphertext.replaceAll(RegExp(r'[^A-Z ]'), '');
    List<String> words = withSpaces.split(' ');
    List<String> topWords = [];
    for (String word in words){
      if (word.length == 1 || word.length == 3)
        topWords.add(word);
    }
    Map<String, int> topWordsFreq = _countWordFrequencies(topWords);
    var sortedEntries = topWordsFreq.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    String? oneLetterCipher;
    String? threeLetterCipher;
    
    for (var entry in sortedEntries) {
      if (entry.key.length == 1 && oneLetterCipher == null) {
        oneLetterCipher = entry.key;
      }
      if (entry.key.length == 3 && threeLetterCipher == null) {
        threeLetterCipher = entry.key;
      }
    }
    int shift = _alphabet.indexOf(oneLetterCipher?? "A");
    if ("THE" == decrypt(threeLetterCipher?? "THE", shift)){
      plaintext = decrypt(ciphertext, shift);
    }
    return plaintext;
  }

  // Count words appearance
  Map<String, int> _countWordFrequencies(List<String> words) {
    Map<String, int> freq = {};
    for (String word in words) {
      if (word.isNotEmpty) {
        freq[word] = (freq[word] ?? 0) + 1;
      }
    }
    return freq;
  }
  // Make map with frequencies in of letters in the text
  Map<String, double> getFrequencies(String ciphertext){
    ciphertext = ciphertext.toUpperCase();
    String cleanText = ciphertext.replaceAll(RegExp(r'[^A-Z]'), '');
    Map<String, double> cipherLetterFrequencies = {
      'A': 0,
      'B': 0,
      'C': 0,
      'D': 0,
      'E': 0,
      'F': 0,
      'G': 0,
      'H': 0,
      'I': 0,
      'J': 0,
      'K': 0,
      'L': 0,
      'M': 0,
      'N': 0,
      'O': 0,
      'P': 0,
      'Q': 0,
      'R': 0,
      'S': 0,
      'T': 0,
      'U': 0,
      'V': 0,
      'W': 0,
      'X': 0,
      'Y': 0,
      'Z': 0,
    };
    for (int i = 0; i < cleanText.length; i++) {
      cipherLetterFrequencies[cleanText[i]] =
          cipherLetterFrequencies[cleanText[i]]! + 1.0;
    }
    cipherLetterFrequencies.forEach((key, value) {
      cipherLetterFrequencies[key] = value / cleanText.length;
    });

    return cipherLetterFrequencies;
  }
}
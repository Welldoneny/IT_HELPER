class Vigenere{
  final String _alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  //final String _alphabetWithSpace = " ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  String encrypt(String plaintext, String key){
    plaintext = plaintext.toUpperCase();
    String k = key;
    String ciphertext = "";
    if( key.length < plaintext.length){
      key += k * (plaintext.length ~/ k.length);
      if ( key.length < plaintext.length){
        for(int i = 0; i < plaintext.length - key.length; i++){
          key += k[i];
        }
      }
    }
    for(int i = 0; i < plaintext.length; i++){
      int shift = _alphabet.indexOf(key[i]);
      int index = _alphabet.indexOf(plaintext[i]);
      ciphertext += _alphabet[(index + shift) % _alphabet.length];
    }
    return ciphertext;
  }

  String decrypt(String ciphertext, String key){
    ciphertext = ciphertext.toUpperCase();
    String plaintext = "";
    String k = key;
    if( key.length < ciphertext.length){
      key += k * (ciphertext.length ~/ k.length);
      if ( key.length < ciphertext.length){
        for(int i = 0; i < ciphertext.length - key.length; i++){
          key += k[i];
        }
      }
    }
    for(int i = 0; i < ciphertext.length; i++){
      int shift = _alphabet.indexOf(key[i]);
      int index = _alphabet.indexOf(ciphertext[i]);
      plaintext += _alphabet[(index - shift) % _alphabet.length];
    }
    return plaintext;
  }
}
class PermutationCipher {
  String encryptSkitalla(String plaintext, int m){
    String ciphertext = "";
    int n = (plaintext.length - 1) ~/ m + 1;
    if(n*m > plaintext.length){
      plaintext += "*" * (n*m - plaintext.length);
    }
    List<List<String>> matrix = List.generate(m, (_) => List.filled(n, ' '));
    for(int i = 0; i < m; i++){
      for(int j = 0; j < n; j++){
        matrix[i][j] = plaintext[i*n + j];
      }
    }
    for (int i = 0; i < n; i++){
      for(int j = 0; j < m; j++){
        ciphertext += matrix[j][i];
      }
    }
    return ciphertext;
  }

  String decryptSkitalla(String ciphertext, int m){
    String plaintext = "";
    int n = (ciphertext.length - 1) ~/ m + 1;
    List<List<String>> matrix = List.generate(m, (_) => List.filled(n, ' '));
    for(int i = 0; i < n; i++){
      for(int j = 0; j < m; j++){
        matrix[j][i] = ciphertext[i*m + j];
      }
    }
    for(int i = 0; i < m; i++){
      for(int j = 0; j < n; j++){
        plaintext += matrix[i][j];
      }
    }
    return plaintext.replaceAll('*', '');
  }
}
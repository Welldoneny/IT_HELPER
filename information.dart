import 'dart:math';

class Information {
  double hartley(int N) {
    return log(N) / ln2;
  }

  double Shannon(List<double> P) {
    double tmp = 0;
    for (int i = 0; i < P.length; i++){
      tmp += P[i] * log(P[i]);
    }
    return -tmp;
  }
}

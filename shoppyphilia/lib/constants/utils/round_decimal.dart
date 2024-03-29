import 'dart:math';

double decimalRound(double val, int places){
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}
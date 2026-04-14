import 'dart:io';
import 'caesar.dart';

void main(){
  File file = File("./texts/hundred.txt");
  Caesar c = Caesar();
  String txt = file.readAsStringSync();

}

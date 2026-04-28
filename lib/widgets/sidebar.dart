import 'package:flutter/material.dart';
enum Topic { greeting, caesar, bacon, digitCipher, morse }

Widget sidebar(){
  return ListView(
    children: [
      ListTile(
        title: Text('Caesar Cipher'),
        onTap: () {

        },
      ),
      ListTile(
        title: Text('Bacon Cipher'),
        onTap: () {
          // Handle tap for Bacon Cipher
        },
      ),
      ListTile(
        title: Text('Morse Code'),
        onTap: () {
          // Handle tap for Morse Code
        },
      ),
    ],
  );
}
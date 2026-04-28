import 'package:flutter/material.dart';
import 'package:it_helper/widgets/bacon_widget.dart';
import 'package:it_helper/widgets/caesar_widget.dart';
import 'package:it_helper/widgets/greeting__widget.dart';
import 'package:it_helper/widgets/morse_widget.dart';
//import 'package:it_helper/widgets/sidebar.dart';

enum Topic { greeting, caesar, bacon, digitCipher, morse }

class MainPage extends StatefulWidget {
  const MainPage(Key? key) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Topic selectedTopic = Topic.greeting;
  final pages = {
    Topic.caesar: caesarWidget(),
    Topic.bacon: baconWidget(),
    Topic.morse: MorseWidget(),
    Topic.greeting: greetingWidget(),
  };
  void onTopicSelected(Topic topic) {
    setState(() {
      selectedTopic = topic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          color: Colors.grey[200],
          child: ListView(
            children: [
              ListTile(
                title: Text('Caesar Cipher'),
                onTap: () => onTopicSelected(Topic.caesar),
              ),
              ListTile(
                title: Text('Bacon Cipher'),
                onTap: () => onTopicSelected(Topic.bacon),
              ),
              ListTile(
                title: Text('Morse Code'),
                onTap: () => onTopicSelected(Topic.morse),
              ),
            ],
          ),
        ),
        Expanded(child: pages[selectedTopic]!),
      ],
    );
  }
}

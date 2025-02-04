import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/screens/character_search_screen.dart';
import 'package:flutter_rick_and_morty/screens/episode_screen.dart';
import 'package:flutter_rick_and_morty/screens/location_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});
  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int selectedIndex = 0;

  final List widgetOptions = [
    const CharacterSearchScreen(),
    const LocationScreen(),
    const EpisodeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/character_24px_selected.png',
              height: 20,
              width: 20,
            ),
            label: 'Персонажи',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/location_24px.png',
              height: 20,
              width: 20,
              color: Colors.blue,
            ),
            label: 'Локации',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Эпизоды',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/screens/character_search_screen.dart';
import 'package:flutter_rick_and_morty/screens/episode_screen.dart';
import 'package:flutter_rick_and_morty/screens/location_screen.dart';
import 'package:flutter_rick_and_morty/screens/setting_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    const SettingsScreen(),
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
              color: Colors.grey,
            ),
            label: 'Персонажи',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/location_24px12.svg',
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Локации',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/episode.svg',
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Эпизоды',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/Settings.3.svg'),
            label: 'Настройки',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        iconSize: 50,
      ),
    );
  }
}

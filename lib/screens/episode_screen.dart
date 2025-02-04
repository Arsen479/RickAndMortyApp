import 'package:flutter/material.dart';

class EpisodeScreen extends StatefulWidget {
  const EpisodeScreen({super.key});
  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EpisodeScreen'),
      ),
      body: Column(
        children: [
          Container(),
        ],
      ),
    );
  }
}
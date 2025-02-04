import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc/rick_and_morty_bloc.dart';
import 'package:flutter_rick_and_morty/models/character_model.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Result character;
  final RickAndMortyLoadedState state;
  const CharacterDetailsScreen(
      {super.key, required this.character, required this.state});
  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  late final RickAndMortyBloc bloc;

  @override
  void initState() {
    bloc = RickAndMortyBloc();
    bloc.add(GetAllCharacter());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CharacterDetailsScreen'),
      ),
      body: BlocBuilder<RickAndMortyBloc, RickAndMortyState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is RickAndMortyLoadedState) {
            return Column(
              children: [
                Container(
                  child: Text(state.characters[0].name!),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

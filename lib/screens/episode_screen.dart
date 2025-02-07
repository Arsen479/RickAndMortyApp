// import 'package:flutter/material.dart';
// import 'package:flutter_rick_and_morty/bloc_character/bloc_all_episode/episode_bloc.dart';

// class EpisodeScreen extends StatefulWidget {
//   const EpisodeScreen({super.key});
//   @override
//   State<EpisodeScreen> createState() => _EpisodeScreenState();
// }

// class _EpisodeScreenState extends State<EpisodeScreen> {
//   late final EpisodeBloc episodeBloc;

//   @override
//   void initState() {
//     episodeBloc = EpisodeBloc();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     episodeBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('EpisodeScreen'),
//       ),
//       body: Column(
//         children: [
//           Container(),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc_character/bloc_all_episode/episode_bloc.dart';
import 'package:flutter_rick_and_morty/models/episode_model.dart';

class EpisodeScreen extends StatefulWidget {
  const EpisodeScreen({super.key});

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> with SingleTickerProviderStateMixin {
  late final EpisodeBloc episodeBloc;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    episodeBloc = EpisodeBloc()..add((GetALLEpisode()));
  }

  @override
  void dispose() {
    episodeBloc.close();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Эпизоды')),
      body: BlocBuilder<EpisodeBloc, EpisodeState>(
        bloc: episodeBloc,
        builder: (context, state) {
          if (state is EpisodeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EpisodeLoaded) {
            final seasons = state.episodes.keys.toList();
            _tabController = TabController(length: seasons.length, vsync: this);

            return Column(
              children: [
                // TabBar для сезонов
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorColor: Colors.blue,
                  tabs: seasons.map((season) => Tab(text: "Сезон ${season.substring(1)}")).toList(),
                ),

                // TabBarView с эпизодами
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: seasons.map((season) {
                      final episodes = state.episodes[season]!;
                      return ListView.builder(
                        itemCount: episodes.length,
                        itemBuilder: (context, index) {
                          final episode = episodes[index];
                          return ListTile(
                            title: Text(episode.name!),
                            subtitle: Text(episode.airDate!),
                            leading: CircleAvatar(child: Text(episode.episode!.split('E')[1])),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("Ошибка загрузки эпизодов"));
          }
        },
      ),
    );
  }
}

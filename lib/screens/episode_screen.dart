import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc_character/bloc_all_episode/episode_bloc.dart';
import 'package:flutter_rick_and_morty/screens/episode_detail_screen.dart';
//import 'package:flutter_rick_and_morty/models/episode_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EpisodeScreen extends StatefulWidget {
  const EpisodeScreen({super.key});

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen>
    with SingleTickerProviderStateMixin {
  late final EpisodeBloc episodeBloc;
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    episodeBloc = EpisodeBloc()..add(GetALLEpisode());
  }

  @override
  void dispose() {
    episodeBloc.close();
    tabController?.dispose(); // Проверяем, создан ли контроллер
    super.dispose();
  }

  void updateTabController(int length) {
    tabController?.dispose(); // Удаляем старый контроллер, если он есть
    tabController = TabController(length: length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Найти персонажа',
            hintStyle: TextStyle(color: Colors.black54),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.black12,
          ),
          style: TextStyle(color: Colors.black),
          onChanged: (value) {},
        ),
      ),
      body: BlocBuilder<EpisodeBloc, EpisodeState>(
        bloc: episodeBloc,
        builder: (context, state) {
          if (state is EpisodeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EpisodeLoaded) {
            final seasons = state.episodes.keys.toList();

            if (tabController == null ||
                tabController!.length != seasons.length) {
              updateTabController(seasons.length);
            }

            return Column(
              children: [
                TabBar(
                  controller: tabController,
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorColor: Colors.blue,
                  tabs: seasons
                      .map(
                          (season) => Tab(text: "Сезон ${season.substring(2)}"))
                      .toList(),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: seasons.map((season) {
                      final episodes = state.episodes[season]!;
                      return ListView.builder(
                        itemCount: episodes.length,
                        itemBuilder: (context, index) {
                          final episode = episodes[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EpisodeDetailScreen(episode: episode),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(episode.name!),
                              subtitle: Text(episode.airDate!),
                              leading: Text(episode.episode!.split('E')[1]),
                            ),
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

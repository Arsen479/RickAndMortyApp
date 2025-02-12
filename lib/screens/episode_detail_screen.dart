import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc_character/bloc_characters_in_episode/characters_in_episode_bloc.dart';
import 'package:flutter_rick_and_morty/models/character_model.dart';
import 'package:flutter_rick_and_morty/models/episode_model.dart';
import 'package:flutter_rick_and_morty/screens/character_details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EpisodeDetailScreen extends StatefulWidget {
  final Results episode;
  const EpisodeDetailScreen({super.key, required this.episode});

  @override
  State<EpisodeDetailScreen> createState() => _EpisodeDetailScreenState();
}

class _EpisodeDetailScreenState extends State<EpisodeDetailScreen> {
  late final CharactersInEpisodeBloc charactersInEpisodeBloc;

  @override
  void initState() {
    charactersInEpisodeBloc = CharactersInEpisodeBloc();
    charactersInEpisodeBloc
        .add(GetCharactersEpisode(widget.episode.characters!));
    super.initState();
  }

  @override
  void dispose() {
    charactersInEpisodeBloc.close();
    super.dispose();
  }

  getStatus(Status status) {
    if (status == Status.ALIVE) {
      return Colors.green;
    } else if (status == Status.DEAD) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: 255,
              width: 375.w,
              color: Colors.grey,
              child: Image.asset(
                'assets/Rectangle 1.png',
                width: double.infinity,
                height: 280.h,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 230),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Основа, база так сказать
                  Container(
                    width: double.infinity,
                    //height: MediaQuery.of(context).size.height,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.episode.name ?? 'Неизвестно',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'СЕРИЯ ${widget.episode.episode!.substring(5)}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Зигерионцы помещают Джерри и Рика в симуляцию, '
                          'чтобы узнать секрет изготовления концентрированной темной материи.',
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.black87),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Премьера',
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                        Text(
                          widget.episode.airDate ?? 'Неизвестно',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Персонажи',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BlocBuilder<CharactersInEpisodeBloc,
                            CharactersInEpisodeState>(
                          bloc: charactersInEpisodeBloc,
                          builder: (context, state) {
                            if (state is CharactersInEpisodeLoaded) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.charactersInEpisode.length,
                                itemBuilder: (context, index) {
                                  final character =
                                      state.charactersInEpisode[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CharacterDetailsScreen(
                                            character: state
                                                .charactersInEpisode[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.h),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(70.r),
                                            child: character.image != null
                                                ? Image.network(
                                                    character.image!,
                                                    width: 74.w,
                                                    height: 74.h,
                                                    fit: BoxFit.cover,
                                                  )
                                                : const Placeholder(),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${character.status}',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: getStatus(
                                                    character.status!),
                                              ),
                                            ),
                                            Text(character.name!),
                                            Text(
                                                '${character.species} - ${character.gender}'),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else if (state is CharactersInEpisodeError) {
                              return Text(state.error);
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //картинка паузы
            Padding(
              padding: EdgeInsets.symmetric(vertical: 140.h, horizontal: 120.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(70.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/Group.png',
                  width: 132.w,
                  height: 132.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

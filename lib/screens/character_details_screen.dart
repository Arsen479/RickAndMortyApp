import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc/bloc_character_episode/character_episode_bloc.dart';
//import 'package:flutter_rick_and_morty/bloc/character_episode_bloc.dart';
import 'package:flutter_rick_and_morty/models/character_model.dart';
//import 'package:flutter_rick_and_morty/repository/repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Result character;
  const CharacterDetailsScreen({super.key, required this.character});

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  late final CharacterEpisodeBloc episodeBloc;

  @override
  void initState() {
    super.initState();
    //episodeBloc = CharacterEpisodeBloc(repository: Repository());
    print(widget.character.episode);
    print(widget.character.episode.runtimeType);
    episodeBloc = CharacterEpisodeBloc();
    episodeBloc.add(GetCharacterEpisode(widget.character.episode!));
  }

  @override
  void dispose() {
    episodeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Верхняя часть с аватаром персонажа
          Container(
            height: 218.h,
            width: 375.w,
            color: Colors.blue,
            child: Image.network(
              widget.character.image!,
              height: 250.h,
              width: 375.w,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 130.h, left: 102.h),
            child: Container(
              height: 170.h,
              width: 170.w,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
          ),
          // Информация о персонаже
          Column(
            children: [
              SizedBox(height: 140.h),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80.r),
                  child: Image.network(
                    widget.character.image!,
                    height: 150.h,
                    width: 150.w,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                widget.character.name!,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '${widget.character.status}',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10.h),
              Container(
                width: 343.w,
                height: 80.h,
                color: Colors.transparent,
                child: Text(
                  'Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери.',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),

              Container(
                color: Colors.transparent,
                width: 343.w,
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Пол',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          '${widget.character.gender}',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        const Text(
                          'Расса',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          '${widget.character.species}',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                color: Colors.transparent,
                width: 343.w,
                height: 100.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Место рождения',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '${widget.character.origin!.name}',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10.h),
                    const Text(
                      'Местоположение',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '${widget.character.location!.name}',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Text('Эпизоды', style: TextStyle(fontSize: 24.sp)),
              // Блок с эпизодами
              Expanded(
                child: BlocBuilder<CharacterEpisodeBloc, CharacterEpisodeState>(
                  bloc: episodeBloc,
                  builder: (context, state) {
                    if (state is CharacterEpisodeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CharacterEpisodeLoaded) {
                      return ListView.builder(
                        itemCount: state.episodes.length,
                        itemBuilder: (context, index) {
                          final episode = state.episodes[index];
                          return ListTile(
                            title: Row(
                              children: [
                                Image.asset(
                                  'assets/Rectangle 11.png',
                                  height: 74.h,
                                  width: 74.w,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${episode.episode}'),
                                    Container(
                                      width: 250.w,
                                      color: Colors.transparent,
                                      child: Text(
                                        episode.name!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Text('Дата выхода: ${episode.airDate!}'),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (state is CharacterEpisodeError) {
                      return Center(
                        child: Text(
                          'Ошибка: ${state.error}',
                          style: TextStyle(color: Colors.red, fontSize: 18.sp),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
          // Кнопка назад
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

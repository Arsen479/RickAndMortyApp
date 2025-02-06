import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc/rick_and_morty_bloc.dart';
import 'package:flutter_rick_and_morty/screens/character_details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CharacterSearchScreen extends StatefulWidget {
  const CharacterSearchScreen({super.key});

  @override
  State<CharacterSearchScreen> createState() => _CharacterSearchState();
}

class _CharacterSearchState extends State<CharacterSearchScreen> {
  bool isGridView = false; 
  bool isLoadingMore = false; 

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RickAndMortyBloc()..add(GetAllCharacter()),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
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
                onChanged: (value) {
                  context
                      .read<RickAndMortyBloc>()
                      .add(GetCharacterByName(value));
                },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Всего персонажей: 826',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      IconButton(
                        icon: Icon(
                          isGridView ? Icons.list : Icons.grid_view,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isGridView = !isGridView;
                          });
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: BlocConsumer<RickAndMortyBloc, RickAndMortyState>(
                      listener: (context, state) {
                        if (state is RickAndMortyLoadedState) {
                          setState(() {
                            isLoadingMore = false;
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is RickAndMortyLoadedState) {
                          return RefreshIndicator(
                            onRefresh: () {
                              context
                                  .read<RickAndMortyBloc>()
                                  .add(GetAllCharacter());
                              return Future.delayed(Duration(seconds: 1));
                            },
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (scrollNotification) {
                                if (scrollNotification.metrics.pixels ==
                                        scrollNotification
                                            .metrics.maxScrollExtent &&
                                    !isLoadingMore) {
                                  setState(() {
                                    isLoadingMore = true;
                                  });
                                  context
                                      .read<RickAndMortyBloc>()
                                      .add(GetMoreCharacters());
                                }
                                return false;
                              },
                              child: isGridView
                                  ? GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10.w,
                                        childAspectRatio: 0.62.w,
                                      ),
                                      itemCount: state.characters.length,
                                      itemBuilder: (context, index) {
                                        final character =
                                            state.characters[index];
                                        return characterGridCard(character);
                                      },
                                    )
                                  : ListView.builder(
                                      itemCount: state.characters.length,
                                      itemBuilder: (context, index) {
                                        final character =
                                            state.characters[index];
                                        return characterListCard(character);
                                      },
                                    ),
                            ),
                          );
                        } else if (state is RickAndMortyErrorState) {
                          return Center(
                            child: Text(
                              state.error,
                              style:
                                  TextStyle(fontSize: 16.sp, color: Colors.red),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget characterListCard(character) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailsScreen(character: character,),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(70.r),
              child: character.image != null
                  ? Image.network(
                      character.image!,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.cover,
                    )
                  : Placeholder(),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${character.status ?? ''}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: character.status == 'Alive'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  Text(
                    character.name ?? '',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${character.species}, ${character.gender}',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                  Text(
                    '${character.origin.name}',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget characterGridCard(character) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CharacterDetailsScreen(character: character),//character: character),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(70.r),
              child: character.image != null
                  ? Image.network(
                      character.image!,
                      width: 130.w,
                      height: 130.h,
                      fit: BoxFit.cover,
                    )
                  : Placeholder(),
            ),
            Text(
              '${character.status ?? ''}',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              character.name ?? '',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '${character.gender}',
              style: TextStyle(fontSize: 16.sp),
            ),
            Text('${character.species},')
          ],
        ),
      ),
    );
  }
}

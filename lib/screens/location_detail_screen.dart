import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc_character/bloc_location_residents/location_residents_bloc.dart';
import 'package:flutter_rick_and_morty/models/character_model.dart';
import 'package:flutter_rick_and_morty/models/location_model.dart';
import 'package:flutter_rick_and_morty/screens/character_details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationDetailScreen extends StatefulWidget {
  final ResultLocation resultLocation;

  const LocationDetailScreen({super.key, required this.resultLocation});
  @override
  State<LocationDetailScreen> createState() => _LocationDetailState();
}

class _LocationDetailState extends State<LocationDetailScreen> {
  late final LocationResidentsBloc locationResidentsBloc;

  @override
  void initState() {
    locationResidentsBloc = LocationResidentsBloc();
    locationResidentsBloc
        .add(GetLocationResidents(widget.resultLocation.residents!));
    super.initState();
  }

  @override
  void dispose() {
    locationResidentsBloc.close();
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
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LocationDetail'),
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(children: [
            Container(
              width: 383.w,
              height: 215.h,
              color: Colors.grey,
              child: Image.asset(
                'assets/Rectangle 11location.png',
                width: 383.w,
                height: 280.h,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 190.h),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    //height: MediaQuery.of(context).size.height, //450.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            widget.resultLocation.name!,
                            style: TextStyle(fontSize: 24.sp),
                          ),
                          SizedBox(
                            height: 51.h,
                          ),
                          const Text(
                              'Это планета, на которой проживает человеческая раса, и главное место для персонажей Рика и Морти. Возраст этой Земли более 4,6 миллиардов лет, и она является четвертой планетой от своей звезды.'),
                          SizedBox(
                            height: 36.h,
                          ),
                          Text(
                            'Персонажи',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          BlocBuilder<LocationResidentsBloc,
                              LocationResidentsState>(
                            bloc: locationResidentsBloc,
                            builder: (context, state) {
                              if (state is LocationResidentsLoaded) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.residents.length,
                                  itemBuilder: (context, index) {
                                    final character = state.residents[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CharacterDetailsScreen(
                                              character: state.residents[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                              } else if (state is LocationResidentsError) {
                                return Text(state.error);
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // BlocBuilder(
                  //   bloc: locationResidentsBloc,
                  //   builder: (context, state) {
                  //     if (state is LocationResidentsLoaded) {
                  //       return ListView.builder(
                  //         shrinkWrap: true,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         itemCount: state.residents.length,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           final resident = state.residents[index];
                  //           return Padding(
                  //             padding: EdgeInsets.all(8.w),
                  //             child: Container(
                  //               width: 343.w,
                  //               height: 200.h,
                  //               color: Colors.transparent,
                  //               alignment: Alignment.center,
                  //               child: Text(
                  //                 resident.name!,
                  //                 style: TextStyle(
                  //                     fontSize: 16.sp, fontWeight: FontWeight.bold),
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     } else if (state is LocationResidentsLoading) {
                  //       return Padding(
                  //         padding: EdgeInsets.only(top: 20.h),
                  //         child:const Center(
                  //           child: CircularProgressIndicator(),
                  //         ),
                  //       );
                  //     } else if (state is LocationResidentsError) {
                  //       return Center(
                  //         child: Text(state.error),
                  //       );
                  //     }
                  //     return SizedBox();
                  //   },
                  // )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

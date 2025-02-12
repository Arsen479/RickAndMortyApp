import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc_character/bloc_location/location_bloc.dart';
import 'package:flutter_rick_and_morty/models/location_model.dart';
import 'package:flutter_rick_and_morty/screens/location_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool isLoadingMore = false;
  late bool endPage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc()..add(GetLocation()),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'Найти локацию',
                  hintStyle: TextStyle(color: Colors.black54),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.black12,
                ),
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {},
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
            body: BlocConsumer<LocationBloc, LocationState>(
              //bloc: locationBloc,
              listener: (context, state) {
                if (state is LocationLoaded) {
                  setState(() {
                    isLoadingMore = false;
                    endPage = state.endPage ?? false;
                  });
                }
              },
              builder: (context, state) {
                if (state is LocationLoaded) {
                  return RefreshIndicator(
                    onRefresh: () {
                      context.read<LocationBloc>().add(GetLocation());
                      return Future.delayed(Duration(seconds: 1));
                    },
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification.metrics.pixels >=
                                scrollNotification.metrics.maxScrollExtent &&
                            !isLoadingMore) {
                          setState(() {
                            isLoadingMore = true;
                          });
                          if (!endPage) {
                            context.read<LocationBloc>().add(GetMoreLocation());
                          } else {
                            isLoadingMore = false;
                          }
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount:
                            state.locations.length + (isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == state.locations.length &&
                              isLoadingMore &&
                              !endPage) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final location = state.locations[index];
                          return LocationContainer(location: location);
                        },
                      ),
                    ),
                  );
                } else if (state is LocationError) {
                  return Center(
                    child: Text(
                      state.error,
                      style: TextStyle(fontSize: 16.sp, color: Colors.red),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class LocationContainer extends StatelessWidget {
  const LocationContainer({
    super.key,
    required this.location,
  });

  final ResultLocation location;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  LocationDetailScreen(resultLocation: location,),
          ),
        );
      },
      child: Padding(
        padding:  EdgeInsets.only(top: 24.h, left: 16.w,right: 16.w),
        child: Container(
          height: 218.h,
          width: 343.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Colors.grey[300],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/Rectangle 11location.png',
                height: 150.h,
                width: 343.w,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  location.name ?? 'Неизвестно',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  location.type ?? 'Неизвестный тип',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

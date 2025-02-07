import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc_character/bloc_location/location_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late final LocationBloc locationBloc;

  @override
  void initState() {
    locationBloc = LocationBloc();
    locationBloc.add(GetLocation());
    super.initState();
  }

  @override
  void dispose() {
    locationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Найти локацию',
            hintStyle: TextStyle(color: Colors.black54),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 64),
        child: BlocBuilder<LocationBloc, LocationState>(
          bloc: locationBloc,
          builder: (context, state) {
            if (state is LocationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LocationLoaded) {
              return ListView.builder(
                itemCount: state.locations.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Container(
                          height: 218.h,
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  state.locations[index].name!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  state.locations[index].type!,
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
                    ],
                  );
                },
              );
            } else if (state is LocationError) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
      ),
    );
  }
}

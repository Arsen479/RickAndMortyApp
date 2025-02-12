import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/screens/edit_profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //final ImagePicker _picker = ImagePicker();
  //XFile? _pictures;
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Настройки'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 33.h),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(50.r)),
                          child: imagePath != null
                              ? Image.file(
                                  File(imagePath!),
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Нет изображения'),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 49.h, left: 16.h),
                            child: Text(
                              'Oleg Belotserkovsky',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 16),
                            child: Text(
                              'Rick',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: SizedBox(
                    width: 335.w,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        foregroundColor:const Color(0xff22A2BD),
                        side: BorderSide(color:const Color(0XFF22A2BD),width: 1.w),
                      ),
                      onPressed: () async {
                        final selectedImage = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                        if (selectedImage != null && selectedImage is String) {
                          setState(() {
                            imagePath = selectedImage;
                          });
                        }
                      },
                      child: Text(
                        'Редактировать',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Color(0xffF2F2F2),
                ),
                SizedBox(height: 36.h),
                Text('ВНЕШНИЙ ВИД'),
                SizedBox(
                  height: 24.h,
                ),
                ListTile(
                  leading: Icon(Icons.dark_mode, size: 24.w),
                  title: Text(
                    'Темная тема',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  subtitle: Text('Включена',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.w),
                  onTap: () {},
                ),
                SizedBox(height: 72.h),
                Text(
                  'О ПРИЛОЖЕНИИ',
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концентрированной темной материи.',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 42.h),
                Text(
                  'ВЕРСИЯ ПРИЛОЖЕНИЯ',
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  'Rick & Morty  v1.0.0',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

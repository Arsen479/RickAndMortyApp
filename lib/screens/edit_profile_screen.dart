import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _pictures;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать профиль'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, _pictures!.path),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Center(
              child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(50.r)),
                    child: _pictures != null
                        ? Image.file(
                            File(_pictures!.path),
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Нет изображения'),
                            ),
                          ),
                  ),
                  SizedBox(height: 10.h),
                  TextButton(
                    onPressed: () async {
                      _pictures =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                    child: Text(
                      'Изменить фото',
                      style: TextStyle(color: Colors.blue, fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ПРОФИЛЬ',
                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              ),
            ),
            SizedBox(height: 10.h),
            ListTile(
              title: Text('Изменить ФИО', style: TextStyle(fontSize: 16.sp)),
              subtitle: Text('Oleg Belotserkovsky',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
              trailing: Icon(Icons.arrow_forward_ios, size: 16.w),
              onTap: () {},
            ),
            ListTile(
              title: Text('Логин', style: TextStyle(fontSize: 16.sp)),
              subtitle: Text('Rick',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
              trailing: Icon(Icons.arrow_forward_ios, size: 16.w),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

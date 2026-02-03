import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageuploadapi/core/network/dio_client.dart';
import 'package:imageuploadapi/feature/data/datasource/cloudinary_datasource.dart';
import 'package:imageuploadapi/feature/data/datasource/dio_source.dart';
import 'package:imageuploadapi/feature/data/datasource/picker_datasource.dart';
import 'package:imageuploadapi/feature/presentation/cubits/picker_cubit.dart';
import 'package:imageuploadapi/feature/presentation/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => PickerCubit(
                PickerDatasource(ImagePicker()),
                CloudinaryDatasource(
                  dioSource: DioSource(DioClient()),
                  cloudName: "",
                  uploadPreset: "img_upload",
                ),
              ),
        ),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
    );
  }
}

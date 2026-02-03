import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imageuploadapi/feature/presentation/cubits/picker_cubit.dart';
import 'package:imageuploadapi/feature/presentation/cubits/picker_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageCubit = context.read<PickerCubit>();
    return Scaffold(
      appBar: AppBar(
        // title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<PickerCubit, PickerState>(
              builder: (context, state) {
                if (state.imageStatus == ImageStatus.loading) {
                  return CircularProgressIndicator();
                }
                if (state.imageStatus == ImageStatus.success) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Image.file(state.image!, height: 200),
                          Positioned(
                            right: 4,
                            top: 4,
                            child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                imageCubit.clearImage();
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      if (state.uploadStatus == UploadStatus.uploading)
                        CircularProgressIndicator(),
                      if (state.image != null &&
                          state.uploadStatus != UploadStatus.uploaded)
                        ElevatedButton(
                          onPressed: () {
                            imageCubit.uploadImage();
                          },
                          child:
                              state.uploadStatus == UploadStatus.uploading
                                  ? Text("Uploading..")
                                  : Text("Upload"),
                        ),
                      SizedBox(height: 10),
                      if (state.uploadStatus == UploadStatus.uploaded &&
                          state.uploadUrl != null)
                        Image.network(height: 200, state.uploadUrl!),
                    ],
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          imageCubit.pickFromCamera();
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}

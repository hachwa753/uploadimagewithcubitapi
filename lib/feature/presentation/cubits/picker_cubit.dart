import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imageuploadapi/feature/data/datasource/cloudinary_datasource.dart';
import 'package:imageuploadapi/feature/data/datasource/picker_datasource.dart';
import 'package:imageuploadapi/feature/presentation/cubits/picker_state.dart';

class PickerCubit extends Cubit<PickerState> {
  final PickerDatasource pickerDatasource;
  final CloudinaryDatasource cloudinaryDatasource;
  PickerCubit(this.pickerDatasource, this.cloudinaryDatasource)
    : super(PickerState());

  Future<void> pickFromGallery() async {
    emit(state.copyWith(imageStatus: ImageStatus.loading));

    try {
      final file = await pickerDatasource.pickFromGallery();
      if (file == null) {
        emit(state.copyWith(imageStatus: ImageStatus.initial));
      } else {
        emit(state.copyWith(imageStatus: ImageStatus.success, image: file));
      }
    } catch (e) {
      emit(state.copyWith(imageStatus: ImageStatus.error, msz: "Pick failed"));
    }
  }

  Future<void> pickFromCamera() async {
    emit(state.copyWith(imageStatus: ImageStatus.loading, msz: null));
    try {
      final file = await pickerDatasource.pickFromCamera();
      if (file == null) {
        emit(state.copyWith(imageStatus: ImageStatus.initial));
      } else {
        emit(state.copyWith(imageStatus: ImageStatus.success, image: file));
      }
    } catch (e) {
      emit(state.copyWith(imageStatus: ImageStatus.error, msz: "failed"));
    }
  }

  Future<void> clearImage() async {
    emit(PickerState());
  }

  Future<void> uploadImage() async {
    if (state.image == null) return;
    emit(state.copyWith(uploadStatus: UploadStatus.uploading));
    try {
      final url = await cloudinaryDatasource.uploadImage(state.image!);
      emit(state.copyWith(uploadStatus: UploadStatus.uploaded, uploadUrl: url));
    } catch (e) {
      emit(
        state.copyWith(uploadStatus: UploadStatus.failed, msz: "Image failed"),
      );
    }
  }

  void clear() {
    emit(PickerState());
  }
}

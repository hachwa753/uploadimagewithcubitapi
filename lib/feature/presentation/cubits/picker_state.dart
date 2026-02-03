// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';

enum ImageStatus { initial, loading, success, error }

enum UploadStatus { idle, uploading, uploaded, failed }

class PickerState extends Equatable {
  final ImageStatus imageStatus;
  final File? image;
  final String? msz;
  final UploadStatus uploadStatus;
  final String? uploadUrl;
  const PickerState({
    this.imageStatus = ImageStatus.initial,
    this.image,
    this.msz,
    this.uploadStatus = UploadStatus.idle,
    this.uploadUrl,
  });
  @override
  List<Object?> get props => [imageStatus, image, msz, uploadStatus, uploadUrl];

  PickerState copyWith({
    ImageStatus? imageStatus,
    File? image,
    String? msz,
    UploadStatus? uploadStatus,
    String? uploadUrl,
  }) {
    return PickerState(
      imageStatus: imageStatus ?? this.imageStatus,
      image: image ?? this.image,
      msz: msz ?? this.msz,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      uploadUrl: uploadUrl ?? this.uploadUrl,
    );
  }
}

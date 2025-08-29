import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  ImagePickerHelper({required this.picker});

  final ImagePicker picker;

  Future<XFile?> imgFromGallery() async {
    return await picker.pickImage(
        maxHeight: 480,
        maxWidth: 640,
        source: ImageSource.gallery,
        imageQuality: 100);
  }
  // TODO cho phép chọn nhiều files và kiểu tài liệu gửi lên sv
  Future<PlatformFile?> fileGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      //allowMultiple: true, // cho phép chọn nhiều files
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      return file;
    }
    return null;
  }
}

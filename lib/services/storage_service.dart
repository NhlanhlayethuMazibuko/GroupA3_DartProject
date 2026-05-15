//STUDENT NUMBERS:
//220013730 KL MOHLOLO
//224073145 T PHAGE
//222034858 N SHABALALA
//223000608 AL HADEBE
//221034407 NS MOLOI

import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final SupabaseClient _supabase = Supabase.instance.client;
  static const String _bucket = 'application_files';

  static Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile == null) return null;

      return File(pickedFile.path);
    } catch (e) {
      return null;
    }
  }

  Future<String?> uploadFile(String applicationId, File file) async {
    try {
      final fileExt = file.path.split('.').last;
      final fileName =
          "$applicationId/${DateTime.now().millisecondsSinceEpoch}.$fileExt";

      await _supabase.storage.from(_bucket).upload(
            fileName,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      final url = _supabase.storage.from(_bucket).getPublicUrl(fileName);

      return url;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteFile(String fileUrl) async {
    try {
      final uri = Uri.parse(fileUrl);
      final filePath = uri.pathSegments.sublist(3).join('/');

      await _supabase.storage.from(_bucket).remove([filePath]);

      return true;
    } catch (e) {
      return false;
    }
  }
}

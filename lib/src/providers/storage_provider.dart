import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:formbloc/src/model/storage_result_model.dart';

class StorageProvider {
  Future<StorageResult> uploadImage(
      {@required File image, @required String title}) async {
    final imageFileName =
        title + DateTime.now().millisecondsSinceEpoch.toString();

    // Get the reference to the file we want to create (even if)
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

    final downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      final url = downloadUrl.toString();
      return StorageResult(imageUrl: url, imageFileName: imageFileName);
    }

    return null;
  }
}

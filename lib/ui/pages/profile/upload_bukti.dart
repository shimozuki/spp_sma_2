// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';

import '../../../utils/theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _image;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Bukti'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    // Image Upload Field
                    GestureDetector(
                      onTap: _getImage,
                      child: _image != null
                          ? Image.file(
                              _image!,
                              height: 520,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 520,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.grey[500],
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                      title: 'Upload Bukti',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/profile-edit-success', (route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
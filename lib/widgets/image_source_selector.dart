import 'package:d3tech/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSelector extends StatelessWidget {
  const ImageSourceSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 38.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 18.0, left: 18.0),
              child: Text('Choose Image Source'),
            ),
          ),
          Row(
            children: [
              ImageSourceTile(
                icon: Icons.camera,
                label: 'Camera',
                onTap: () => openImageSource(context, ImageSource.camera),
              ),
              ImageSourceTile(
                icon: Icons.photo,
                label: 'Gallery',
                onTap: () => openImageSource(context, ImageSource.gallery),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void openImageSource(BuildContext context, ImageSource imageSource) async {
    // close bottom sheet

    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: imageSource, maxHeight: 480, maxWidth: 640, imageQuality: 30).then((XFile? image) {
      CustomRouter.goBack(context, result: image);
    });
  }
}

class ImageSourceTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ImageSourceTile(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: 40,
              ),
            ),
            Text(label)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/image_bloc.dart';

class ImageUploadPreview extends StatefulWidget {
  @override
  _ImageUploadPreviewState createState() => _ImageUploadPreviewState();
}

class _ImageUploadPreviewState extends State<ImageUploadPreview> {
  ImageBloc _imageBloc = ImageBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(children: [
          SizedBox(
            height: 400,
            child: ListView(
              children: [
                StreamBuilder(
                    stream: _imageBloc.images,
                    builder: (context, snap) => Container())
              ],
            ),
          )
        ]);
      }),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/image_bloc.dart';
import 'package:prozone/src/ui/shared/style.dart';

class ImageUploadPreview extends StatefulWidget {
  @override
  _ImageUploadPreviewState createState() => _ImageUploadPreviewState();
}

class _ImageUploadPreviewState extends State<ImageUploadPreview> {
  ImageBloc _imageBloc = ImageBloc();
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> data = ModalRoute.of(context).settings.arguments;
    List<File> images = data['files'];
    var id = data['id'];
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: kBlue,
          ),
        ),
        title: Text(
          'Upload Preview',
          style: heading,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(10),
                child: Image.file(
                  File(images[index].path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          hasError(_imageBloc),
          SizedBox(
            height: 20,
          ),
          submitButton(_imageBloc, id, images),
          SizedBox(
            height: 20,
          ),
          loadingIndicator(_imageBloc),
          SizedBox(
            height: 20,
          ),
        ]);
      }),
    );
  }

  Widget submitButton(ImageBloc updateImageBloc, id, images) => Container(
        height: 45,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox.expand(
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () => updateImageBloc.submit(images, id, 'provider'),
            child: Text(
              'Update Provider Images',
              style: TextStyle(color: Colors.white),
            ),
            color: kBlue,
          ),
        ),
      );

  Widget loadingIndicator(ImageBloc updateImageBloc) => StreamBuilder<bool>(
        stream: updateImageBloc.loading,
        builder: (context, snap) {
          return Container(
            child: (snap.hasData && snap.data)
                ? Center(child: CircularProgressIndicator())
                : null,
          );
        },
      );

  Widget hasError(ImageBloc updateImageBloc) => StreamBuilder<String>(
        stream: updateImageBloc.hasError,
        builder: (context, snap) {
          return Container(
            child: (snap.hasError) ? Text(snap.error) : null,
          );
        },
      );
}

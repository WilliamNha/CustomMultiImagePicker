import 'package:custom_multi_image_picker/custom_multi_image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<File> _imageFileList = [];
  void initFile(List<File> image) {
    setState(() {
      image?.isEmpty == false ? _imageFileList = image : print("null");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flutter Demo Home Page'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomMultiImagePicker(
              buttonWidth: 100,
              buttonHeight: 50,
              labelName: 'Insert',
              getImageFile: (List<File> imageFile) {
                Future.delayed(Duration.zero, () async {
                  initFile(imageFile);
                });
              },
              isViewImage: true,
              isPreviewImage: false,
              isMultiImage: true,
              imageHeight: 100,
              imageWidth: 100,
              imageMarginBottom: 10,
              imageMarginTop: 15,
              imageMarginLeft: 5,
              imageMarginRight: 5,
              imageBorderRadiusTopRight: 15,
              imageBorderRadiusTopLeft: 15,
              imageBorderRadiusBottomLeft: 15,
              imageBorderRadiusBottomRight: 15,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'Showing return of image list from CustomImagePicker',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 20,
            ),
            _imageFileList.isNotEmpty
                ? Container(
                    height: 100,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageFileList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Image(
                              width: 100,
                              height: 100,
                              image: FileImage(
                                _imageFileList[index],
                              ),
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

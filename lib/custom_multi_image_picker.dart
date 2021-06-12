import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:photo_view/photo_view.dart';

class CustomMultiImagePicker extends StatefulWidget {
  final Function getImageFile;
  final double buttonWidth;
  final double buttonHeight;
  final Color buttonColor;
  final double buttonMarginTop;
  final String labelName;
  final double buttonMarginLeft;
  final double buttonMarginBottom;
  final double buttonMarginRight;
  final double buttonBlurRadius;
  final Color buttonShadowColor;
  final double buttonDxOffset;
  final double buttonDyOffset;

  //for image
  final int maxImageSize;
  final bool isViewImage;
  final bool isPreviewImage;
  final bool isMultiImage;
  final double imageHeight;
  final double imageWidth;
  final double imageMarginTop;
  final double imageMarginBottom;
  final double imageMarginLeft;
  final double imageMarginRight;
  final double imageBorderRadiusTopLeft;
  final double imageBorderRadiusTopRight;
  final double imageBorderRadiusBottomRight;
  final double imageBorderRadiusBottomLeft;
  final double imageBlurRadius;
  final Color imageShadowColor;
  final double imageDxOffset;
  final double imageDyOffset;

  CustomMultiImagePicker({
    this.buttonWidth = 100,
    this.buttonHeight = 50,
    this.buttonColor = Colors.white,
    this.labelName = "Insert",
    this.buttonMarginTop = 0.0,
    this.buttonMarginBottom = 0.0,
    this.buttonMarginLeft = 5.0,
    this.buttonMarginRight = 5.0,
    this.buttonBlurRadius = 6,
    this.buttonShadowColor = Colors.black26,
    this.buttonDxOffset = 0,
    this.buttonDyOffset = 2,
    this.getImageFile,

    //for image
    this.isViewImage = true,
    this.isPreviewImage = false,
    this.maxImageSize = 10,
    this.isMultiImage = true,
    this.imageHeight = 100,
    this.imageWidth = 100,
    this.imageMarginBottom = 0,
    this.imageMarginLeft = 5,
    this.imageMarginRight = 5,
    this.imageMarginTop = 0,
    this.imageBorderRadiusBottomLeft = 10,
    this.imageBorderRadiusTopLeft = 10,
    this.imageBorderRadiusBottomRight = 10,
    this.imageBorderRadiusTopRight = 10,
    this.imageBlurRadius = 6,
    this.imageDxOffset = 0,
    this.imageDyOffset = 2,
    this.imageShadowColor = Colors.black26,
  });
  @override
  _CustomMultiImagePickerState createState() => _CustomMultiImagePickerState();
}

class _CustomMultiImagePickerState extends State<CustomMultiImagePicker> {
  List<Asset> imagesAssetList = <Asset>[];
  List<File> imagesFileList = <File>[];
  String _error = 'No Error Dectected';
  int imageLeft;
  bool isHasImage = false;

  @override
  Widget build(BuildContext context) {
    return isHasImage == false || imagesFileList.isEmpty
        ? GestureDetector(
            onTap: () async {
              await multiImagesPicker().then((value) {
                widget.getImageFile(value);
              });
              // multiImagesPicker();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(
                  widget.buttonMarginLeft,
                  widget.buttonMarginTop,
                  widget.buttonMarginRight,
                  widget.buttonMarginBottom),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: widget.buttonBlurRadius,
                    color: widget.buttonShadowColor,
                    offset:
                        Offset(widget.buttonDxOffset, widget.buttonDyOffset),
                  ),
                ],
                color: widget.buttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              height: widget.buttonHeight,
              width: widget.buttonWidth,
              child: Center(child: Text(widget.labelName)),
            ),
          )
        : Container(
            margin: EdgeInsets.only(
              top: widget.imageMarginTop,
              bottom: widget.imageMarginBottom,
            ),
            height: widget.imageHeight.toDouble() + 3,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: imagesFileList.length,
              itemBuilder: (context, index) {
                File imageFile = imagesFileList[index];
                widget.getImageFile(imagesFileList);
                if (index < imagesFileList.length) {
                  return Row(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.isViewImage
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImageViewer(
                                                imageFile:
                                                    imagesFileList[index],
                                              )))
                                  // ignore: unnecessary_statements
                                  : null;
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: widget.imageMarginLeft,
                                right: widget.imageMarginRight,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      widget.imageBorderRadiusTopLeft),
                                  topRight: Radius.circular(
                                      widget.imageBorderRadiusTopRight),
                                  bottomLeft: Radius.circular(
                                      widget.imageBorderRadiusBottomLeft),
                                  bottomRight: Radius.circular(
                                      widget.imageBorderRadiusBottomRight),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: widget.imageBlurRadius,
                                    color: widget.imageShadowColor,
                                    offset: Offset(widget.imageDxOffset,
                                        widget.imageDyOffset),
                                  ),
                                ],
                              ),
                              width: widget.imageWidth.toDouble(),
                              height: widget.imageHeight.toDouble(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        widget.imageBorderRadiusTopLeft),
                                    topRight: Radius.circular(
                                        widget.imageBorderRadiusTopRight),
                                    bottomLeft: Radius.circular(
                                        widget.imageBorderRadiusBottomLeft),
                                    bottomRight: Radius.circular(
                                        widget.imageBorderRadiusBottomRight)),
                                child: Image(
                                  width: widget.imageWidth,
                                  height: widget.imageHeight,
                                  image: FileImage(imageFile),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  imagesFileList.removeAt(index);
                                  imagesAssetList.removeAt(index);
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: widget.imageWidth.toDouble() * 22 / 100,
                                height:
                                    widget.imageHeight.toDouble() * 22 / 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 6.0,
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "x",
                                  style: TextStyle(
                                    fontSize: widget.imageHeight.toDouble() *
                                        15 /
                                        100,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      imagesFileList.length == widget.maxImageSize
                          ? Container()
                          : index == imagesFileList.length - 1
                              ? GestureDetector(
                                  onTap: () {
                                    multiImagesPicker();
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: widget.imageBlurRadius,
                                            offset: Offset(0, 2),
                                            color: widget.imageShadowColor,
                                          ),
                                        ]),
                                    width: widget.imageWidth.toDouble(),
                                    height: widget.imageHeight.toDouble(),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                    ],
                  );
                }
                return Container();
              },
            ),
          );
  }

  Future<List<File>> multiImagesPicker() async {
    List<Asset> resultList = <Asset>[];

    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: widget.isMultiImage
            ? widget.maxImageSize != null
                ? widget.maxImageSize
                : 10
            : 1,
        enableCamera: true,
        selectedAssets: imagesAssetList,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#0d47a1",
          actionBarTitle: "Gallery",
          allViewTitle: "All Photos",
          useDetailsView: widget.isPreviewImage,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    setState(() {
      isHasImage = true;
      if (resultList.isNotEmpty) {
        imagesAssetList = resultList;
      }
      _error = error;
    });
    imagesFileList = await convertAssetListToFileList(imagesAssetList);
  }

  Future<List<File>> convertAssetListToFileList(List<Asset> assetList) async {
    List<File> imagesList = <File>[];
    assetList.forEach((imageAsset) async {
      final filePath =
          await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
      File tempFile = File(filePath);
      imagesList.add(tempFile);
    });

    return imagesList;
  }

// Future<File> convertAssetToFile(Asset asset) async {
//   final filePath =
//       await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
//   File tempFile = File(filePath);
//   return tempFile;
// }
}

class ImageViewer extends StatelessWidget {
  final File imageFile;
  final String imageUrl;
  ImageViewer({this.imageFile, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          imageFile != null
              ? PhotoView(
                  imageProvider: FileImage(imageFile),
                )
              : PhotoView(
                  imageProvider: NetworkImage(imageUrl),
                ),
          Positioned(
            top: 50.0,
            left: 10.0,
            child: Row(
              children: [
                IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7.0,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

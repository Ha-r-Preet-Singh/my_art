import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_art/ui_helper.dart';

class ProfilePicPage extends StatefulWidget {
  const ProfilePicPage({super.key});

  @override
  State<ProfilePicPage> createState() => _ProfilePicPageState();
}

class _ProfilePicPageState extends State<ProfilePicPage> {
  var storage = FirebaseStorage.instance.ref();
  late ListResult downloadRef;
  String imgUrl = "";
  List<String> arrImg = [];
  String imgPath = "";

  @override
  void initState() {
    super.initState();


    // getImgUrl();
  }

  // getImgUrl() async {
  //   // imgUrl = await downloadRef.getDownloadURL();
  //
  //   downloadRef =await storage.child("images/").listAll();
  //   for(Reference item in downloadRef.items){
  //     var imgUrl = await item.getDownloadURL();
  //     arrImg.add(imgUrl);
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    print(imgPath);
    return InkWell(
        onTap: (){

          showModalBottomSheet(
              context: context,
              builder: (context) {

                return InkWell(
                 onTap: (){
                   Navigator.pop(context);
                 },
                  child: Container(
                    height: 300,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                var imgPath = ImagePicker().pickImage(source: ImageSource.camera);
                              },
                                child: Icon(Icons.camera_alt_rounded,size: 82,color: Colors.pink,)),
                            wSpacer(mWidth:43.0),
                            InkWell(
                              onTap: ()async{
                                var imgXFile =await ImagePicker().pickImage(source: ImageSource.gallery);
                                if(imgXFile!=null){

                                   var croppedImgFile =await ImageCropper().cropImage(
                                       sourcePath: imgXFile.path,
                                     aspectRatioPresets: [
                                       CropAspectRatioPreset.square,
                                       CropAspectRatioPreset.ratio3x2,
                                       CropAspectRatioPreset.original,
                                       CropAspectRatioPreset.ratio4x3,
                                       CropAspectRatioPreset.ratio16x9
                                     ],
                                     uiSettings: [
                                       AndroidUiSettings(
                                           toolbarTitle: 'Cropper',
                                           toolbarColor: Colors.deepOrange,
                                           toolbarWidgetColor: Colors.white,
                                           initAspectRatio: CropAspectRatioPreset.original,
                                           lockAspectRatio: false),
                                       IOSUiSettings(
                                         title: 'Cropper',
                                       ),
                                       WebUiSettings(
                                         context: context,
                                       ),
                                     ],
                                   );


                                   if(croppedImgFile!=null){
                                     imgPath = croppedImgFile.path;
                                     setState(() {

                                     });
                                   }

                                }

                              },
                                child: Icon(Icons.photo,size: 82,color: Colors.pink,)),

                          ],
                        ),
                        hSpacer(),
                        ElevatedButton(
                            onPressed: (){
                              var timeMillis = DateTime.now().millisecondsSinceEpoch;
                              var uploadRef = storage.child("images/profile_pic/img_$timeMillis.jpg");


                              if(imgPath!=""){
                                //upload
                                uploadRef.putFile(File(imgPath)).then((p0) => print("File Uploaded"));
                              }
                            },
                            child: Text("Upload")),
                      ],
                    ),

                  ),
                );
              },);

        },
        child:imgPath!="" ? Container(
          margin: EdgeInsets.only(right: 11),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: FileImage(File(imgPath)),fit: BoxFit.cover,
            ),
          ),

        ):  Container(
          margin: EdgeInsets.only(right: 11),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            // color: Colors.red,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage("http://www.hotavatars.com/wp-content/uploads/2019/01/I80W1Q0.png"),fit: BoxFit.cover,
            ),
          ),

        ),

    );
  }
}

//
// body:arrImg.isNotEmpty ? ListView.builder(
// itemCount: arrImg.length,
//
// itemBuilder: (_, index) {
// var url = arrImg[index];
// return Image.network(url);
// },): Container(),


// imgUrl != "" ? Image.network(imgUrl) : Container()
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/controllers/coman_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';
import 'package:million/utils/styles.dart';
import 'package:million/view/widget/custom_snacbar.dart';
import 'package:million/view/widget/image_dialog.dart';
import 'package:million/view/widget/showCustomImagePicDialog.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  var authController = Get.find<AuthController>();
  var comanController = Get.find<ComanController>();
  String? tagText = '';

  @override
  void initState() {
    super.initState();
    _tagController = TextEditingController(text: tagText);
  }


  void clearImage() {
    setState(() {
      _file = null;
    });
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
  }

  ImagePicker _picker = ImagePicker();
  List<XFile?> image = [];



  Loading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        );
      },
    );
  }



  String? tags = '';

  void showAddTagDialog(JobDetailController jobDetailController, tagIndex) {
    if (tagIndex != -1) {
      setState(() =>
          _tagController.text = jobDetailController.addTagsList[tagIndex]!);
    } else {
      setState(() => _tagController.text = "");
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.all(30),
        backgroundColor: AppColors.blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(width: 2, color: AppColors.whiteColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(

                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Text(
                        'Write Tags',
                        textAlign: TextAlign.start,
                        style: poppinsMedium.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: Dimensions.fontSizeLarge,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  height: 1.5,
                  color: AppColors.whiteColor,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor.withOpacity(0.1),borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: TextField(
                      style: poppinsRegular.copyWith(
                          fontSize: 14, color: Theme.of(context).hintColor),
                      controller: _tagController,
                      decoration: InputDecoration(
                          hintText: "Write a tag...", border: InputBorder.none),
                      maxLines: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        if (_tagController.text == "") {
                          Get.back();
                          return;
                        }
                        if (tagIndex == -1) {
                          jobDetailController
                              .setAddTagList(_tagController.text);
                        } else {
                          jobDetailController.replaceValue(
                              _tagController.text, tagIndex);
                        }
                        Get.back();
                        _tagController.clear();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        width: Get.width * 0.3,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),color:  AppColors.primaryColor,
                            border: Border.all(
                                color: AppColors.primaryColor, width: 2)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        child: Text(
                          tagIndex == -1 ? "Add" : 'Update',
                          textAlign: TextAlign.center,
                          style: poppinsMedium.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: Dimensions.fontSizeLarge,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    tagIndex != -1
                        ? InkWell(
                            onTap: () {
                              print('call======================');
                              jobDetailController.removeTagsFromList(tagIndex);
                              Get.back();
                              _tagController.clear();
                            },
                            child: Container(
                              width: Get.width * 0.3,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color:  AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.primaryColor, width: 2)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Text(
                                'Remove',
                                textAlign: TextAlign.center,
                                style: poppinsMedium.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: Dimensions.fontSizeLarge,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailController>(builder: (jobDetailController) {
      return GetBuilder<AuthController>(builder: (authController) {

        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: clearImage,
            ),
            title: const Text(
              'Post to',
            ),
            centerTitle: false,
            actions: <Widget>[
              TextButton(
                onPressed: () => {
                  // Get.back()
                  // Loading(context),
                  if (authController.postType == "image")
                    {
                      if (authController.sigupdata["postImage"].length != 0)
                        {
                          comanController.addPostApi(
                              Get.key.currentContext!,
                              authController.sigupdata["postImage"] ?? "",
                              authController.sigupdata["_id"] ?? "",
                              _descriptionController.text,
                              jobDetailController.addTagsList.join(','),
                              'image',
                              1).then((value) => _descriptionController.clear()),
                        }
                      else
                        {
                          showCustomSnackBar(
                              "Add Post & Description.", context),
                        }
                    }
                  else if (authController.postType == 'video')
                    {
                      if (authController.sigupdata["postImage"].length != 0)
                        {


                          print('video uploaded success ..............'),
                          print( authController.sigupdata["postImage"]),
                          comanController.addPostApi(
                              Get.key.currentContext!,
                              authController.sigupdata["postImage"] ?? "",
                              authController.sigupdata["_id"] ?? "",
                              _descriptionController.text,
                              jobDetailController.addTagsList.join(','),
                              'video',
                              1).then((value) => _descriptionController.clear()),
                        }
                      else
                        {
                          showCustomSnackBar(
                              "Add Post & Description.", context),
                        }
                    }
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              )
            ],
          ),
          // POST FORM
          body: Column(
            children: <Widget>[
              isLoading
                  ? const LinearProgressIndicator()
                  : const Padding(padding: EdgeInsets.only(top: 0.0)),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // const CircleAvatar(
                  //   backgroundImage: NetworkImage(
                  //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ4o9-1rio7vO5KuxOJucMrotckyMcQt0qdFGd1Oiq3oKiiL6sSGI6e3YD5IyFYL6r16I&usqp=CAU",
                  //   ),
                  // ),
                  (authController.sigupdata[
                  'profilePic'] !=
                      null)
                      ?  Container(
                    margin:
                    const EdgeInsets
                        .symmetric(
                        horizontal:
                      0),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius
                          .circular(
                          70),
                      child: SizedBox(
                        width: MediaQuery.of(
                            context)
                            .size
                            .width /
                           8,
                        height: MediaQuery.of(
                            context)
                            .size
                            .width /
                           8,
                        child: ImageCard(
                          imagePath: AppConstants
                              .IMAGE_BASE_URL +
                              authController
                                  .sigupdata[
                              'profilePic'],
                        ),
                      ),
                    ),
                  )
                      : Image.asset(
                    Images.avtar,
                    width:
                    MediaQuery.of(context)
                        .size
                        .width /
                      8,
                    height:
                    MediaQuery.of(context)
                        .size
                        .width /
                        8,
                    color: Theme.of(context)
                        .disabledColor,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      style: poppinsRegular.copyWith(
                          fontSize: 14, color: Theme.of(context).hintColor),
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                          hintText: "Write a caption...",
                          border: InputBorder.none),
                      maxLines: 2,
                    ),
                  ),
                  (authController.sigupdata['postImage'] != null &&
                          authController.sigupdata['postImage'].length != 0)
                      ? Container(
                          height: 45.0,
                          width: 45.0,
                          child: ImageCard(
                            imagePath: AppConstants.IMAGE_BASE_URL +
                                authController.sigupdata['postImage'][0],
                          ),
                        )
                      : SizedBox(),
                  // (authController.sigupdata['postImage'] != null &&
                  //         authController.sigupdata['postImage'].length != 0)
                  //     ? Container(
                  //         height: 45.0,
                  //         width: 45.0,
                  //         child: ImageCard(
                  //           imagePath: AppConstants.IMAGE_BASE_URL +
                  //               authController.sigupdata['postImage'][0],
                  //         ),
                  //       )
                  //     : SizedBox(),
                ],
              ),
              (authController.sigupdata["postImage"] != null &&
                      authController.sigupdata["postImage"].length > 0)
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: Get.width * 0.9,
                      height: Get.height * 0.1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: authController.sigupdata["postImage"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Container(
                                width: Get.width * 0.18,
                                height: Get.height * 0.09,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: authController.sigupdata['postImage']
                                            [index] !=
                                        null

                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: ImageCard(
                                          imagePath: AppConstants
                                                  .IMAGE_BASE_URL +
                                              authController
                                                      .sigupdata['postImage']
                                                  [index],
                                        ),
                                      )
                                    : Image.asset(
                                        Images.account,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              Positioned(
                                right: 15,
                                top: 0,
                                child: InkWell(
                                  onTap: () {
                                    authController.removeImageFromMultiSelect(
                                        index, 'postImage');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.whiteColor),
                                    child: Icon(
                                      Icons.close,
                                      size: 18,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  : SizedBox(),
              InkWell(
                onTap: () {
                  showAddTagDialog(jobDetailController, -1);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2A21D),borderRadius: BorderRadius.circular(25)
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '+ Add Tags',
                          style: poppinsRegular.copyWith(
                              fontSize: 14, color: Theme.of(context).hintColor),
                        ),
                      ),
                      
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 15,
                        color: Theme.of(context).hintColor.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  child: Row(
                    children: List.generate(
                        growable: true,
                        jobDetailController.addTagsList.length, (index) {
                      return FocusDetector(
                        child: InkWell(
                          onTap: () {
                            print('index============ ${index}');
                            print(
                                'newIndex=====================${jobDetailController.tagIndex}');
                            showAddTagDialog(jobDetailController, index);

                            // jobDetailController.checkTagContain(
                            //     jobDetailController.addTagsList[index]);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              '${jobDetailController.addTagsList[index]}',
                              textAlign: TextAlign.start,
                              style: poppinsRegular.copyWith(
                                color: Theme.of(context).hintColor,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: const Color(0xFFE2A21D),
            foregroundColor: Colors.black,
            onPressed: () {

              if (authController.postType == 'image') {
                showBottomSheetImageTypePostDialog(
                    context, authController, 'image');
              } else if (authController.postType == 'video') {
                showBottomSheetVideoTypePostDialog(
                    context, authController, 'video');
              }
              // showAddPostDialog(context, authController, 'postImage');
              // Respond to button press
            },
            icon: Icon(
              Icons.add,
              color: Theme.of(context).hintColor,
            ),
            label: Text(
              'Add Post',
              style: poppinsRegular.copyWith(
                  fontSize: 14, color: Theme.of(context).hintColor),
            ),
          ),
        );
      });
    });
  }
}

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

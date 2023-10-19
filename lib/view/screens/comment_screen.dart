// import 'package:flutter/material.dart';
// import 'package:focus_detector/focus_detector.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:million/controllers/Job_detailsController.dart';
// import 'package:million/theme/app_colors.dart';
// import 'package:million/utils/app_constants.dart';
// import 'package:million/utils/dimensions.dart';
// import 'package:million/utils/images.dart';
// import 'package:million/utils/styles.dart';
//
// class CommentScreen extends StatefulWidget {
//   final String? postId;
//
//   const CommentScreen({Key? key, this.postId}) : super(key: key);
//
//   @override
//   State<CommentScreen> createState() => _CommentScreenState();
// }
//
// class _CommentScreenState extends State<CommentScreen> {
//   final myController = TextEditingController();
//   double loginWidth = 0.0;
//   var jobDetailController = Get.find<JobDetailController>();
//
//   Container chatTextField(BuildContext context ,dynamic postDetail) {
//
//     return Container(
//       height: 66,
//       padding: EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Theme.of(context).secondaryHeaderColor,
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 15,
//           ),
//           Container(
//             padding: EdgeInsets.only(left: 10),
//             width: MediaQuery.of(context).size.width - 35,
//             height: 45,
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//               borderRadius: BorderRadius.circular(50),
//               border: Border.all(
//                   width: 1, //                   <--- border width here
//                   color: Theme.of(context).cardColor.withOpacity(0.3)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: myController,
//                     style: poppinsRegular.copyWith(color: Colors.white),
//                     keyboardType: TextInputType.multiline,
//                     minLines: 2,
//                     maxLines: 4,
//                     decoration: const InputDecoration(
//                       hintText: 'Write a message...',
//                       border: InputBorder.none,
//                     ),
//                     onChanged: (text) {
//                       if (text != "") {
//                         this.setState(() {
//                           loginWidth = 80;
//                         });
//                       } else {
//                         this.setState(() {
//                           loginWidth = 0;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//
//                 // AnimatedOpacity(
//                 //   duration: Duration(seconds: 1),
//                 //   opacity: loginWidth > 0 ? 1 : 0,
//                 //   child: Row(
//                 //     children: [
//                 //       const SizedBox(
//                 //         width: 10,
//                 //       ),
//                 //       InkWell(
//                 //         onTap: () async {
//                 //
//                 //         },
//                 //         child: Icon(
//                 //           Icons.send,
//                 //           color: Theme.of(context).cardColor,
//                 //         ),
//                 //       ),
//                 //       const SizedBox(
//                 //         width: 10,
//                 //       ),
//                 //     ],
//                 //   ),
//                 // )
//                 InkWell(
//                   onTap: () async {
//
//                     await jobDetailController.addCommentToList(
//                         myController.text,
//                         jobDetailController.setCommentPostId.toString(),context);
//
//                    await jobDetailController.setPostID( jobDetailController.setCommentPostId.toString());
//                     myController
//                         .clear();
//                     // jobDetailController.refreshCommentList(postDetail);
//                     FocusScope.of(context).unfocus();
//                     // await jobDetailController.getCommentList(jobDetailController.setCommentPostId.toString());
//                   },
//                   child: jobDetailController.isLoading== true ? CircularProgressIndicator(color: AppColors.primaryColor,) : Icon(
//                     Icons.send,
//                     color: Theme.of(context).cardColor,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.blackColor,
//       body: StatefulBuilder(
//           builder: (BuildContext context, setState) {
//
//
//             return Column(
//             children: [
//               const SizedBox(
//                 height: 40,
//               ),
//               FocusDetector(
//                 onVisibilityGained: () async {},
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child: Container(
//                           width: MediaQuery.of(context).size.width / 9,
//                           height: MediaQuery.of(context).size.width / 9,
//                           padding: EdgeInsets.only(
//                             left: MediaQuery.of(context).size.width / 38,
//                           ),
//                           decoration: BoxDecoration(
//                               color: Theme.of(context).secondaryHeaderColor,
//                               borderRadius: BorderRadius.circular(
//                                   MediaQuery.of(context).size.width / 9),
//                               border: Border.all(
//                                   color: Theme.of(context)
//                                       .disabledColor
//                                       .withOpacity(0.1),
//                                   width: 1)),
//                           child: Center(
//                             child: Icon(
//                               Icons.arrow_back_ios,
//                               color:
//                                   Theme.of(context).disabledColor.withOpacity(0.5),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: Get.width * 0.15,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                         child: Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 15, vertical: 0),
//                           child: Text(
//                             "Comments",
//                             style: poppinsRegular.copyWith(
//                               color: Theme.of(context).hintColor.withOpacity(0.7),
//                               fontSize: Dimensions.fontSizeLarge,
//                             ),
//                             textAlign: TextAlign.start,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: Get.width * 0.15,
//                       ),
//                       IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.send_outlined,
//                           color: AppColors.whiteColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 7,
//                 child: jobDetailController.commentList.length > 0
//                     ? RefreshIndicator(
//                   onRefresh: ()async{
//                     await  jobDetailController.getCommentList(
//                         jobDetailController.setCommentPostId);
//                   },
//                       child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: ListView.builder(
//                             physics: BouncingScrollPhysics(),
//                             padding: EdgeInsets.symmetric(vertical: 8),
//                             shrinkWrap: true,
//                             itemCount: jobDetailController.commentList.length,
//                             itemBuilder: (context, index) {
//                               // String formattedDate = DateFormat('kk:mm').format(
//                               //     DateTime.parse(jobDetailController
//                               //         .commentList[index]['user']['createdAt']));
//                               return FocusDetector(
//                                 onFocusGained: () async{
//                                   await  jobDetailController.getCommentList(
//                                       jobDetailController.setCommentPostId);
//                                 },
//                                 child: Container(
//                                   margin: EdgeInsets.symmetric(vertical: 8),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         child: /*Image.asset(
//                                               Images.avtar,
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                                   10,
//                                               height: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                                   10,
//                                               color: Theme.of(context)
//                                                   .disabledColor,
//                                             )*/ /*jobDetailController.commentList[index]['profilePic'] != "" ?
//                                             Image.network(
//                                               AppConstants.IMAGE_BASE_URL +
//                                                   jobDetailController.commentList[index]['profilePic'].toString(),
//                                               width: 50,
//                                               height: 50, fit: BoxFit.fill,
//                                               // color: Theme.of(context).disabledColor,
//                                             ) : */
//                                         Image.asset(
//                                           Images.avtar,
//                                           width:
//                                           MediaQuery.of(context).size.width / 10,
//                                           height:
//                                           MediaQuery.of(context).size.width / 10,
//                                           color: Theme.of(context).disabledColor,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Column(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               Container(
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     Text(
//                                                       jobDetailController
//                                                           .commentList[index]
//                                                       ['user']['fullName']??"",
//                                                       style: const TextStyle(
//                                                           color: Colors.white),
//                                                     ),
//                                                     const SizedBox(
//                                                       width: 10,
//                                                     ),
//                                                     Text(
//                                                       DateFormat('kk:mm').format(
//                                                           DateTime.parse(jobDetailController
//                                                               .commentList[index]['user']['createdAt'])),
//                                                       style: TextStyle(
//                                                           color: Theme.of(context)
//                                                               .disabledColor,
//                                                           fontSize: Dimensions
//                                                               .fontSizeSmall,
//                                                           fontWeight:
//                                                           FontWeight.w600),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     jobDetailController
//                                                         .commentList[index]['text'],
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .subtitle2!
//                                                         .copyWith(
//                                                         fontWeight:
//                                                         FontWeight.w800,
//                                                         color:
//                                                         AppColors.whiteColor),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       Spacer(),
//                                       IconButton(
//                                         onPressed: () {},
//                                         icon: Icon(
//                                           Icons.favorite_border,
//                                           color: Theme.of(context).disabledColor,
//                                           size: 15,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                     )
//                     : const SizedBox(
//                         child: Center(
//                           child: Text('No Comments'),
//                         ),
//                       ),
//               ),
//             chatTextField(context ,jobDetailController.commentDetails)
//                 ,
//             ],
//           );
//         }
//       ),
//     );
//   }
// }

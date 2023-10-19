// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:get/get.dart';
// import 'package:million/controllers/Job_detailsController.dart';
// import 'package:million/helper/route_helper.dart';
// import 'package:million/theme/app_colors.dart';
// import 'package:million/utils/app_constants.dart';
// import 'package:million/utils/images.dart';
// import 'package:video_player/video_player.dart';
//
// // demo image url list
// List<String> _imageUrlList = [
//   'https://live.staticflickr.com/8370/8406368213_b44c3c5e53_c_d.jpg',
//   'https://live.staticflickr.com/8237/8406383473_d4552a1cb9_c_d.jpg',
//   'https://live.staticflickr.com/8323/8407506118_915f7fb1a1_c_d.jpg',
//   'https://live.staticflickr.com/8077/8406419819_9530514a87_c_d.jpg',
//   'https://live.staticflickr.com/8048/8406431731_6a3962958d_c_d.jpg',
//   'https://live.staticflickr.com/8329/8406514685_2473bd6e90_c_d.jpg',
//   'https://live.staticflickr.com/8226/8407445386_dd416a558b_c_d.jpg',
//   'https://live.staticflickr.com/8046/8407446162_2c8331fde8_c_d.jpg',
//   'https://live.staticflickr.com/8334/8407459084_c59da3d8e0_c_d.jpg',
// ];
//
// class VideoPost extends StatefulWidget {
//   VideoPost({required this.title});
//
//   final String title;
//
//
//
//   @override
//   _VideoPostState createState() => _VideoPostState();
// }
//
// class _VideoPostState extends State<VideoPost> {
//   final snackBar = SnackBar(content: Text('Image is tapped.'));
//
//   VideoPlayerController? _controller;
//   Future<void>? _initializeVideoPlayerFuture;
//   late OverlayEntry _popupDialog;
//   var jobDetailController = Get.find<JobDetailController>();
//
//
//
//   @override
//   void initState() {
//
//     // _controller =  VideoPlayerController.networkUrl(Uri.parse(
//     //     videoUrlList.toString()
//     // ));
//     _controller = VideoPlayerController.networkUrl(Uri.parse(
//         "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"
//         // AppConstants.IMAGE_BASE_URL +
//         //   jobDetailController.postListVideo[1]['postImage'][0]
//         ));
//     // _controller = VideoPlayerController.
//     //     networkUrl(Uri.parse(AppConstants.IMAGE_BASE_URL +
//     //     jobDetailController.postVideoUrl));
//     _initializeVideoPlayerFuture = _controller?.initialize();
//     _controller?.setLooping(true);
//     _controller?.setVolume(1.0);
//     jobDetailController.getPostListVideo();
//
//
//     // getVideoListFromAPI();
//
//     // TODO: implement initState
//     super.initState();
//   }
//
//   List videoUrlList = [];
//
//
//   getVideoListFromAPI() {
//
//
//     for (int i = 0; i <= jobDetailController.postListVideo.length; i++) {
//       videoUrlList.add(AppConstants.IMAGE_BASE_URL + jobDetailController.postListVideo[i]['postImage'][0]);
//
//       print('I is >>>>>>>  ${AppConstants.IMAGE_BASE_URL + jobDetailController.postListVideo[i]['postImage'][0]}');
//       print(
//           'length is >>>>>>>  ${jobDetailController.postListVideo.length - 1}');
//       break;
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(
//           height: 20,
//         ),
//         jobDetailController.postListVideo.isEmpty
//             ? SizedBox(
//                 child: Center(
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 30),
//                     child: Text(
//                       'No Post Video Added.!',
//                       style: TextStyle(color: AppColors.whiteColor),
//                     ),
//                   ),
//                 ),
//               )
//             : GridView.builder(
//                 // controller: _scrollController,
//                 shrinkWrap: true,
//                 padding: EdgeInsets.zero,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     mainAxisSpacing: 0,
//                     crossAxisSpacing: 0,
//                     childAspectRatio: 1),
//                 itemCount: jobDetailController.postListVideo.isEmpty
//                     ? 0
//                     : jobDetailController.postListVideo.length > 9
//                         ? 9
//                         : jobDetailController.postListVideo.length,
//
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   if (jobDetailController.isLoading == true) {
//                     return Center(
//                       child: Container(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                           color: AppColors.whiteColor,
//                           strokeWidth: 1,
//                         ),
//                       ),
//                     );
//                   } else {
//                     return (jobDetailController.postListVideo[index]
//                                     ['postImage'] !=
//                                 null &&
//                             (jobDetailController
//                                     .postListVideo[index]['postImage'].length !=
//                                 0))
//                         ? _createGridTileWidget(AppConstants.IMAGE_BASE_URL +
//                             jobDetailController.postListVideo[index]
//                                 ['postImage'][0])
//                         : Image.asset(
//                             Images.account,
//                             color: AppColors.primaryColor,
//                           );
//                   }
//                 },
//               ),
//         SizedBox(
//           height: Get.height * 0.02,
//         ),
//       ],
//     );
//   }
//
//   // create a tile widget from image url
//   Widget _createGridTileWidget(String url) => Builder(
//         // use Builder here in order to show the snakbar
//         builder: (context) => GestureDetector(
//           // keep the OverlayEntry instance, and insert it into Overlay
//           onLongPress: () {
//             // _popupDialog = _createPopupDialog(url);
//             // Overlay.of(context)?.insert(_popupDialog);
//           },
//
//           onTap: () {
//             Get.toNamed(RouteHelper.getVideoPOstRought());
//           },
//           // remove the OverlayEntry from Overlay, so it would be hidden
//           onLongPressEnd: (details) => _popupDialog?.remove(),
//           // onTap: () => Scaffold.of(context).showSnackBar(snackBar),
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//             child: Stack(
//               children: [
//                 // Image.network(AppConstants.IMAGE_BASE_URL +
//                 //     jobDetailController.postListVideo[0]['postImage'][0],fit: BoxFit.cover,),
//                 // VideoPlayer(_controller!),
//                 VideoPlayer(_controller!),
//                 Center(
//                   child: Icon(
//                     Icons.play_circle_outline_rounded,
//                     color: Theme.of(context).disabledColor,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//
//   OverlayEntry _createPopupDialog(String url) {
//     return OverlayEntry(
//       builder: (context) => AnimatedDialog(
//         child: _createPopupContent(url),
//       ),
//     );
//   }
//
//   Widget _createPopupContent(String url) => Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.0),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.network(url, fit: BoxFit.fitWidth),
//               _createActionBar(),
//             ],
//           ),
//         ),
//       );
//
//   Widget _createActionBar() => Container(
//         padding: EdgeInsets.symmetric(vertical: 10.0),
//         color: Theme.of(context).primaryColor,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Icon(
//               Icons.favorite_border,
//               color: Theme.of(context).cardColor,
//             ),
//             Icon(
//               Icons.chat_bubble_outline,
//               color: Theme.of(context).cardColor,
//             ),
//           ],
//         ),
//       );
// }
//
// // This a widget to implement the image scale animation, and background grey out effect.
// class AnimatedDialog extends StatefulWidget {
//   final Widget child;
//
//   const AnimatedDialog({required this.child});
//
//   @override
//   State<StatefulWidget> createState() => AnimatedDialogState();
// }
//
// class AnimatedDialogState extends State<AnimatedDialog>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<double> opacityAnimation;
//   late Animation<double> scaleAnimation;
//   var jobDetailController = Get.find<JobDetailController>();
//
//   @override
//   void initState() {
//     super.initState();
//
//     controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 400));
//     scaleAnimation =
//         CurvedAnimation(parent: controller, curve: Curves.easeOutExpo);
//     opacityAnimation = Tween<double>(begin: 0.0, end: 0.6).animate(
//         CurvedAnimation(parent: controller, curve: Curves.easeOutExpo));
//
//     controller.addListener(() => setState(() {}));
//     controller.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black.withOpacity(opacityAnimation.value),
//       child: Center(
//         child: FadeTransition(
//           opacity: scaleAnimation,
//           child: ScaleTransition(
//             scale: scaleAnimation,
//             child: widget.child,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/controllers/auth_controller.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/images.dart';
import 'package:million/view/screens/videopost/content_screen.dart';
import 'package:video_player/video_player.dart';

// demo image url list
List<String> _imageUrlList = [
  'https://live.staticflickr.com/8370/8406368213_b44c3c5e53_c_d.jpg',
  'https://live.staticflickr.com/8237/8406383473_d4552a1cb9_c_d.jpg',
  'https://live.staticflickr.com/8323/8407506118_915f7fb1a1_c_d.jpg',
  'https://live.staticflickr.com/8077/8406419819_9530514a87_c_d.jpg',
  'https://live.staticflickr.com/8048/8406431731_6a3962958d_c_d.jpg',
  'https://live.staticflickr.com/8329/8406514685_2473bd6e90_c_d.jpg',
  'https://live.staticflickr.com/8226/8407445386_dd416a558b_c_d.jpg',
  'https://live.staticflickr.com/8046/8407446162_2c8331fde8_c_d.jpg',
  'https://live.staticflickr.com/8334/8407459084_c59da3d8e0_c_d.jpg',
];

class VideoPost extends StatefulWidget {
  VideoPost({required this.title, this.isOtherUserVideoPostScreen});

  final String title;
  final bool? isOtherUserVideoPostScreen;

  @override
  _VideoPostState createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  final snackBar = SnackBar(content: Text('Image is tapped.'));

  late OverlayEntry _popupDialog;
  var jobDetailController = Get.find<JobDetailController>();
  var authController = Get.find<AuthController>();

  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    jobDetailController.getPostListVideo();
    super.initState();
    _controller = widget.isOtherUserVideoPostScreen == true
        ? VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
              // AppConstants.IMAGE_BASE_URL +
              //     jobDetailController.otherPostVideoList[0]['postImage'][0],
            ),
          )
        : VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
              // AppConstants.IMAGE_BASE_URL +
              //     jobDetailController.postListVideo[0]['postImage'][0],
            ),
          );

    _initializeVideoPlayerFuture = _controller?.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          widget.isOtherUserVideoPostScreen == true
              ? jobDetailController.otherPostVideoList.isEmpty
                  ? SizedBox(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.1,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Text(
                                'No Video Found!',
                                style: TextStyle(color: AppColors.whiteColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                      // controller: _scrollController,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              childAspectRatio: 1),

                      itemCount: jobDetailController.otherPostVideoList.length > 9
                          ? 9
                          : jobDetailController.otherPostVideoList.length,

                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        print(
                            '>>>>>>>>>>>>>>>>>>>CHECK<<<<<<<<<<<<<<${jobDetailController.otherPostVideoList.length}');
                        return (jobDetailController.otherPostVideoList[index]
                                        ['postImage'] !=
                                    null &&
                                (jobDetailController
                                        .otherPostVideoList[index]['postImage']
                                        .length !=
                                    0) &&
                                jobDetailController.otherPostVideoList[index]
                                        ['type'] ==
                                    'video')
                            ? FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  print(_controller);
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SizedBox();
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return InkWell(
                                      onTap: () {
                                        // Get.toNamed(
                                        //     RouteHelper.getVideoPOstRought());
                                        Get.toNamed(
                                            RouteHelper.getNewVideoPostScreen());
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3 -
                                                10,
                                            height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3 -
                                                10,
                                            child: VideoPlayer(_controller!),
                                          ),
                                          Center(
                                            child: Icon(
                                              Icons.play_circle_outline_rounded,
                                              color:
                                                  Theme.of(context).disabledColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              )
                            : jobDetailController.otherPostVideoList[index]
                                        ['type'] ==
                                    'image'
                                ? Container()
                                : SizedBox(
                                    child: Container(
                                      color: Colors.red,
                                    ),
                                  );
                      },
                    )
              : jobDetailController.postListVideo.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              childAspectRatio: 1),
                      itemCount: jobDetailController.postListVideo.isEmpty
                          ? 0
                          : jobDetailController.postListVideo.length > 9
                              ? 9
                              : jobDetailController.postListVideo.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (jobDetailController.isLoading == true) {
                          return Center(
                            child: Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.whiteColor,
                                strokeWidth: 1,
                              ),
                            ),
                          );
                        } else {
                          return (jobDetailController.postListVideo[index]
                                          ['postImage'] !=
                                      null &&
                                  (jobDetailController
                                          .postListVideo[index]['postImage']
                                          .length !=
                                      0) &&
                                  jobDetailController.postListVideo[index]
                                          ['type'] ==
                                      'video')
                              ?
                              /*_createGridTileWidget(
                AppConstants.IMAGE_BASE_URL +
                    jobDetailController.postListVideo[index]
                    ['postImage'][0])*/

                              FutureBuilder(
                                  future: _initializeVideoPlayerFuture,
                                  builder: (context, snapshot) {
                                    print('GETVIDEOPOST>>>>>>>>>>>>>>>>>>>>');
                                    print(_controller);
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return InkWell(
                                        onTap: () async {
                                          print('onvideo0------------');
                                          // await jobDetailController.getPostListVideo();
                                          // Get.toNamed(
                                          //     RouteHelper.getVideoPOstRought());
                                          Get.toNamed(RouteHelper
                                              .getNewVideoPostScreen());
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3 -
                                                  10,
                                              height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3 -
                                                  10,
                                              child: VideoPlayer(_controller!),
                                            ),
                                            Center(
                                              child: Icon(
                                                Icons.play_circle_outline_rounded,
                                                color: Theme.of(context)
                                                    .disabledColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                )
                              : Image.asset(
                                  Images.account,
                                  color: AppColors.primaryColor,
                                );
                        }
                      },
                    )
                  : SizedBox(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.1,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Text(
                                'No Video Found!',
                                style: TextStyle(color: AppColors.whiteColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
        ],
      ),
    );
  }

  // create a tile widget from image url
  Widget _createGridTileWidget(String url) => Builder(
        // use Builder here in order to show the snakbar
        builder: (context) => GestureDetector(
          // keep the OverlayEntry instance, and insert it into Overlay
          onLongPress: () {
            // _popupDialog = _createPopupDialog(url);
            // Overlay.of(context)?.insert(_popupDialog);
          },
          onTap: () {
            Get.toNamed(RouteHelper.getNewVideoPostScreen());
            // Get.toNamed(RouteHelper.getVideoPOstRought());
          },
          // remove the OverlayEntry from Overlay, so it would be hidden
          onLongPressEnd: (details) => _popupDialog.remove(),
          // onTap: () => Scaffold.of(context).showSnackBar(snackBar),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Stack(
              children: [
                Image.network(url.toString(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                            child: Text(
                          error.toString(),
                          style: TextStyle(color: AppColors.whiteColor),
                        )),
                    width: MediaQuery.of(context).size.width / 3 - 10,
                    height: MediaQuery.of(context).size.width / 3 - 10),
                Center(
                  child: Icon(
                    Icons.play_circle_outline_rounded,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  OverlayEntry _createPopupDialog(String url) {
    return OverlayEntry(
      builder: (context) => AnimatedDialog(
        child: _createPopupContent(url),
      ),
    );
  }

  Widget _createPopupContent(String url) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(url, fit: BoxFit.fitWidth),
              _createActionBar(),
            ],
          ),
        ),
      );

  Widget _createActionBar() => Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.favorite_border,
              color: Theme.of(context).cardColor,
            ),
            Icon(
              Icons.chat_bubble_outline,
              color: Theme.of(context).cardColor,
            ),
          ],
        ),
      );
}

// This a widget to implement the image scale animation, and background grey out effect.
class AnimatedDialog extends StatefulWidget {
  final Widget child;

  const AnimatedDialog({required this.child});

  @override
  State<StatefulWidget> createState() => AnimatedDialogState();
}

class AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutExpo);
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.6).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutExpo));

    controller.addListener(() => setState(() {}));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(opacityAnimation.value),
      child: Center(
        child: FadeTransition(
          opacity: scaleAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

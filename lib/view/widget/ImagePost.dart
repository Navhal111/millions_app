import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/helper/route_helper.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/images.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title, this.isOtherUserImagePostScreen = false});
  final String title;
  final bool? isOtherUserImagePostScreen;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final snackBar = const SnackBar(content: Text('Image is tapped.'));

  late OverlayEntry _popupDialog;
  var jobDetailController = Get.find<JobDetailController>();

  @override
  void initState() {
    jobDetailController.getPostList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailController>(
      builder: (jobDetailController) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              widget.isOtherUserImagePostScreen == true
                  ? jobDetailController.otherPostList.isEmpty
                      ? SizedBox(
                          child: Center(
                            child: Column(
                              children: [

                                SizedBox(height: Get.height * 0.1,),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 30),
                                  child: Text(
                                    'No Post Found.!',
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
                          itemCount: jobDetailController.otherPostList.length,

                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return (jobDetailController.otherPostList[index]
                                            ['postImage'] !=
                                        null &&
                                    (jobDetailController
                                            .otherPostList[index]['postImage']
                                            .length !=
                                        0) && jobDetailController
                                .otherPostList[index]['type'] == 'image')
                                ? _otherCreateGridTileWidget(
                                    AppConstants.IMAGE_BASE_URL +
                                        jobDetailController.otherPostList[index]
                                            ['postImage'][0])
                                : SizedBox();
                          },
                        )
                  : jobDetailController.postList.isEmpty
                      ? SizedBox(
                child: Center(
                  child: Column(
                    children: [

                      SizedBox(height: Get.height * 0.1,),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          'No Post Found.!',
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
                          itemCount: jobDetailController.postList.isEmpty
                              ? 0
                              : jobDetailController.postList.length>9?9:jobDetailController.postList.length,

                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (jobDetailController.isLoading == true)
                            {
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
                            }
                            else {
                              return (jobDetailController.postList[index]
                                              ['postImage'] !=
                                          null &&
                                      (jobDetailController
                                              .postList[index]['postImage']
                                              .length !=
                                          0))
                                  ? _createGridTileWidget(
                                      AppConstants.IMAGE_BASE_URL +
                                          jobDetailController.postList[index]
                                              ['postImage'][0])
                                  : Image.asset(
                                      Images.account,
                                      color: AppColors.primaryColor,
                                    );
                            }
                          },
                        ),
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _otherCreateGridTileWidget(String url) => Builder(
    // use Builder here in order to show the snakbar
    builder: (context) => GestureDetector(
      // keep the OverlayEntry instance, and insert it into Overlay
      onLongPress: () {
        _popupDialog = _createPopupDialog(url);
        Overlay.of(context).insert(_popupDialog);
      },
      onTap: () {


        print(url);
        Get.toNamed(RouteHelper.getOtherPostImage(url));
      },
      // remove the OverlayEntry from Overlay, so it would be hidden
      onLongPressEnd: (details) => _popupDialog.remove(),
      // onTap: () => Scaffold.of(context).showSnackBar(snackBar),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Image.network(url,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width / 3 - 10,
            height: MediaQuery.of(context).size.width / 3 - 10),
      ),
    ),
  );

  // create a tile widget from image url
  Widget _createGridTileWidget(String url) => Builder(
        // use Builder here in order to show the snakbar
        builder: (context) => GestureDetector(
          // keep the OverlayEntry instance, and insert it into Overlay
          onLongPress: () {

            _popupDialog = _createPopupDialog(url);
            Overlay.of(context).insert(_popupDialog);
          },
          onTap: () {
            Get.toNamed(RouteHelper.getPostImageRought(url));
          },
          // remove the OverlayEntry from Overlay, so it would be hidden
          onLongPressEnd: (details) => _popupDialog.remove(),
          // onTap: () => Scaffold.of(context).showSnackBar(snackBar),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Image.network(url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 3 - 10,
                height: MediaQuery.of(context).size.width / 3 - 10),
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
            Row(
              children: [
                Icon(
                  Icons.favorite_border,
                  color: Theme.of(context).cardColor,
                ),
                Text(
                  "12",
                  style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                )
              ],
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

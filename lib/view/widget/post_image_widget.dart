import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostImageWidget extends StatefulWidget {
  final dynamic index;
  const PostImageWidget({Key? key, this.index}) : super(key: key);

  @override
  State<PostImageWidget> createState() => _PostImageWidgetState();
}

class _PostImageWidgetState extends State<PostImageWidget> {
  final pageController = PageController(viewportFraction: 1.0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailController>(
      builder: (jobDetailController) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  padEnds: false,
                  itemCount: jobDetailController
                      .postList[widget.index]['postImage'].length,
                  pageSnapping: true,
                  itemBuilder: (context, pagePosition) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.861,
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      child: Image.network(
                        AppConstants.IMAGE_BASE_URL +
                            jobDetailController.postList[widget.index]
                                ['postImage'][pagePosition],
                      ),
                    );
                  },
                  controller: pageController,
                  onPageChanged: (page) {}),
            ),
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                    controller: pageController, // PageController
                    count: jobDetailController
                                .postList[widget.index]["postImage"].length >
                            1
                        ? jobDetailController
                            .postList[widget.index]["postImage"].length
                        : 1,
                    effect: WormEffect(
                        activeDotColor: AppColors.whiteColor,
                        dotColor: AppColors.blackColor.withOpacity(0.8),
                        dotHeight: 8,
                        dotWidth: 8), // your preferred effect
                    onDotClicked: (index) {
                      jobDetailController.postList[index]["postImage"][index] =
                          index;
                    }),
              ),
            ),
          ],
        );
      },
    );
  }
}

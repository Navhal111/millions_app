import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OtherPostImageWidget extends StatefulWidget {
  final dynamic index;
  const OtherPostImageWidget({Key? key, this.index}) : super(key: key);

  @override
  State<OtherPostImageWidget> createState() => _OtherPostImageWidgetState();
}

class _OtherPostImageWidgetState extends State<OtherPostImageWidget> {
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
                      .otherPostList[widget.index]['postImage'].length,
                  pageSnapping: true,
                  itemBuilder: (context, pagePosition) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.861,
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      child: Image.network(
                        AppConstants.IMAGE_BASE_URL +
                            jobDetailController.otherPostList[widget.index]
                            ['postImage'][pagePosition],
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox();
                        },
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
                        .otherPostList[widget.index]["postImage"].length >
                        1
                        ? jobDetailController
                        .otherPostList[widget.index]["postImage"].length
                        : 1,
                    effect: WormEffect(
                        activeDotColor: AppColors.whiteColor,
                        dotColor: AppColors.blackColor.withOpacity(0.8),
                        dotHeight: 8,
                        dotWidth: 8), // your preferred effect
                    onDotClicked: (index) {
                      jobDetailController.otherPostList[index]["postImage"][index] =
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

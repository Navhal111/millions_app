import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/controllers/Job_detailsController.dart';
import 'package:million/theme/app_colors.dart';
import 'package:million/utils/app_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ApplyImageWidget extends StatefulWidget {
  final List? applyImg;

  const ApplyImageWidget({super.key, this.applyImg});

  @override
  State<ApplyImageWidget> createState() => _ApplyImageWidgetState();
}

class _ApplyImageWidgetState extends State<ApplyImageWidget> {
  final pageController = PageController(viewportFraction: 1.0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailController>(builder: (jobDetailController) {
      return widget.applyImg == null
          ? SizedBox()
          : Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  height: Get.height * 0.4,
                  child: PageView.builder(
                      physics: const ClampingScrollPhysics(),
                      padEnds: false,
                      scrollDirection: Axis.horizontal,
                      allowImplicitScrolling: false,
                      itemCount: widget.applyImg?.length,
                      pageSnapping: true,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Container(
                            width: Get.width * 0.5,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                AppConstants.IMAGE_BASE_URL +
                                    widget.applyImg![index],
                              ),
                            ),
                          ),
                        );
                      },
                      controller: pageController,
                      onPageChanged: (page) {
                        setState(() {});
                      }),
                ),
                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: pageController, // PageController
                      count: widget.applyImg!.length,
                      effect: WormEffect(
                          activeDotColor: AppColors.whiteColor,
                          dotColor: Theme.of(context).disabledColor,
                          dotHeight: 8,
                          dotWidth: 8), // your preferred effect
                      onDotClicked: (index) {
                        // productController.bannerList[0]["image"] =
                        //     index;
                      },
                    ),
                  ) /*: SizedBox()*/,
                ),
              ],
            );
    });
  }
}

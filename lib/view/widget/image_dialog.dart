import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/utils/images.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

class ImageDialog extends StatelessWidget {
  final String link;

  const ImageDialog({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.3),
      padding: const EdgeInsets.all(8.0),
      child: PinchZoomReleaseUnzoomWidget(
        resetDuration: const Duration(milliseconds: 200),
        boundaryMargin: const EdgeInsets.only(bottom: 0),
        clipBehavior: Clip.none,
        useOverlay: true,
        maxOverlayOpacity: 0.5,
        overlayColor: Colors.black,
        fingersRequiredToPinch: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(

            link,
            fit: BoxFit.contain,
            errorBuilder: (context, url, error) => Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Image.asset(Images.account)),
          ),
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String? imagePath;

  const ImageCard({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return ImageDialog(
                link: imagePath!,
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -1.0,
              blurRadius: 12.0,
            ),
          ],
        ),
        width: Get.width * 0.43,
        height: Get.height * 0.15,
        child: Image.network(
          imagePath!,
          width: 400,
          height: 100,
          fit: BoxFit.fill,
          errorBuilder: (context, url, error) => new Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Image.asset(Images.account)),
        ),
      ),
    );
  }
}

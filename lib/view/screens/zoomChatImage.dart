import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:million/utils/images.dart';
import 'package:million/view/widget/image_dialog.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

class ZoomImage extends StatelessWidget {
  final String? img;
  final String? userName;

  const ZoomImage({Key? key, this.img, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Transform.scale(
              scale: 1.0,
              child: /*CachedNetworkImage(
                imageUrl: img!,
                fit: BoxFit.fill,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )*/Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.symmetric(vertical: Get.height * 0),
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
                      img!,
                      width: 400,
                      // height: 100,
                      fit: BoxFit.fill,
                      errorBuilder: (context, url, error) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Image.asset(Images.account)),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                  height: 75,
                  width: Get.width,
                  color: Colors.black26,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    // title: Text('$userName'),
                  ),),
            ),
          ],
        ),
      ),
    );
  }
}
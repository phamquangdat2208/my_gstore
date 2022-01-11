import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

import 'custom_image_network.dart';

class SlideImage extends StatefulWidget {
  final List<String>? urls;
  final double borderRadius;
  final double? height;
  final Widget? displayNumberImage;
  final bool autoPlay;
  final bool revert;
  final Duration? duration;
  final bool enableInfiniteScroll;
  final Function(int? index)? onchangePage;
  final BoxFit? fit;

  const SlideImage(
      {Key? key,
      this.urls,
      this.borderRadius = 0,
      this.height,
      this.displayNumberImage,
      this.autoPlay = false,
      this.revert = false,
      this.duration,
      this.enableInfiniteScroll = false,
      this.onchangePage,
      this.fit})
      : super(key: key);

  @override
  _SlideImageState createState() => _SlideImageState();
}

class _SlideImageState extends State<SlideImage> {
  int _currentSlideIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.urls?.isEmpty ?? true) {
      return const SizedBox();
    }
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: widget.height ?? 248.0.h,
          child: CarouselSlider(
            options: CarouselOptions(
              initialPage: 0,
              height: double.infinity,
              autoPlay: widget.autoPlay,
              autoPlayAnimationDuration:
                  widget.duration ?? Duration(seconds: 3),
              viewportFraction: 1.0,
              reverse: widget.revert,
              enableInfiniteScroll: widget.enableInfiniteScroll,
              onPageChanged: (index, reason) {
                if (widget.onchangePage != null) {
                  widget.onchangePage!(index);
                }
                setState(() {
                  _currentSlideIndex = index;
                });
              },
            ),
            items: widget.urls!
                .map((String value) => Container(
                      color: Colors.transparent,
                      child: CustomImageNetwork(
                        url: value,
                        width: double.infinity,
                        height: double.infinity,
                        fit: widget.fit,
                        border: widget.borderRadius,
                      ),
                    ))
                .toList(),
          ),
        ),
        widget.displayNumberImage ??
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Row(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(widget.urls ?? [], (index, obj) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 4.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentSlideIndex == index
                              ? AppColors.grey3
                              : AppColors.grey7,
                        ),
                      );
                    }),
                  ),
                  Spacer(),
                ],
              ),
            )
      ],
    );
  }

// Widget _iconNav(
//   IconData iconData,
// ) =>
//     DecoratedBox(decoration: Icon(iconData));
}

part of 'package:dio_client/dio_client.dart';

class CommonMethod {
  static showErrorMessage(
    BuildContext context,
    String message,
  ) {
    if (message.isNotEmpty) {
      closeKeyboard(context);
      showCustomFlashMessage(
        context: context,
        title: "",
        message: message,
        duration: const Duration(seconds: 3),
        imageUrl: "assets/images/widget_images/sad.png",
        backgroundColor: const Color(0xFF7E3FF2),
      );
    }
    return Container();
  }

  static showSuccessMessage(
    BuildContext context,
    String message,
  ) {
    if (message.isNotEmpty) {
      closeKeyboard(context);
      showCustomFlashMessage(
        context: context,
        title: "",
        message: message,
        duration: const Duration(seconds: 3),
        imageUrl: "assets/images/widget_images/smiley.png",
        backgroundColor: const Color(0xFF83EAF4),
        forwardAnimationCurve: Curves.easeOut,
      );
    }

    return Container();
  }

  static closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static ImageProvider provideImageDecorator({
    String? imageUrl,
    ImageProvider? defaultImage,
    String? appLogoImageAddress,
  }) {
    if (imageUrl != null) {
      if (imageUrl.contains("https://")) {
        return CachedNetworkImageProvider(
          imageUrl,
        );
      } else if (imageUrl.contains("assets/images")) {
        return AssetImage(imageUrl);
      } else if (imageUrl.contains(".mp4")) {
        return AssetImage(
            appLogoImageAddress ?? "assets/images/launcher/icon.png");
      } else if (imageUrl.contains("com.promilo.app/cache")) {
        return FileImage(File.fromUri(Uri.parse(imageUrl)));
      } else if (Platform.isIOS) {
        try {
          return FileImage(File.fromUri(Uri.parse(imageUrl)));
        } catch (_) {
          if (defaultImage != null) {
            return defaultImage;
          }
          return AssetImage(
              appLogoImageAddress ?? "assets/images/launcher/icon.png");
        }
      }
    }
    if (defaultImage != null) {
      return defaultImage;
    }
    return AssetImage(appLogoImageAddress ?? "assets/images/launcher/icon.png");
  }

  static showCustomFlashMessage({
    BuildContext? context,
    String title = "Title",
    String message = "Provide message",
    String imageUrl = "assets/images/application/launcher/icon.png",
    Color backgroundColor = const Color(0xFFFF3333),
    Curve forwardAnimationCurve = Curves.elasticInOut,
    Duration? duration,
    FlashPosition position = FlashPosition.bottom,
  }) {
    final _size = SizeMixin.setConstSize(context!);
    showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          dismissDirections: const [
            FlashDismissDirection.endToStart,
            FlashDismissDirection.startToEnd,
          ],
          forwardAnimationCurve: forwardAnimationCurve,
          position: position,
          child: FlashBar(
            icon: imageUrl.isNotEmpty
                ? Container(
                    width: _size.width * 0.08,
                    height: _size.width * 0.08,
                    margin: EdgeInsets.only(
                      left: _size.width * 0.1,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: provideImageDecorator(
                          imageUrl: imageUrl,
                        ),
                      ),
                    ),
                  )
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            controller: controller,
            backgroundColor: backgroundColor,
            margin: EdgeInsets.only(
              bottom: _size.height * 0.02,
              left: _size.width * 0.025,
              right: _size.width * 0.025,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: _size.width * 0.035,
              vertical: _size.height * 0.01,
            ),
            behavior: FlashBehavior.floating,
            content: Container(
              width: _size.width * 0.55,
              margin: EdgeInsets.only(
                left: _size.width * 0.05,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: _size.width * 0.55,
                    child: CustomText(
                      text: message.isNotEmpty ? message : "",
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: const Color(0xffFFFFFF),
                      fontFamily: "medium",
                      maxLines: 4,
                      textOverflow: TextOverflow.ellipsis,
                      // textSpanList: [
                      //   if (message.isNotEmpty)
                      //     TextSpan(
                      //       text: "$message",
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 10.0,
                      //         color: const Color(0xffFFFFFF),
                      //         fontFamily: "regular",
                      //       ),
                      //     ),
                      // ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.dismiss();
                    },
                    visualDensity: VisualDensity.compact,
                    color: Colors.white,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

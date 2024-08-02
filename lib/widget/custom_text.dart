part of 'package:dio_client/dio_client.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final Color decorationColor;
  final List<TextSpan> textSpanList;
  final double letterSpacing;
  final TextOverflow textOverflow;
  final BuildContext? context;
  final List<Shadow>? shadows;
  final int? maxLines;
  final double? height;
  final Color? backgroundColor;
  final double? maxHeight;

  final bool softWrap;
  const CustomText({
    Key? key,
    required this.text,
    this.color = Colors.white,
    this.fontSize = 16,
    this.fontFamily = 'regular',
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.textSpanList = const [],
    this.textDecoration = TextDecoration.none,
    this.letterSpacing = 0,
    this.textOverflow = TextOverflow.visible,
    this.context,
    this.maxLines,
    this.height,
    this.softWrap = true,
    this.decorationColor = Colors.transparent,
    this.shadows,
    this.backgroundColor,
    this.maxHeight,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      overflow: textOverflow,
      softWrap: softWrap,
      maxLines: maxLines,
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: MediaQuery.textScalerOf(context).scale(fontSize),
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          decoration: textDecoration,
          decorationColor: decorationColor,
          letterSpacing: letterSpacing,
          height: height,
          shadows: shadows,
          backgroundColor: backgroundColor,
        ),
        children: textSpanList,
      ),
    );
  }
}

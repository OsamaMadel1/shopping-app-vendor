import 'package:app_vendor/core/presentation/widgets/wid/colors.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  const TextWidget({super.key, required this.text, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.i18n,
      style: TextStyle(color: AppColor.kPrimaryColor, fontSize: fontSize),
    );
  }
}

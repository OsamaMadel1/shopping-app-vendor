import 'package:app_vendor/core/presentation/widgets/reactive_password_input_widget.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_phone_widget.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContactInfoStep extends StatelessWidget {
  const ContactInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'contact information'.i18n,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              // color: AppColor.kPrimaryColor,
            ),
          ),
        ),
        const Gap(15),
        ReactiveTextInputWidget(
          hint: "Email".i18n,
          controllerName: "email",
          prefixIcon: Icons.email_outlined,
        ),
        const Gap(15),
        ReactivePasswordInputWidget(
          hint: "Password".i18n,
          controllerName: "password",
          showEye: true,
        ),
        const Gap(15),
        ReactivePasswordInputWidget(
          hint: "Confirm Password".i18n,
          controllerName: "confirmPassword",
          showEye: true,
        ),
        const Gap(15),
        const ReactivePhoneWidget(
          controllerName: "phone",
          suffixIcon: Icons.phone,
        ),
        Gap(10),
      ],
    );
  }
}

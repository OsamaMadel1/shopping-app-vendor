import 'package:app_vendor/authentication/domain/value_objects/gender_entity.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_dropdown_gender_widget.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/core/presentation/widgets/text_widget.dart';
import 'package:app_vendor/core/presentation/widgets/wid/colors.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PersonalInfoStep extends StatelessWidget {
  const PersonalInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Personal Information'.i18n,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColor.kPrimaryColor,
            ),
          ),
        ),
        const Gap(20),
        ReactiveTextInputWidget(
          hint: "First Name".i18n,
          controllerName: "firstName",
          prefixIcon: Icons.person,
        ),
        const Gap(20),
        ReactiveTextInputWidget(
          hint: "Last Name".i18n,
          controllerName: "lastName",
          prefixIcon: Icons.person,
        ),
        const Gap(20),
        ReactiveDropdownGenderWidget<GenderEntity>(
          controllerName: 'gender',
          hintText: 'select gender'.i18n,
          // prefixIcon: Icons.person_outline,
          items: GenderEntity.values,
          itemBuilder: (gender) => Row(
            children: [
              Icon(
                gender == GenderEntity.male ? Icons.male : Icons.female,
                color: AppColor.kPrimaryColor,
              ),
              const SizedBox(width: 8),
              TextWidget(
                text: gender == GenderEntity.male ? 'male'.i18n : 'Female'.i18n,
              ),
            ],
          ),
          validationMessages: {'required': (error) => 'يجب اختيار الجنس'},
        ),
        Gap(5),
      ],
    );
  }
}

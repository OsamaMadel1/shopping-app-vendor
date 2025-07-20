import 'package:app_vendor/core/presentation/widgets/reactive_checkbox_list_tile_apartment.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/core/presentation/widgets/wid/colors.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddressInfoStep extends StatelessWidget {
  const AddressInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'address information'.i18n,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColor.kPrimaryColor,
            ),
          ),
        ),
        ReactiveTextInputWidget(
          hint: "City".i18n,
          controllerName: "city",
          prefixIcon: Icons.location_city,
        ),
        const Gap(20),
        ReactiveTextInputWidget(
          hint: "Street".i18n,
          controllerName: "street",
          prefixIcon: Icons.streetview,
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ReactiveTextInputWidget(
                hint: "Floor".i18n,
                controllerName: "floor",
                prefixIcon: Icons.apartment,
              ),
            ),
            Expanded(
              child: ReactiveTextInputWidget(
                hint: "Apartment".i18n,
                controllerName: "apartment",
                prefixIcon: Icons.home,
              ),
            ),
          ],
        ),

        // const Gap(20),
        // const ReactiveCheckboxApartment(
        //   controlName: "hasApartment",
        //   label: "Have Apartment?",
        // ),
      ],
    );
  }
}

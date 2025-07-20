//application/presentation/screens/signup_screen
import 'package:app_vendor/authentication/application/auth_state.dart';
import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/authentication/application/providers/signup_form_provider.dart';
import 'package:app_vendor/authentication/domain/entities/user_register_entity.dart';
import 'package:app_vendor/authentication/domain/value_objects/address_entity.dart';
import 'package:app_vendor/authentication/presentation/screens/singup_screen/address_info_step.dart';
import 'package:app_vendor/authentication/presentation/screens/singup_screen/contact_info_step.dart';
import 'package:app_vendor/authentication/presentation/screens/singup_screen/personal_info_step.dart';
import 'package:app_vendor/core/presentation/widgets/button_widget.dart';
import 'package:app_vendor/core/presentation/widgets/text_widget.dart';
import 'package:app_vendor/core/presentation/widgets/wid/colors.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

final stepProvider = StateProvider<int>((ref) => 0);

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(signUpFormProvider);
    final currentStep = ref.watch(stepProvider);
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated) {
        context.go('/mainScreen');
      } else if (next.status == AuthStatus.error && next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: Colors.red),
        );
      }
    });

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Register".i18n,
                style: TextStyle(
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.black, blurRadius: 3),
                  ],
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Color(0xff5673cc),
                      Color(0xff76c6f2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Icon(Icons.person_add,
                        size: 80, color: Colors.white.withOpacity(0.8)),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: ReactiveForm(
                formGroup: form,
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) {
                            final isActive = index == currentStep;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              width: isActive ? 16 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColor.kPrimaryColor
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          },
                        ),
                      ),
                      const Gap(15),
                      Expanded(
                        child: IndexedStack(
                          index: currentStep,
                          children: const [
                            PersonalInfoStep(),
                            ContactInfoStep(),
                            AddressInfoStep(),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (currentStep > 0)
                            ButtonWidget(
                              onTap: () {
                                ref.read(stepProvider.notifier).state--;
                              },
                              text: "Back".i18n,
                            ),
                          const Spacer(),
                          ReactiveFormConsumer(
                            builder: (context, formGroup, child) {
                              final isLastStep = currentStep == 2;

                              return ButtonWidget(
                                text: isLastStep ? "Sign Up".i18n : "Next".i18n,
                                isLoading:
                                    authState.status == AuthStatus.loading,
                                onTap: () async {
                                  final currentStepIndex =
                                      ref.read(stepProvider);
                                  bool isStepValid = false;

                                  switch (currentStepIndex) {
                                    case 0:
                                      isStepValid = form
                                              .control('firstName')
                                              .valid &&
                                          form.control('lastName').valid &&
                                          // form.control('dateOfBirth').valid &&
                                          form.control('gender').valid;
                                      break;
                                    case 1:
                                      isStepValid =
                                          form.control('email').valid &&
                                              form.control('password').valid &&
                                              form
                                                  .control('confirmPassword')
                                                  .valid &&
                                              form.control('phone').valid;
                                      break;
                                    case 2:
                                      isStepValid =
                                          form.control('city').valid &&
                                              form.control('street').valid &&
                                              form.control('floor').valid &&
                                              form.control('apartment').valid;
                                      // &&
                                      // form.control('hasApartment').valid;
                                      break;
                                  }

                                  if (!isStepValid) return;

                                  if (!isLastStep) {
                                    ref.read(stepProvider.notifier).state++;
                                  } else {
                                    FocusScope.of(context).unfocus();
                                    final user = _mapFormToEntity(form);
                                    await authNotifier.register(user);
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do you already have an account?".i18n,
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                          Gap(3),
                          TextButton(
                            onPressed: () {
                              context.push("/login");
                            },
                            child: TextWidget(
                              text: 'login'.i18n,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static UserRegisterEntity _mapFormToEntity(FormGroup form) {
    final phone = form.control("phone").value as PhoneNumber;
    return UserRegisterEntity(
      firstName: form.control("firstName").value.trim(),
      lastName: form.control("lastName").value.trim(),
      email: form.control("email").value.trim(),
      password: form.control("password").value.trim(),
      phone: phone.international,
      address: AddressEntity(
        city: form.control("city").value.trim(),
        street: form.control("street").value.trim(),
        floor: form.control("floor").value.trim(),
        apartment: form.control("apartment").value.trim(),
        // defaultAddress: form.control("hasApartment").value,
      ),
    );
  }
}

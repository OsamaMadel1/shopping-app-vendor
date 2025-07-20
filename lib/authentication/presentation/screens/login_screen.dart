//application/presentation/screens/login_screen

import 'package:app_vendor/authentication/application/auth_state.dart';
import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/authentication/application/providers/log_in_form_provider.dart';
import 'package:app_vendor/authentication/domain/entities/user_login_entity.dart';
import 'package:app_vendor/core/presentation/widgets/button_widget.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_password_input_widget.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/core/presentation/widgets/text_button_widget.dart';
import 'package:app_vendor/core/presentation/widgets/wid/colors.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:gap/gap.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final form = ref.watch(logInFormProvider);
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    // if (authState.status == AuthStatus.loading) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
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
                "login".i18n,
                style: TextStyle(
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black, blurRadius: 3)],
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [Color(0xff5673cc), Color(0xff76c6f2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Icon(
                      Icons.login,
                      size: 80,
                      color: Colors.white.withOpacity(0.8),
                    ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Welcome Back".i18n,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.kPrimaryColor,
                            ),
                          ),
                          Gap(8),
                          Text(
                            "welcome message".i18n,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    ReactiveTextInputWidget(
                      hint: "Email".i18n,
                      controllerName: "email",
                      prefixIcon: Icons.email_outlined,
                    ),
                    const Gap(40),
                    ReactivePasswordInputWidget(
                      hint: "Password".i18n,
                      controllerName: "password",
                      showEye: true,
                      textInputAction: TextInputAction.done,
                    ),
                    const Gap(20),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: ReactiveValueListenableBuilder(
                        formControlName: "email",
                        builder: (context, control, child) {
                          return TextButtonWidget(
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.scrim,
                            text: "Forgot Password?".i18n,
                            onTap: control.invalid
                                ? null
                                : () {
                                    //TODO: reset password
                                  },
                          );
                        },
                      ),
                    ),
                    const Gap(20),
                    ReactiveFormConsumer(
                      builder: (context, formGroup, child) {
                        return Center(
                          child: ButtonWidget(
                            text: "Login".i18n,
                            isLoading: authState.status == AuthStatus.loading,
                            onTap: formGroup.invalid
                                ? null
                                : () async {
                                    FocusScope.of(
                                      context,
                                    ).unfocus(); //  لإغلاق لوحة المفاتيح
                                    final email =
                                        (formGroup.control("email").value
                                                as String?)
                                            ?.trim() ??
                                        '';
                                    final password =
                                        (formGroup.control("password").value
                                                as String?)
                                            ?.trim() ??
                                        '';
                                    await authNotifier.login(
                                      UserLoginEntity(
                                        email: email,
                                        password: password,
                                      ),
                                    );
                                  },
                          ),
                        );
                      },
                    ),
                    const Gap(20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?".i18n,
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              context.push("/signUp");
                            },
                            child: Text(
                              "SignUp".i18n,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

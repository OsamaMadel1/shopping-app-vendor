import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/shop/applications/providers/shop_providers.dart';
import 'package:app_vendor/shop/applications/shop_state.dart';
import 'package:app_vendor/shop/domain/entities/shop_address_entity.dart';
import 'package:app_vendor/shop/domain/entities/shop_email_entity.dart';
import 'package:app_vendor/shop/domain/entities/shop_entity.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _didFillForm = false;

  final form = FormGroup({
    'shopFirstName': FormControl<String>(validators: [Validators.required]),
    'shopLastName': FormControl<String>(validators: [Validators.required]),
    'shopPhone': FormControl<String>(validators: [Validators.required]),
    'shopEmail': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'city': FormControl<String>(validators: [Validators.required]),
    'street': FormControl<String>(validators: [Validators.required]),
    'floor': FormControl<String>(validators: [Validators.required]),
    'apartment': FormControl<String>(validators: [Validators.required]),
  });

  @override
  void initState() {
    super.initState();
    final shopId = ref.read(authNotifierProvider).shopId;
    if (shopId != null) {
      Future.microtask(
        () => ref.read(shopNotifierProvider.notifier).fetchShopById(shopId),
      );
    }
  }

  void _fillFormWithShopData(ShopEntity shop) {
    form.control('shopFirstName').value = shop.firstName;
    form.control('shopLastName').value = shop.lastName;
    form.control('shopPhone').value = shop.phone;
    form.control('shopEmail').value = shop.email.userName;
    form.control('city').value = shop.address.city;
    form.control('floor').value = shop.address.floor;
    form.control('street').value = shop.address.street;
    form.control('apartment').value = shop.address.apartment;
  }

  void _onSubmit(String shopId) {
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    final updatedShop = ShopEntity(
      id: shopId,
      firstName: form.control('shopFirstName').value,
      lastName: form.control('shopLastName').value,
      phone: form.control('shopPhone').value,
      shopState: ShopStatus.open,
      email: ShopEmailEntity(
        userName: form.control('shopEmail').value,
        password: '',
      ),
      address: ShopAddressEntity(
        city: form.control('city').value,
        street: form.control('street').value,
        floor: form.control('floor').value,
        apartment: form.control('apartment').value,
      ),
    );

    ref.read(shopNotifierProvider.notifier).updateShop(updatedShop);
  }

  void _onDelete(String shopId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Confirm Delete Account'.i18n),
        content: Text('Are you sure you want to delete this account?'.i18n),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'.i18n),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete'.i18n),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final success = await ref
        .read(shopNotifierProvider.notifier)
        .deleteShop(shopId);

    if (mounted) Navigator.of(context).pop();

    if (!success) {
      final errMsg = ref
          .read(shopNotifierProvider)
          .maybeWhen(
            error: (message) => message,
            orElse: () =>
                'Failed to delete account. Please try again later.'.i18n,
          );
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errMsg)));
      }
      return;
    }

    await ref.read(authNotifierProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context) {
    final shopState = ref.watch(shopNotifierProvider);
    shopState.maybeWhen(
      singleLoaded: (shop) {
        if (!_didFillForm) {
          _fillFormWithShopData(shop);
          _didFillForm = true;
        }
      },
      orElse: () {},
    );

    final shopId = ref.read(authNotifierProvider).shopId;

    return Scaffold(
      appBar: AppBar(title: Text('Edit Shop Profile'.i18n)),
      body: shopState.maybeWhen(
        loading: () => const Center(child: CircularProgressIndicator()),
        singleLoaded: (_) => ReactiveForm(
          formGroup: form,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Personal Info Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Personal Information'.i18n,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('First Name'.i18n),
                                const SizedBox(height: 5),
                                ReactiveTextInputWidget(
                                  controllerName: 'shopFirstName',
                                  prefixIcon: Icons.person,
                                  hint: '',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Last Name'.i18n),
                                const SizedBox(height: 5),
                                ReactiveTextInputWidget(
                                  controllerName: 'shopLastName',
                                  prefixIcon: Icons.person,
                                  hint: '',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text('Phone Number'.i18n),
                      const SizedBox(height: 5),
                      ReactiveTextInputWidget(
                        prefixIcon: Icons.phone,
                        controllerName: 'shopPhone',
                        hint: '',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      Text('Email'.i18n),
                      const SizedBox(height: 5),
                      ReactiveTextInputWidget(
                        prefixIcon: Icons.email,
                        controllerName: 'shopEmail',
                        hint: '',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Address Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Address Information'.i18n,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('City'.i18n),
                                const SizedBox(height: 5),
                                ReactiveTextInputWidget(
                                  controllerName: 'city',
                                  hint: '',
                                  prefixIcon: Icons.location_city_outlined,
                                ),
                                const SizedBox(height: 16),
                                Text('Floor'.i18n),
                                const SizedBox(height: 5),
                                ReactiveTextInputWidget(
                                  controllerName: 'floor',
                                  hint: '',
                                  prefixIcon: Icons.apartment,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Street'.i18n),
                                const SizedBox(height: 5),
                                ReactiveTextInputWidget(
                                  controllerName: 'street',
                                  prefixIcon: Icons.streetview,
                                  hint: '',
                                ),
                                const SizedBox(height: 16),
                                Text('Apartment'.i18n),
                                const SizedBox(height: 5),
                                ReactiveTextInputWidget(
                                  controllerName: 'apartment',
                                  prefixIcon: Icons.home,
                                  hint: '',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Buttons
              ElevatedButton(
                child: Text('Save Changes'.i18n),
                onPressed: () {
                  if (shopId != null) {
                    _onSubmit(shopId);
                  }
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  if (shopId != null) {
                    _onDelete(shopId);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text('Delete Account'.i18n),
              ),
            ],
          ),
        ),
        error: (message) => Center(child: Text(message)),
        orElse: () => Center(child: Text('Loading data...'.i18n)),
      ),
    );
  }
}

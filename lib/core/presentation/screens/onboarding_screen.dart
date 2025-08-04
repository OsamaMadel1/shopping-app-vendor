// import 'package:app_vendor/translations.dart';
// import 'package:app_vendor/authentication/data/providers/dio_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lottie/lottie.dart';

// class AppStrings {
//   static const onboarding = [
//     {
//       'title': 'All your tools in one place',
//       'subtitle':
//           'Welcome to our app, where you can manage your products, orders, and more.',
//       'animation': 'assets/images/lottie/store.json',
//     },
//     {
//       'title': 'Publish your products fast',
//       'subtitle': 'Upload images, set prices, and start selling.',
//       'animation': 'assets/images/lottie/upload.json',
//     },
//     {
//       'title': 'Grow your business confidently',
//       'subtitle': 'Track performance, offers, and sales.',
//       'animation': 'assets/images/lottie/growth.json',
//     },
//   ];
// }

// class OnboardingScreen extends ConsumerStatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
//   final PageController _controller = PageController();
//   int _currentPage = 0;

//   List<Map<String, String>> get onboardingData => AppStrings.onboarding;

//   void _next() async {
//     if (_currentPage < onboardingData.length - 1) {
//       _controller.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       final prefs = ref.read(sharedPrefsProvider);
//       await prefs.setBool('seen_onboarding', true);

//       // ignore: use_build_context_synchronously
//       context.go('/login');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final data = onboardingData;

//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView.builder(
//               controller: _controller,
//               itemCount: data.length,
//               onPageChanged: (index) => setState(() => _currentPage = index),
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Lottie.asset(data[index]['animation']!, height: 250),
//                       const SizedBox(height: 30),
//                       Text(
//                         data[index]['title']!.i18n,
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.headlineSmall,
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         data[index]['subtitle']!.i18n,
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.bodyLarge,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(data.length, (index) {
//               final isActive = index == _currentPage;
//               return AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                 height: 8,
//                 width: isActive ? 20 : 8,
//                 decoration: BoxDecoration(
//                   color: isActive
//                       ? Theme.of(context).primaryColor
//                       : Colors.grey,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               );
//             }),
//           ),
//           const SizedBox(height: 24),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: ElevatedButton(
//               onPressed: _next,
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: Text(
//                 _currentPage == data.length - 1
//                     ? 'Get Started'.i18n
//                     : 'Next'.i18n,
//               ),
//             ),
//           ),
//           const SizedBox(height: 32),
//         ],
//       ),
//     );
//   }
// }

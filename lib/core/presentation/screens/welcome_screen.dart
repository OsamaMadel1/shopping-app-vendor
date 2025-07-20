// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 32.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Image.asset(
//                 'assets/images/logo.png', // مسار الصورة
//                 width: double.infinity, // عرض الصورة
//                 height: 200, // ارتفاع الصورة
//               ),
//             ),
//             SizedBox(height: 20),
//             // العنوان الرئيسي
//             Center(
//               child: Text(
//                 'مرحبا بك في السوق الالكتروني ',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 32,
//                   fontWeight: FontWeight.w300,
//                   height: 1.2,
//                 ),
//               ),
//             ),

//             SizedBox(height: 24),

//             // النص التوضيحي
//             Center(
//               child: Text(
//                 'انضم الينا وقم بادرة ونشر منتجات متجرك على الانترنت',
//                 style: TextStyle(
//                   color: Colors.black.withOpacity(0.9),
//                   fontSize: 16,
//                   height: 1.5,
//                 ),
//               ),
//             ),
//             SizedBox(height: 40),

//             // أزرار الدخول والتسجيل
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.push("/login");
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.blue.shade800,
//                       backgroundColor: Colors.black,
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'تسجيل دخول',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.push("/signUp");
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: Colors.transparent,
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         side: BorderSide(color: Colors.white),
//                       ),
//                     ),
//                     child: Text(
//                       'انشاء حساب',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'تعديل الملف الشخصي',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Tajawal', // يمكن استخدام خط عربي مثل Tajawal
//       ),
//       home: ProfileEditPage(),
//     );
//   }
// }

// class ProfileEditPage extends StatefulWidget {
//   @override
//   _ProfileEditPageState createState() => _ProfileEditPageState();
// }

// class _ProfileEditPageState extends State<ProfileEditPage> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _firstNameController =
//       TextEditingController(text: "osama");
//   TextEditingController _lastNameController =
//       TextEditingController(text: "customer");
//   TextEditingController _emailController =
//       TextEditingController(text: "oussamamadel3@gmail.com");
//   TextEditingController _mobileController =
//       TextEditingController(text: "55555555555");
//   TextEditingController _cityController = TextEditingController(text: "a");
//   TextEditingController _streetController = TextEditingController(text: "a");
//   TextEditingController _floorController = TextEditingController(text: "4");
//   DateTime? _birthDate;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("تعديل الملف الشخصي"),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // معلومات المستخدم
//               Center(
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 40,
//                       backgroundColor: Colors.blue.shade100,
//                       child: Icon(Icons.person, size: 40, color: Colors.blue),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "oussamamadel3@gmail.com",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 24),

//               // المعلومات الشخصية
//               Text("المعلومات الشخصية",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 16),
//               _buildTextField(
//                   _firstNameController, "الاسم الأول", TextInputType.name),
//               SizedBox(height: 12),
//               _buildTextField(
//                   _lastNameController, "الاسم الأخير", TextInputType.name),
//               SizedBox(height: 12),
//               _buildTextField(
//                   _mobileController, "رقم الجوال", TextInputType.phone),
//               SizedBox(height: 12),
//               GestureDetector(
//                 onTap: () => _selectBirthDate(context),
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       labelText: "تاريخ الميلاد",
//                       border: OutlineInputBorder(),
//                       suffixIcon: Icon(Icons.calendar_today),
//                     ),
//                     controller: TextEditingController(
//                         text: _birthDate != null
//                             ? "${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}"
//                             : ""),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),

//               // العنوان
//               Text("العنوان",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 16),
//               _buildTextField(_cityController, "المدينة", TextInputType.text),
//               SizedBox(height: 12),
//               _buildTextField(_streetController, "الشارع", TextInputType.text),
//               SizedBox(height: 12),
//               _buildTextField(_floorController, "الطابق", TextInputType.text),
//               SizedBox(height: 32),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // زر حذف الحساب
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red[700],
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: _showDeleteConfirmation,
//                     child: Text(
//                       "حذف الحساب",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),

//                   // زر حفظ التغييرات
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue[700],
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: _saveChanges,
//                     child: Text(
//                       "حفظ التغييرات",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//       TextEditingController controller, String label, TextInputType inputType) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//       ),
//       keyboardType: inputType,
//     );
//   }

//   Future<void> _selectBirthDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != _birthDate) {
//       setState(() {
//         _birthDate = picked;
//       });
//     }
//   }

//   void _saveChanges() {
//     if (_formKey.currentState!.validate()) {
//       // حفظ التغييرات هنا
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("تم حفظ التغييرات بنجاح")),
//       );
//     }
//   }

//   void _showDeleteConfirmation() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("تأكيد الحذف"),
//         content: Text(
//             "هل أنت متأكد من رغبتك في حذف الحساب؟ لا يمكن التراجع عن هذه العملية."),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("إلغاء"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               // حذف الحساب هنا
//             },
//             child: Text("حذف", style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
// }

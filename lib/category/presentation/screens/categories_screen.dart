// import 'package:app/category/application/category_notifier.dart';
// import 'package:app/category/application/providers/category_notifier_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';

// class CategoriesScreen extends ConsumerStatefulWidget {
//   const CategoriesScreen({super.key});

//   @override
//   ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(
//         () => ref.read(categoryNotifierProvider.notifier).fetchCategories());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(categoryNotifierProvider);
//     final notifier = ref.read(categoryNotifierProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('إدارة الفئات'),
//         centerTitle: true,
//       ),
//       body: state.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : state.errorMessage != null
//               ? Center(child: Text('خطأ: ${state.errorMessage}'))
//               : Column(
//                   children: [
//                     Expanded(
//                       child: state.categories.isEmpty
//                           ? const Center(child: Text('لا توجد فئات حاليًا'))
//                           : ListView.separated(
//                               padding: const EdgeInsets.all(16),
//                               itemCount: state.categories.length,
//                               separatorBuilder: (_, __) => const Gap(12),
//                               itemBuilder: (context, index) {
//                                 final category = state.categories[index];
//                                 return Card(
//                                   elevation: 2,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12)),
//                                   child: ListTile(
//                                     leading: const Icon(Icons.category,
//                                         color: Colors.blueGrey),
//                                     title: Text(category.name),
//                                     trailing: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         IconButton(
//                                           icon: const Icon(Icons.edit,
//                                               color: Colors.teal),
//                                           onPressed: () {
//                                             _showEditDialog(context, notifier,
//                                                 category.id, category.name);
//                                           },
//                                         ),
//                                         IconButton(
//                                           icon: const Icon(Icons.delete,
//                                               color: Colors.red),
//                                           onPressed: () {
//                                             _showDeleteDialog(context, notifier,
//                                                 category.id, category.name);
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           icon: const Icon(Icons.add),
//                           label: const Text('إضافة فئة'),
//                           onPressed: () => _showAddDialog(context, notifier),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }

//   void _showAddDialog(BuildContext context, CategoryNotifier notifier) {
//     final controller = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('إضافة فئة'),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(hintText: 'اسم الفئة'),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('إلغاء'),
//           ),
//           TextButton(
//             onPressed: () async {
//               final name = controller.text.trim();
//               if (name.isNotEmpty) {
//                 Navigator.pop(context);
//                 await notifier.addCategory(name);
//               }
//             },
//             child: const Text('إضافة'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showEditDialog(BuildContext context, CategoryNotifier notifier,
//       String id, String oldName) {
//     final controller = TextEditingController(text: oldName);
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('تعديل الفئة'),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(hintText: 'اسم الفئة الجديد'),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('إلغاء'),
//           ),
//           TextButton(
//             onPressed: () async {
//               // final newName = controller.text.trim();
//               // if (newName.isNotEmpty && newName != oldName) {
//               //   await notifier.updateCategory(id, newName);
//               //   Navigator.pop(context);
//               // }
//             },
//             child: const Text('حفظ'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showDeleteDialog(
//       BuildContext context, CategoryNotifier notifier, String id, String name) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('تأكيد الحذف'),
//         content: Text("هل أنت متأكد من حذف الفئة '$name'؟"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('إلغاء'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await notifier.deleteCategory(id);
//             },
//             child: const Text('حذف'),
//           ),
//         ],
//       ),
//     );
//   }
// }

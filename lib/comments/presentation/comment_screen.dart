import 'package:app_vendor/comments/application/providers/comment_notifier_provider.dart';
import 'package:app_vendor/comments/domain/entities/comment_entity.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_vendor/comments/application/comment_state.dart';

class CommentsScreen extends ConsumerStatefulWidget {
  final String productId;

  const CommentsScreen({super.key, required this.productId});

  @override
  ConsumerState<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends ConsumerState<CommentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(commentNotifierProvider.notifier)
          .getCommentsByProductId(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Comments'.i18n)),
      body: state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (comments) {
          if (comments.isEmpty) {
            return Center(child: Text('Not Comments Found'.i18n));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: comments.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final comment = comments[index];
              return _CommentItem(comment: comment);
            },
          );
        },
        error: (message) => Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class _CommentItem extends StatelessWidget {
  final CommentEntity comment;

  const _CommentItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة أو أيقونة المستخدم
          const CircleAvatar(radius: 20, child: Icon(Icons.person)),
          const SizedBox(width: 12),

          // النصوص والتفاصيل
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الاسم والتقييم بالنجوم
                Row(
                  children: [
                    Text(
                      '${comment.customerFirstName} ${comment.customerLastName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    _buildStars(comment.rating),
                  ],
                ),

                const SizedBox(height: 4),

                // نص التعليق
                Text(comment.comment, style: const TextStyle(fontSize: 14)),

                const SizedBox(height: 6),

                // الوقت + رد + إعجاب
                Row(
                  children: [
                    Text(
                      _timeAgo(comment.createdAt),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        // منطق الإعجاب
                      },
                      child: Text(
                        'Like'.i18n,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        // منطق الرد
                      },
                      child: Text(
                        'Reply'.i18n,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStars(int rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: 14,
          color: Colors.amber,
        ),
      ),
    );
  }

  String _timeAgo(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inSeconds < 60) return 'Now'.i18n;
    if (duration.inMinutes < 60) {
      return '${'Ago'.i18n}${duration.inMinutes}   ${'Minute'.i18n}';
    }
    if (duration.inHours < 24) {
      return '${'Ago'.i18n} ${duration.inHours} ${'Hour'.i18n}';
    }
    if (duration.inDays < 7) {
      return '${'Ago'.i18n} ${duration.inDays} ${'Day'.i18n}';
    }
    if (duration.inDays < 30) {
      return '${'Ago'.i18n} ${(duration.inDays / 7).floor()} ${'Week'.i18n}';
    }
    if (duration.inDays < 365) {
      return '${'Ago'.i18n} ${(duration.inDays / 30).floor()} ${'شهر'.i18n}';
    }
    return '${'Ago'.i18n} ${(duration.inDays / 365).floor()} ${'Year'.i18n}';
  }
}

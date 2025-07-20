// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? token;
  final String? shopId;
  final String? userName;
  final String? error;

  const AuthState({
    required this.status,
    this.token,
    this.shopId,
    this.userName,
    this.error,
  });

  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);

  AuthState copyWith({
    AuthStatus? status,
    String? token,
    String? shopId,
    String? userName,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
      shopId: shopId ?? this.shopId,
      userName: userName ?? this.userName,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, token, shopId, userName, error];
}

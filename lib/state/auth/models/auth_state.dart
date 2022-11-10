import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/auth/models/auth_result.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';

@immutable
class AuthState extends Equatable {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  AuthState copiedWithIsLoading(bool isLoading) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
      );

  @override
  List<Object?> get props => [
        result,
        isLoading,
        userId,
      ];
}

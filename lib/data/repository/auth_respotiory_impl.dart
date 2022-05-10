import 'package:flutter_hackathon/data/remote/event_data_source_impl.dart';
import 'package:flutter_hackathon/domain/data_source/remote/event_data_source.dart';
import 'package:flutter_hackathon/domain/entities/favorite_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/data_source/remote/auth_data_source.dart';
import '../../domain/repository/auth_repository.dart';
import '../remote/auth_data_scource_impl.dart';
import '../utils/utils.dart';

final authRepositoryProvider = Provider((ref) => AuthRepositoryImpl(
    authDataSource: ref.read(authDataSourceProvider)));

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
      {required AuthDataSource authDataSource})
      : _authDataSource = authDataSource;

  final AuthDataSource _authDataSource;

  @override
  Future<Result> signUp(String email, String password) async =>
      await _authDataSource.signUp(email, password);

  @override
  Future<Result> logIn(String email, String password) async =>
      await _authDataSource.logIn(email, password);

  @override
  Result isLogIn() => _authDataSource.isLogIn();

  @override
  Future<Result> logOut() async => await _authDataSource.logOut();

  @override
  Result getCurrentUserId() => _authDataSource.getCurrentUserId();
}
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_rick_and_morty/helpers/pref_keys.dart';
import 'package:flutter_rick_and_morty/helpers/save_provider.dart';
import 'package:meta/meta.dart';
//import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());

      try {
        final authCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        if (authCredential.user != null) {
          SaveProvider().saveUserSession(authCredential.user!.email!);
          print(authCredential);
          emit(AuthSucces('Пользователь успешно авторизован'));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<checkUserAccsec>((event, emit) async {
      String? user = await SaveProvider().getUser();
      if (user != null) {
        emit(AuthSucces('Пользователь успешно авторизован'));
      }
    });
    
    on<Registration>(
      (event, emit) async {
        emit(AuthLoading());

        try {
          final authCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

          if (authCredential.user != null) {
            SaveProvider().saveUserSession(authCredential.user!.email!);
            emit(AuthSucces('Пользователь успешно зарегистрирован'));
          }
        } on FirebaseAuthException catch (e) {
          emit(AuthFailure(FirebaseError(e)));
        } catch (e) {
          emit(AuthFailure('Ошибка: $e'));
        }
      },
    );
  }
  String FirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return "Аккаунт с таким email уже существует";
      case 'invalid-email':
        return "Некорректный формат email";
      case 'weak-password':
        return "Пароль слишком слабый (минимум 6 символов)";
      case 'user-not-found':
        return "Пользователь не найден";
      case 'wrong-password':
        return "Неверный пароль";
      default:
        return "Ошибка: ${e.message}";
    }
  }
}

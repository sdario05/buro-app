import 'package:buro_app/features/login/domain/usecase/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase useCase;

  LoginCubit(this.useCase) : super(LoginInitial());

  Future<void> login(String userName, String password) async {
    emit(LoginLoading());
    try {
      final response = await useCase.call(userName, password);
      emit(LoginSuccess(response));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
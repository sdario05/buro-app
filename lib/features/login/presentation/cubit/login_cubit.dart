import 'package:buro_app/features/login/data/dto/user_dto.dart';
import 'package:buro_app/features/login/domain/usecase/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase useCase;

  LoginCubit(this.useCase) : super(LoginInitial());

  Future<void> login(String userName, String password) async {
    emit(LoginLoading());
    final response = await useCase.call(UserDto(userName: userName, password: password));
    response.fold(
      (data) {
        emit(LoginSuccess(data));
      },
      (error) {
        emit(LoginError(error));
      }
    );
  }
}
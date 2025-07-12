import 'package:buro_app/features/welcome/presentation/cubit/user_name_states.dart';
import 'package:buro_app/preferences/app_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNameCubit extends Cubit<UserNameStates> {

  UserNameCubit() : super(UserNameInitial());

  void getUserName() async {
    emit(UserNameInitial());
    final prefs = AppPreferences.instance;
    final user = await prefs.getUser();
    emit(UserNameSuccess(user?.name ?? ""));
  }
}
import 'package:buro_app/features/modes/explorer/profession/domain/usecase/send_profession_use_case.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/cubit/explorer_profession_states.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/screen/explorer_profession_screen_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorerProfessionCubit extends Cubit<ExplorerProfessionStates> {
  final SendProfessionUseCase _useCase;

  ExplorerProfessionCubit(this._useCase) : super(Initial());

  Future<void> sendProfession(List<ProfessionEntry> professions) async {
    emit(Loading());
    try {
      await _useCase.call(professions);
      emit(Success());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
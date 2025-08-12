import 'package:buro_app/features/modes/explorer/contact/domain/model/contact_model.dart';
import 'package:buro_app/features/modes/explorer/contact/domain/usecase/send_contact_use_case.dart';
import 'package:buro_app/features/modes/explorer/contact/presentation/cubit/explorer_contact_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorerContactCubit extends Cubit<ExplorerContactStates> {
  final SendContactUseCase _useCase;

  ExplorerContactCubit(this._useCase) : super(Initial());

  Future<void> sendContacts(ContactModel contacts) async {
    emit(Loading());
    try {
      await _useCase.call(contacts);
      emit(Success());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
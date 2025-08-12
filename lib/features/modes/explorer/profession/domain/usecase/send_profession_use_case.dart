import 'package:buro_app/features/modes/explorer/profession/domain/repository/profession_repository.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/screen/explorer_profession_screen_content.dart';

class SendProfessionUseCase {
  final ProfessionRepository repository;

  SendProfessionUseCase(this.repository);

  Future<void> call(List<ProfessionEntry> professions) async {
    return await repository.sendProfession(professions);
  }
}
import 'package:buro_app/features/modes/explorer/profession/data/service/profession_service.dart';
import 'package:buro_app/features/modes/explorer/profession/domain/repository/profession_repository.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/screen/explorer_profession_screen_content.dart';


class ProfessionRepositoryImpl implements ProfessionRepository {
  final ProfessionService service;

  ProfessionRepositoryImpl(this.service);

  @override
  Future<void> sendProfession(List<ProfessionEntry> professions) async {
    return await service.sendProfession(professions);
  }
}
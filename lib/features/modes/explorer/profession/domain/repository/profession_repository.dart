import 'package:buro_app/features/modes/explorer/profession/presentation/screens/explorer_profession_screen_content.dart';

abstract class ProfessionRepository {
  Future<void> sendProfession(List<ProfessionEntry> professions);
}
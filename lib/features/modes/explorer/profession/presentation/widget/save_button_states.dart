import 'package:buro_app/features/modes/explorer/profession/presentation/cubit/explorer_profession_cubit.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/cubit/explorer_profession_states.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/screens/explorer_profession_screen_content.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/widget/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveButtonStates extends StatelessWidget {
  final List<ProfessionEntry> professions;
  final Function(List<String>) onSaveSuccess;

  const SaveButtonStates({
    super.key,
    required this.professions,
    required this.onSaveSuccess,
  });

  bool get _canSend => professions.any((entry) => entry.profession.trim().isNotEmpty);

  List<ProfessionEntry> notEmptyProfessions() {
    return professions.where((entry) => entry.profession.isNotEmpty).toList();
}

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExplorerProfessionCubit, ExplorerProfessionStates>(
        listener: (context, state) {
          switch (state) {
            case Success(): {
              onSaveSuccess(notEmptyProfessions().map((e) => e.profession).toList());
            }
          }
        },
        builder: (context, state) {
          switch (state) {
            case Initial(): {
              return SaveButton(
                onClick: _canSend
                    ? () {
                      context.read<ExplorerProfessionCubit>().sendProfession(notEmptyProfessions());
                    }
                    : null,
              );
            }
            case Loading(): {
              return const SaveButton(
                isLoading: true,
              );
            }
            case Success(): {
              return const SaveButton();
            }
            case Error(): {
              return SaveButton(
                onClick: _canSend
                    ? () {
                  context.read<ExplorerProfessionCubit>().sendProfession(professions);
                }
                    : null,
              );
            }
            default: return const SaveButton();
          }
        }
    );
  }
}
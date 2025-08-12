import 'package:buro_app/features/modes/explorer/contact/domain/model/contact_model.dart';
import 'package:buro_app/features/modes/explorer/contact/presentation/cubit/explorer_contact_cubit.dart';
import 'package:buro_app/features/modes/explorer/contact/presentation/cubit/explorer_contact_states.dart';
import 'package:buro_app/shared/widget/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveButtonStates extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController phone;
  final List<String> additional;
  final VoidCallback onSaveSuccess;

  const SaveButtonStates({
    super.key,
    required this.email,
    required this.phone,
    required this.additional,
    required this.onSaveSuccess,
  });

  @override
  Widget build(BuildContext context) {
    const buttonText = 'Activarme como Explorador de empleos';
    return BlocConsumer<ExplorerContactCubit, ExplorerContactStates>(
        listener: (context, state) {
          switch (state) {
            case Success(): {
              onSaveSuccess();
            }
          }
        },
        builder: (context, state) {
          switch (state) {
            case Initial(): {
              return SaveButton(
                onClick: () {
                  _validateAndSend(context);
                },
                text: buttonText,
              );
            }
            case Loading(): {
              return const SaveButton(
                isLoading: true,
                text: buttonText,
              );
            }
            case Success(): {
              return const SaveButton(
                text: buttonText,
              );
            }
            case Error(): {
              return SaveButton(
                onClick: () {
                  _validateAndSend(context);
                },
                text: buttonText,
              );
            }
            default: return const SaveButton(
              text: buttonText,
            );
          }
        }
    );
  }

  void _validateAndSend(BuildContext context) {
    print(email);
    print(phone);
    if (email.text.isEmpty && phone.text.isEmpty && additional.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, ingresa al menos un método de contacto.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<ExplorerContactCubit>().sendContacts(ContactModel(
      email: email.text,
      phone: phone.text,
      additional: additional
    ));
  }
}
import 'package:buro_app/features/modes/explorer/contact/presentation/cubit/explorer_contact_cubit.dart';
import 'package:buro_app/features/modes/explorer/contact/presentation/screen/explorer_contact_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buro_app/di/injection.dart';

class ExplorerContactScreen extends StatelessWidget {

  const ExplorerContactScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExplorerContactCubit>(
      create: (context) => getIt<ExplorerContactCubit>(),
      child: const ExplorerContactScreenContent(),
    );
  }
}
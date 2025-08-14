import 'package:buro_app/features/modes/explorer/completed/presentation/screen/explorer_upload_success_screen_content.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buro_app/di/injection.dart';

class ExplorerUploadSuccessScreen extends StatelessWidget {

  const ExplorerUploadSuccessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageCubit>(
      create: (context) => getIt<ImageCubit>()
        ..getImage(ImageType.explorerCompleted),
      child: const ExplorerUploadSuccessScreenContent(),
    );
  }
}
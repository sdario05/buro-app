import 'package:buro_app/features/modes/explorer/upload_cv/presentation/cubit/cv_cubit.dart';
import 'package:buro_app/features/modes/explorer/upload_cv/presentation/screen/explorer_upload_cv_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buro_app/di/injection.dart';

class ExplorerUploadCvScreen extends StatelessWidget {

  const ExplorerUploadCvScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CvCubit>(
      create: (context) => getIt<CvCubit>(),
      child: const ExplorerUploadCVScreenContent(),
    );
  }
}
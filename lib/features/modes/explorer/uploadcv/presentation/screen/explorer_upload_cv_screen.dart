import 'package:buro_app/features/modes/explorer/uploadcv/presentation/cubit/cv_cubit.dart';
import 'package:buro_app/features/modes/explorer/uploadcv/presentation/screen/explorer_upload_cv_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buro_app/di/injection.dart';

class ExplorerUploadCvScreen extends StatelessWidget {

  final Function(String) onNavigate;
  final Function() onBack;

  const ExplorerUploadCvScreen({
    super.key,
    required this.onNavigate,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CvCubit>(
      create: (context) => getIt<CvCubit>(),
      child: ExplorerUploadCVScreenContent(onNavigate: onNavigate, onBack: onBack),
    );
  }
}
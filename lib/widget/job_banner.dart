import 'package:flutter/material.dart';
import '../features/modes/explorer/home/domain/model/job_listing.dart';
import '../utils/app_styles.dart';
import '../utils/animations.dart';
import 'custom_icons.dart';

class JobBanner extends StatelessWidget {
  final JobListing listing;
  final VoidCallback onTap;
  final bool isSmallScreen;

  const JobBanner({
    Key? key,
    required this.listing,
    required this.onTap,
    this.isSmallScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determinar si es un generador (ofrece empleo) o un explorador (busca empleo)
    final bool isGenerator = listing.type == 'generator';
    final Color primaryColor = isGenerator ? AppColors.generatorPrimary : AppColors.explorerPrimary;
    final Color secondaryColor = isGenerator ? AppColors.generatorSecondary : AppColors.explorerSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AnimatedBanner(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado con gradiente
              Container(
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor,
                      secondaryColor,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ),
              
              // Contenido principal
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Avatar o logo con icono que refleja si ofrece o busca empleo
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: secondaryColor.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              isGenerator ? Icons.business : Icons.person,
                              color: primaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Información principal
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listing.name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.darkGrey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  // Etiqueta que indica si ofrece o busca empleo
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    margin: const EdgeInsets.only(right: 6),
                                    decoration: BoxDecoration(
                                      color: isGenerator ? AppColors.generatorSecondary : AppColors.explorerSecondary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      isGenerator ? 'Ofrece' : 'Busca',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: isGenerator ? AppColors.generatorPrimary : AppColors.explorerPrimary,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      listing.title ?? '',
                                      style: const TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Icono de flecha
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColors.ultraLightGrey,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Descripción
                    if (!isSmallScreen) ...[
                      const SizedBox(height: 16),
                      Text(
                        listing.description ?? '',
                        style: AppStyles.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    
                    const SizedBox(height: 16),
                    
                    // Detalles específicos según el tipo
                    if (isGenerator)
                      _buildGeneratorDetails()
                    else
                      _buildExplorerDetails(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGeneratorDetails() {
    return Row(
      children: [
        CustomIcon(
          icon: Icons.location_on,
          color: AppColors.generatorPrimary,
          size: 20,
          isOutlined: true,
        ),
        const SizedBox(width: 8),
        Text(
          listing.location ?? '',
          style: AppStyles.caption,
        ),
        const SizedBox(width: 16),
        CustomIcon(
          icon: Icons.attach_money,
          color: AppColors.generatorPrimary,
          size: 20,
          isOutlined: true,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            listing.salary ?? '',
            style: AppStyles.caption,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildExplorerDetails() {
    return Row(
      children: [
        CustomIcon(
          icon: Icons.work,
          color: AppColors.explorerPrimary,
          size: 20,
          isOutlined: true,
        ),
        const SizedBox(width: 8),
        Text(
          'Exp: ${listing.experience ?? ''}',
          style: AppStyles.caption,
        ),
        const SizedBox(width: 16),
        CustomIcon(
          icon: Icons.access_time,
          color: AppColors.explorerPrimary,
          size: 20,
          isOutlined: true,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Disponibilidad: ${listing.availability ?? ''}',
            style: AppStyles.caption,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

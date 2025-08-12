import 'package:flutter/material.dart';
import '../utils/app_styles.dart';
import '../models/job_listing.dart';
import '../widget/job_banner.dart';

class ExplorerDashboardScreen extends StatefulWidget {
  final Function(String) onNavigate;
  final Function() onBack;

  const ExplorerDashboardScreen({
    Key? key,
    required this.onNavigate,
    required this.onBack,
  }) : super(key: key);

  @override
  _ExplorerDashboardScreenState createState() => _ExplorerDashboardScreenState();
}

class _ExplorerDashboardScreenState extends State<ExplorerDashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Datos de ejemplo para generadores (ofrecen empleo)
  final List<JobListing> _generators = [
    JobListing(
      id: '1',
      name: 'La Cantera BarberShop',
      title: 'Barbero & Estilista',
      type: 'generator', // Ofrece empleo
      description: 'Buscamos un Barbero Estilista con experiencia en cortes modernos y clásicos.',
      location: 'Buenos Aires',
      salary: '\$150,000 - \$200,000',
    ),
    JobListing(
      id: '2',
      name: 'Mi sabor',
      title: 'Cocinero',
      type: 'generator', // Ofrece empleo
      description: 'Se busca un cocinero para nuestra tienda de empanadas en Villa Crespo.',
      location: 'CABA',
      salary: '\$600,000 - \$700,000',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: Column(
          children: [
            // Barra de navegación superior
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  // Buscador
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.ultraLightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Buscar empleos',
                          hintStyle: TextStyle(color: AppColors.lightGrey),
                          prefixIcon: Icon(Icons.search, color: AppColors.grey, size: 20),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Icono de perfil
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.explorerSecondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'GR',
                        style: TextStyle(
                          color: AppColors.explorerPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Contenido principal
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mensaje de bienvenida
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¡Bienvenido, Explorador!',
                            style: AppStyles.heading1,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tu CV ha sido cargado exitosamente. Ahora puedes explorar ofertas de empleo disponibles.',
                            style: AppStyles.subtitle,
                          ),
                        ],
                      ),
                    ),

                    // Sección de ofertas de empleo
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Ofertas de empleo recomendadas',
                        style: AppStyles.heading2,
                      ),
                    ),

                    // Lista de ofertas
                    ...(_generators.map((generator) => 
                      JobBanner(
                        listing: generator,
                        onTap: () {
                          // Mostrar un mensaje de que la funcionalidad está en desarrollo
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Funcionalidad en desarrollo'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      )
                    ).toList()),

                    const SizedBox(height: 24),

                    // Mensaje de completar perfil
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Completa tu perfil',
                            style: AppStyles.heading2,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Para aumentar tus posibilidades de encontrar empleo, te recomendamos completar tu perfil con más información.',
                            style: AppStyles.body,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Mostrar un mensaje de que la funcionalidad está en desarrollo
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Funcionalidad en desarrollo'),
                                    duration: Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.explorerPrimary,
                              ),
                              child: const Text('Completar perfil'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Barra de navegación inferior
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home, 'Inicio', true),
                  _buildNavItem(Icons.search, 'Buscar', false),
                  _buildNavItem(Icons.bookmark, 'Guardados', false),
                  _buildNavItem(Icons.person, 'Perfil', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {
        // Mostrar un mensaje de que la funcionalidad está en desarrollo
        if (!isActive) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Funcionalidad en desarrollo'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.explorerPrimary : AppColors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.explorerPrimary : AppColors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

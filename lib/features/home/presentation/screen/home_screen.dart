import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../modes/explorer/home/domain/model/job_listing.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/animations.dart';
import '../../../../widget/custom_icons.dart';
import '../../../../widget/job_banner.dart';
import '../../../job_detail/presentation/screen/job_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) onModeChange;

  const HomeScreen({
    Key? key,
    required this.onModeChange,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool _showGenerators = true;
  bool _showExplorers = true;
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Datos de ejemplo para generadores (ofrecen empleo) y exploradores (buscan empleo)
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

  final List<JobListing> _explorers = [
    JobListing(
      id: '3',
      name: 'Laura Martínez',
      title: 'Desarrolladora Full Stack',
      type: 'explorer', // Busca empleo
      description: 'Especialista en React, Node.js y bases de datos SQL/NoSQL.',
      experience: '5 años',
      availability: 'Inmediata',
    ),
    JobListing(
      id: '4',
      name: 'Carlos Capela',
      title: 'Limpia Copas',
      type: 'explorer', // Busca empleo
      description: 'Alta experiencia lavando copas, no se me rompe ni una.',
      experience: '3 años',
      availability: 'Part-time',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey, // Cambiado a gris más oscuro
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                // Barra de navegación superior con efecto de elevación
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
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 12 : 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      // Buscador con diseño mejorado
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
                              hintText: 'Buscar',
                              hintStyle: TextStyle(color: AppColors.lightGrey),
                              prefixIcon: Icon(Icons.search, color: AppColors.grey, size: 20),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Icono de perfil mejorado
                      ProfileAvatar(
                        initials: 'GR',
                        onTap: () => _showProfileOptions(context),
                      ),
                    ],
                  ),
                ),

                // Contenido principal (scrollable)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Título y subtítulo con animación
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 12 : 16,
                            vertical: 24,
                          ),
                          child: Column(
                            children: [
                              // Título
                              Text(
                                'Hechá un vistazo al portal\nde novedades',
                                textAlign: TextAlign.center,
                                style: AppStyles.heading1,
                              ),
                              const SizedBox(height: 12),
                              // Subtítulo
                              Text(
                                'Recordá que al estar en "modo visitante" podés visualizar todas las propuestas pero no interactuar.',
                                textAlign: TextAlign.center,
                                style: AppStyles.subtitle,
                              ),
                            ],
                          ),
                        ),

                        // Checkboxes con animación
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 12 : 16,
                            vertical: 8,
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 20,
                            runSpacing: 12,
                            children: [
                              // Checkbox para generadores
                              CustomCheckbox(
                                label: 'Ver Generadores (ofrecen empleo)',
                                value: _showGenerators,
                                onChanged: (value) {
                                  setState(() {
                                    _showGenerators = value ?? true;
                                  });
                                },
                              ),
                              // Checkbox para exploradores
                              CustomCheckbox(
                                label: 'Ver Exploradores (buscan empleo)',
                                value: _showExplorers,
                                onChanged: (value) {
                                  setState(() {
                                    _showExplorers = value ?? true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Banners de generadores con animación
                        if (_showGenerators) ...[
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _generators.map((generator) =>
                                JobBanner(
                                  listing: generator,
                                  isSmallScreen: isSmallScreen,
                                  onTap: () {
                                    // Navegar a la pantalla de detalle
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobDetailScreen(
                                          listing: generator,
                                          onModeChange: widget.onModeChange,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ).toList(),
                            ),
                          ),
                        ],

                        // Banners de exploradores con animación
                        if (_showExplorers) ...[
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _explorers.map((explorer) =>
                                JobBanner(
                                  listing: explorer,
                                  isSmallScreen: isSmallScreen,
                                  onTap: () {
                                    // Navegar a la pantalla de detalle
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobDetailScreen(
                                          listing: explorer,
                                          onModeChange: widget.onModeChange,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ).toList(),
                            ),
                          ),
                        ],

                        const SizedBox(height: 24),

                        // Sección de cambio de modo con diseño mejorado
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
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
                          child: Column(
                            children: [
                              // Texto de cambio de modo
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  'Actualmente estás en modo visitante, ¿te gustaría cambiar de modo?',
                                  textAlign: TextAlign.center,
                                  style: AppStyles.subtitle,
                                ),
                              ),

                              // Botones de cambio de modo con diseño mejorado
                              Row(
                                children: [
                                  // Botón de generador
                                  Expanded(
                                    child: _buildModeButton(
                                      'Quiero ser\nGenerador de empleos',
                                      Icons.business_center,
                                      AppColors.generatorPrimary,
                                      () => widget.onModeChange('generador'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Botón de explorador
                                  Expanded(
                                    child: _buildModeButton(
                                      'Quiero ser\nExplorador de empleos',
                                      Icons.search,
                                      AppColors.explorerPrimary,
                                      () => widget.onModeChange('explorador'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModeButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    return AnimatedBanner(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          color: color.withOpacity(0.05),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w500,
                fontSize: 13,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              _buildProfileOption(
                icon: Icons.person,
                title: 'Mi perfil',
                onTap: () {
                  Navigator.pop(context);
                  // Navegar al perfil
                },
              ),
              _buildProfileOption(
                icon: Icons.settings,
                title: 'Configuración',
                onTap: () {
                  Navigator.pop(context);
                  // Navegar a configuración
                },
              ),
              _buildProfileOption(
                icon: Icons.swap_horiz,
                title: 'Cambiar modo',
                onTap: () {
                  Navigator.pop(context);
                  // Mostrar opciones de modo
                  _showModeOptions(context);
                },
              ),
              _buildProfileOption(
                icon: Icons.logout,
                title: 'Cerrar sesión',
                onTap: () {
                  Navigator.pop(context);
                  // Cerrar sesión
                  widget.onModeChange('logout');
                },
                isLast: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.ultraLightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.darkGrey),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkGrey,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.lightGrey,
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.only(left: 80.0),
            child: Divider(
              height: 1,
              color: Colors.grey[200],
            ),
          ),
      ],
    );
  }

  void _showModeOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Cambiar modo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Selecciona el modo en el que deseas navegar:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                _buildModeOption(
                  icon: Icons.visibility,
                  title: 'Visitante',
                  description: 'Visualiza todas las propuestas sin interactuar',
                  onTap: () {
                    Navigator.pop(context);
                    widget.onModeChange('visitante');
                  },
                ),
                const SizedBox(height: 12),
                _buildModeOption(
                  icon: Icons.business_center,
                  title: 'Generador',
                  description: 'Publica ofertas de empleo',
                  onTap: () {
                    Navigator.pop(context);
                    widget.onModeChange('generador');
                  },
                ),
                const SizedBox(height: 12),
                _buildModeOption(
                  icon: Icons.search,
                  title: 'Explorador',
                  description: 'Busca oportunidades laborales',
                  onTap: () {
                    Navigator.pop(context);
                    widget.onModeChange('explorador');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModeOption({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.ultraLightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.darkGrey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.lightGrey,
            ),
          ],
        ),
      ),
    );
  }
}

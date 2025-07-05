import 'package:flutter/material.dart';
import '../models/job_listing.dart';
import '../utils/app_styles.dart';
import '../utils/animations.dart';
import '../widgets/custom_icons.dart';
// Añadir la importación del widget de registro
import '../widgets/registration_popup.dart';

class JobDetailScreen extends StatefulWidget {
  final JobListing listing;
  final Function(String) onModeChange;

  const JobDetailScreen({
    Key? key,
    required this.listing,
    required this.onModeChange,
  }) : super(key: key);

  @override
  _JobDetailScreenState createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Dentro de la clase _JobDetailScreenState, añadir este método para mostrar el pop-up
  void _showRegistrationPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return RegistrationPopup(
          onClose: () => Navigator.pop(context),
          onExplorerSelected: () {
            Navigator.pop(context);
            widget.onModeChange('explorador');
          },
          onGeneratorSelected: () {
            Navigator.pop(context);
            widget.onModeChange('generador');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isGenerator = widget.listing.type == 'generator';
    final Color primaryColor = isGenerator ? AppColors.generatorPrimary : AppColors.explorerPrimary;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;
    
    // Datos adicionales mockeados según el tipo de banner
    final Map<String, String> additionalInfo = isGenerator
        ? {
            'Empresa': 'Mi sabor',
            'Rubro': 'Gastronomía',
            'Experiencia requerida': '2 años mínimo',
            'Educación': 'Secundario completo',
            'Idiomas': 'Español',
          }
        : {
            'Profesión': 'Desarrollador',
            'Estudios': 'Universitario completo',
            'Idiomas': 'Español, Inglés',
            'Movilidad': 'Propia',
            'Disponibilidad': 'Inmediata',
          };

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
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  // Botón de retroceso
                  AnimatedIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context),
                    color: AppColors.darkGrey,
                  ),
                  
                  // Buscador con diseño mejorado
                  Expanded(
                    child: Container(
                      height: 44,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.ultraLightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
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
                  
                  // Icono de perfil mejorado
                  ProfileAvatar(
                    initials: 'GR',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Contenido principal (scrollable)
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Encabezado con gradiente
                        Container(
                          width: double.infinity,
                          height: 8,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                primaryColor.withOpacity(0.7),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                        
                        // Información principal
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Avatar o logo
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: isGenerator 
                                      ? AppColors.generatorSecondary.withOpacity(0.5)
                                      : AppColors.explorerSecondary.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    isGenerator ? Icons.business : Icons.person,
                                    color: primaryColor,
                                    size: 40,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // Título y subtítulo
                              Text(
                                '¡Hola! Somos "${widget.listing.name}" y esta es nuestra propuesta laboral:',
                                textAlign: TextAlign.center,
                                style: AppStyles.heading2,
                              ),
                              const SizedBox(height: 24),
                              
                              // Descripción detallada
                              Text(
                                isGenerator
                                    ? 'Estamos buscando a un ${widget.listing.title} para nuestra tienda de empanadas en Villa Crespo que sea rápido y proactivo.'
                                    : 'Me especializo como ${widget.listing.title} con amplia experiencia en el sector. Busco oportunidades laborales que me permitan crecer profesionalmente.',
                                textAlign: TextAlign.center,
                                style: AppStyles.body,
                              ),
                              const SizedBox(height: 16),
                              
                              // Información adicional
                              Text(
                                isGenerator
                                    ? 'Ofrecemos un muy buen equipo de trabajo y un cálido ambiente laboral.'
                                    : 'Ofrezco responsabilidad, puntualidad y excelentes habilidades de comunicación.',
                                textAlign: TextAlign.center,
                                style: AppStyles.body,
                              ),
                              const SizedBox(height: 16),
                              
                              // Llamado a la acción
                              Text(
                                isGenerator
                                    ? 'Si estás interesado en estos requisitos, ¡no dudes en postularte!'
                                    : 'Si estás interesado en mi perfil, ¡no dudes en contactarme!',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Etiquetas
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Primera fila de etiquetas
                              Row(
                                children: [
                                  _buildTag(widget.listing.title),
                                  const SizedBox(width: 8),
                                  _buildTag(isGenerator ? 'Presencial' : 'Remoto'),
                                  const SizedBox(width: 8),
                                  _buildTag(isGenerator ? 'Full time' : 'Part time'),
                                ],
                              ),
                              const SizedBox(height: 12),
                              
                              // Segunda fila de etiquetas
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTag(
                                      isGenerator 
                                          ? widget.listing.salary ?? '\$600.000 - \$700.000 x mes'
                                          : 'Experiencia: ${widget.listing.experience ?? '5 años'}',
                                      isExpanded: true,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  _buildTag(
                                    isGenerator 
                                        ? widget.listing.location ?? 'CABA'
                                        : widget.listing.availability ?? 'Inmediata',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Información adicional
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Información adicional',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // Lista de información adicional
                              ...additionalInfo.entries.map((entry) => _buildInfoItem(entry.key, entry.value)),
                              
                              const SizedBox(height: 16),
                              
                              // Enlace al perfil
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('En modo visitante solo puedes ver las propuestas, no interactuar con ellas.'),
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                child: Text(
                                  'Ingresar al perfil de "${widget.listing.name}"',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Botones de acción
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
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Botón de guardar
                  Expanded(
                    child: ElevatedButton(
                      // Reemplazar el onPressed del botón de guardar con:
                      onPressed: () {
                        if (widget.listing.type == 'visitante') {
                          _showRegistrationPopup();
                        } else {
                          setState(() {
                            _isSaved = !_isSaved;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_isSaved 
                                  ? 'Propuesta guardada en favoritos' 
                                  : 'Propuesta eliminada de favoritos'),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      style: AppStyles.secondaryButtonStyle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isSaved ? Icons.bookmark : Icons.bookmark_border,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(_isSaved ? 'Guardado' : 'Guardar'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Botón de postularse
                  Expanded(
                    child: ElevatedButton(
                      // Reemplazar el onPressed del botón de postularse con:
                      onPressed: () {
                        _showRegistrationPopup();
                      },
                      style: AppStyles.primaryButtonStyle,
                      child: const Text('Postularme'),
                    ),
                  ),
                ],
              ),
            ),
            
            // Sección de cambio de modo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.backgroundGrey,
              child: Column(
                children: [
                  // Texto de cambio de modo
                  const Text(
                    'Actualmente estás en modo visitante, ¿te gustaría cambiar de modo?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Botones de cambio de modo
                  Row(
                    children: [
                      // Botón de generador
                      Expanded(
                        child: _buildModeButton(
                          'Quiero ser\nGenerador de empleos',
                          () => widget.onModeChange('generador'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Botón de explorador
                      Expanded(
                        child: _buildModeButton(
                          'Quiero ser\nExplorador de empleos',
                          () => widget.onModeChange('explorador'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, {bool isExpanded = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: AppStyles.tagDecoration,
      width: isExpanded ? double.infinity : null,
      child: Text(
        text,
        textAlign: isExpanded ? TextAlign.center : TextAlign.left,
        style: AppStyles.tagText,
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.darkGrey,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton(String text, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.lightGrey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.darkGrey,
          fontWeight: FontWeight.w500,
          fontSize: 13,
          height: 1.3,
        ),
      ),
    );
  }
}

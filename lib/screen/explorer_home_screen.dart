import 'package:flutter/material.dart';
import '../models/job_listing.dart';
import '../utils/app_styles.dart';
import '../widget/job_banner.dart';

class ExplorerHomeScreen extends StatefulWidget {
  final Function(String, {dynamic data}) onNavigate;
  final Function() onBack;

  const ExplorerHomeScreen({
    Key? key,
    required this.onNavigate,
    required this.onBack,
  }) : super(key: key);

  @override
  _ExplorerHomeScreenState createState() => _ExplorerHomeScreenState();
}

class _ExplorerHomeScreenState extends State<ExplorerHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _currentTab = 'disponibles'; // Por defecto muestra empleos disponibles
  
  // Datos de ejemplo para empleos disponibles
  final List<JobListing> _availableJobs = [
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
    JobListing(
      id: '3',
      name: 'Café del Centro',
      title: 'Barista',
      type: 'generator', // Ofrece empleo
      description: 'Buscamos barista con experiencia para café de especialidad.',
      location: 'Córdoba',
      salary: '\$180,000 - \$220,000',
    ),
  ];
  
  // Datos de ejemplo para empleos guardados
  final List<JobListing> _savedJobs = [
    JobListing(
      id: '4',
      name: 'Restaurante El Sabor',
      title: 'Chef Ejecutivo',
      type: 'generator',
      description: 'Buscamos chef con experiencia en cocina internacional para restaurante de alta categoría.',
      location: 'Buenos Aires',
      salary: '\$800,000 - \$1,000,000',
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
      backgroundColor: Colors.grey[200], // Fondo gris claro como en la imagen
      body: SafeArea(
        child: Column(
          children: [
            // Header with search and profile
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  // Buscador
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Buscar',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Perfil
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 20,
                    child: const Text(
                      'GR',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título y subtítulo
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Hechá un vistazo al portal de novedades',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                              children: const [
                                TextSpan(text: 'Recordá que al estar en "'),
                                TextSpan(
                                  text: 'modo explorador de empleos',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: '" tu visualidad está destinada a explorador futuros empleos.'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Contenido según la pestaña seleccionada
                    _buildTabContent(),
                  ],
                ),
              ),
            ),
            
            // Bottom navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavButton('disponibles', 'Empleos\ndisponibles'),
                  _buildNavButton('guardados', 'Empleos\nguardados'),
                  _buildNavButton('convocatoria', 'Iniciar\nconvocatoria'),
                  _buildNavButton('misConvocatorias', 'Mis\nconvocatorias'),
                  _buildNavButton('cambiarModo', 'Cambiar\nde modo'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(String tabName, String label) {
    bool isActive = _currentTab == tabName;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentTab = tabName;
        });
        
        // Acciones específicas para cada botón
        if (tabName == 'cambiarModo') {
          // Navegar al modo generador
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cambiando al modo generador...'),
              duration: Duration(seconds: 2),
            ),
          );
          // widget.onNavigate('generator_welcome');
        }
      },
      child: Container(
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.grey[300] : Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_currentTab) {
      case 'disponibles':
        return _buildAvailableJobsContent();
      case 'guardados':
        return _buildSavedJobsContent();
      case 'convocatoria':
        return _buildStartCallContent();
      case 'misConvocatorias':
        return _buildMyCallsContent();
      default:
        return _buildAvailableJobsContent();
    }
  }

  Widget _buildAvailableJobsContent() {
    return Column(
      children: [
        // Placeholder boxes for job listings
        for (var job in _availableJobs)
          _buildJobPlaceholder(job),
      ],
    );
  }

  Widget _buildSavedJobsContent() {
    if (_savedJobs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'No tienes empleos guardados',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }
    
    return Column(
      children: [
        for (var job in _savedJobs)
          _buildJobPlaceholder(job),
      ],
    );
  }

  Widget _buildStartCallContent() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.work_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Inicia una convocatoria para que los empleadores te encuentren',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Próximamente disponible',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyCallsContent() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Aquí verás tus convocatorias activas',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'No tienes convocatorias activas',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobPlaceholder(JobListing job) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[300]!,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Logo placeholder
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      job.name.substring(0, 1),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Company and title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        job.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Save button
                IconButton(
                  icon: Icon(
                    _savedJobs.any((savedJob) => savedJob.id == job.id) 
                        ? Icons.favorite 
                        : Icons.favorite_border,
                    color: _savedJobs.any((savedJob) => savedJob.id == job.id)
                        ? Colors.red
                        : Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      if (_savedJobs.any((savedJob) => savedJob.id == job.id)) {
                        _savedJobs.removeWhere((savedJob) => savedJob.id == job.id);
                      } else {
                        _savedJobs.add(job);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          
          // Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                Text(
                  job.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Location and salary
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      job.location ?? 'No especificado',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.attach_money, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      job.salary ?? 'No especificado',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Apply button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Aplicando al empleo...'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Aplicar ahora'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

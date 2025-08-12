import 'package:flutter/material.dart';

class ExplorerContactScreen extends StatefulWidget {
  final Function(String, {dynamic data}) onNavigate;
  final Function() onBack;
  final Map<String, dynamic>? cvData;

  const ExplorerContactScreen({
    Key? key,
    required this.onNavigate,
    required this.onBack,
    this.cvData,
  }) : super(key: key);

  @override
  _ExplorerContactScreenState createState() => _ExplorerContactScreenState();
}

class _ExplorerContactScreenState extends State<ExplorerContactScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final List<String> _additionalContacts = [];
  bool _useRegistrationEmail = false;
  String? _registrationEmail;

  @override
  void initState() {
    super.initState();
    
    // Obtener el email de registro si existe
    if (widget.cvData != null && widget.cvData!.containsKey('userEmail')) {
      _registrationEmail = widget.cvData!['userEmail'];
    }
    
    // Cargar datos de contacto si existen
    if (widget.cvData != null) {
      if (widget.cvData!.containsKey('contactEmail')) {
        _emailController.text = widget.cvData!['contactEmail'];
      }
      
      if (widget.cvData!.containsKey('contactPhone')) {
        _phoneController.text = widget.cvData!['contactPhone'];
      }
      
      if (widget.cvData!.containsKey('additionalContacts')) {
        _additionalContacts.addAll(
          (widget.cvData!['additionalContacts'] as List<dynamic>).cast<String>()
        );
      }
      
      if (widget.cvData!.containsKey('useRegistrationEmail')) {
        _useRegistrationEmail = widget.cvData!['useRegistrationEmail'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE), // Fondo gris claro
      body: SafeArea(
        child: Column(
          children: [
            // Header with logo and navigation buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: widget.onBack,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  
                  // Logo
                  const Text(
                    'Logo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  // Close button
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: widget.onBack,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      
                      // Title
                      const Text(
                        '¡Estás a punto de ser un Explorador de empleos!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Subtitle
                      Text(
                        'Ya completaste todos tus datos, pero ahora te vamos a pedir, que ingreses tus medios de contacto.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          height: 1.4,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Use registration email checkbox
                      if (_registrationEmail != null)
                        Row(
                          children: [
                            Checkbox(
                              value: _useRegistrationEmail,
                              onChanged: (value) {
                                setState(() {
                                  _useRegistrationEmail = value ?? false;
                                  if (_useRegistrationEmail) {
                                    _emailController.text = _registrationEmail!;
                                  } else {
                                    _emailController.clear();
                                  }
                                });
                              },
                              fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.black;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Quiero utilizar mail de registro',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      
                      const SizedBox(height: 16),
                      
                      // Email input
                      Text(
                        'Agregar mail de contacto:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey[400]!),
                        ),
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Phone input
                      Text(
                        'Agregar celular de contacto:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey[400]!),
                        ),
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Additional contacts
                      ..._additionalContacts.asMap().entries.map((entry) {
                        final index = entry.key;
                        final contact = entry.value;
                        return _buildAdditionalContactField(index, contact);
                      }),
                      
                      // Add another contact button
                      TextButton.icon(
                        onPressed: _addContact,
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text('Quiero agregar otro más'),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Activate button - Cambiado el texto del botón
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateAndContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Activarme como Explorador de empleos',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalContactField(int index, String initialValue) {
    final TextEditingController controller = TextEditingController(text: initialValue);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Contacto adicional ${index + 1}:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 20),
              onPressed: () => _removeContact(index),
              color: Colors.red[700],
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: TextField(
            controller: controller,
            onChanged: (value) {
              _additionalContacts[index] = value;
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _addContact() {
    setState(() {
      _additionalContacts.add('');
    });
  }

  void _removeContact(int index) {
    setState(() {
      _additionalContacts.removeAt(index);
    });
  }

  void _validateAndContinue() {
    // Validar que al menos haya un método de contacto
    if (_emailController.text.isEmpty && _phoneController.text.isEmpty && _additionalContacts.isEmpty) {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, ingresa al menos un método de contacto.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    // Actualizar el mapa de datos del CV
    final Map<String, dynamic> updatedCvData = widget.cvData != null 
        ? Map<String, dynamic>.from(widget.cvData!)
        : {};
    
    updatedCvData['contactEmail'] = _emailController.text;
    updatedCvData['contactPhone'] = _phoneController.text;
    updatedCvData['additionalContacts'] = _additionalContacts;
    updatedCvData['useRegistrationEmail'] = _useRegistrationEmail;
    
    // Navegar a la pantalla de activación (image_3)
    widget.onNavigate('explorer_upload_activation', data: updatedCvData);
  }
}

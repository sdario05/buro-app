import 'package:buro_app/features/modes/explorer/contact/presentation/widget/save_button_states.dart';
import 'package:flutter/material.dart';

class ExplorerContactScreenContent extends StatefulWidget {
  final Function(String) onNavigate;
  final Function() onBack;

  const ExplorerContactScreenContent({
    Key? key,
    required this.onNavigate,
    required this.onBack,
  }) : super(key: key);

  @override
  _ExplorerContactScreenContentState createState() => _ExplorerContactScreenContentState();
}

class _ExplorerContactScreenContentState extends State<ExplorerContactScreenContent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final List<String> _additionalContacts = [];

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
            SaveButtonStates(
              email: _emailController,
              phone: _phoneController,
              additional: _additionalContacts,
              onSaveSuccess: () {
                widget.onNavigate('explorer_upload_activation');
              }
            )
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
}

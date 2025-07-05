import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final Function(String) onNavigate;

  const RegisterScreen({Key? key, required this.onNavigate}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with logo and back button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'Logo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => widget.onNavigate('onboarding'),
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          if (_currentStep > 1) {
                            setState(() {
                              _currentStep--;
                            });
                          } else {
                            widget.onNavigate('onboarding');
                          }
                        },
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Progress indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentStep == index + 1 ? Colors.black : Colors.grey[300],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Title
              Text(
                'Registrate',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),

              // Subtitle based on current step
              Text(
                _getSubtitleForStep(_currentStep),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24),

              // Form content based on current step
              Expanded(
                child: _buildStepContent(_currentStep),
              ),

              // Continue button
              ElevatedButton(
                onPressed: () {
                  if (_currentStep < 4) {
                    setState(() {
                      _currentStep++;
                    });
                  } else {
                    // Navigate to already registered screen for demo purposes
                    widget.onNavigate('alreadyRegistered');
                  }
                },
                child: Text(_currentStep == 4 ? 'Activar cuenta' : 'Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSubtitleForStep(int step) {
    switch (step) {
      case 1:
        return 'Te vamos a pedir algunos datos:';
      case 2:
        return 'Esta información es necesaria para validar tu cuenta:';
      case 3:
        return 'Con estos datos vas a ingresar a tu cuenta:';
      case 4:
        return 'Antes de continuar, te recomendamos revisar si ingresaste tus datos correctamente:';
      default:
        return '';
    }
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 1:
        return _buildStep1Content();
      case 2:
        return _buildStep2Content();
      case 3:
        return _buildStep3Content();
      case 4:
        return _buildStep4Content();
      default:
        return Container();
    }
  }

  Widget _buildStep1Content() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField('Ingresar Nombre/s', 'Ingresa tu nombre'),
          SizedBox(height: 16),
          _buildFormField('Ingresar Apellido/s', 'Ingresa tu apellido'),
          SizedBox(height: 16),
          _buildDropdownField('Ingresar Género', 'Selecciona tu género', [
            'Femenino',
            'Masculino',
            'No binario',
            'Trans',
          ]),
        ],
      ),
    );
  }

  Widget _buildStep2Content() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField('Ingresar Fecha de nacimiento', 'dd/mm/aaaa'),
          SizedBox(height: 16),
          _buildFormField('Ingresar Nacionalidad', 'Ingresa tu nacionalidad'),
          SizedBox(height: 16),
          _buildFormField('Ingresar Nro de DNI', 'Ingresa tu número de DNI', keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  Widget _buildStep3Content() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField('Ingresar Mail', 'Ingresa tu correo electrónico', keyboardType: TextInputType.emailAddress),
          SizedBox(height: 16),
          _buildPasswordField('Crear Contraseña', 'Ingresa una contraseña'),
          SizedBox(height: 4),
          Text(
            'La contraseña debe tener al menos una mayúscula y caracteres alfanuméricos',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 16),
          _buildPasswordField('Repetir Contraseña', 'Repite tu contraseña'),
        ],
      ),
    );
  }

  Widget _buildStep4Content() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummarySection(
            'Datos personales',
            [
              {'label': 'Nombre y apellido', 'value': 'Juan Pérez'},
              {'label': 'Género', 'value': 'Masculino'},
            ],
            onEdit: () => setState(() => _currentStep = 1),
          ),
          SizedBox(height: 16),
          _buildSummarySection(
            'Datos de identificación',
            [
              {'label': 'Fecha de Nacimiento', 'value': '01/01/1990'},
              {'label': 'Nacionalidad', 'value': 'Argentina'},
              {'label': 'DNI', 'value': '12345678'},
            ],
            onEdit: () => setState(() => _currentStep = 2),
          ),
          SizedBox(height: 16),
          _buildSummarySection(
            'Datos de acceso',
            [
              {'label': 'Mail', 'value': 'juan.perez@example.com'},
              {'label': 'Contraseña', 'value': '••••••••'},
            ],
            onEdit: () => setState(() => _currentStep = 3),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: Icon(Icons.visibility_off),
          ),
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String hint, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: InputBorder.none,
            ),
            hint: Text(hint),
            items: options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {},
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(String title, List<Map<String, String>> items, {required Function onEdit}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton.icon(
                onPressed: () => onEdit(),
                icon: Icon(Icons.edit, size: 14),
                label: Text(
                  'Editar',
                  style: TextStyle(fontSize: 14),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['label']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      item['value']!,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              )).toList(),
        ],
      ),
    );
  }
}

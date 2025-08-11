import 'package:buro_app/features/modes/explorer/profession/presentation/widget/save_button_states.dart';
import 'package:flutter/material.dart';

class ExplorerProfessionScreenContent extends StatefulWidget {
  final Function(String, {dynamic data}) onNavigate;
  final Function() onBack;

  const ExplorerProfessionScreenContent({
    Key? key,
    required this.onNavigate,
    required this.onBack,
  }) : super(key: key);

  @override
  _ExplorerProfessionScreenContentState createState() => _ExplorerProfessionScreenContentState();
}

class _ExplorerProfessionScreenContentState extends State<ExplorerProfessionScreenContent> {
  final List<ProfessionEntry> _professions = [ProfessionEntry(profession: '', isReady: false)];

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
                        '¡Ya casi! Nos faltan solo dos pasos:',
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
                        'Ahora te vamos a pedir que ingreses tu profesión o rubro profesional. Tené en cuenta que para comenzar a tener propuestas tenés que tener marcada la opción: "Listo para conseguir trabajo".',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          height: 1.4,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Profession entries
                      ...List.generate(_professions.length, (index) {
                        return _buildProfessionEntry(index);
                      }),
                      
                      // Add another profession button
                      TextButton.icon(
                        onPressed: _addProfession,
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text('Quiero agregar otra profesión más'),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),

            // Continue button
            SaveButtonStates(
              professions: _professions,
              onSaveSuccess: (professions) {
                widget.onNavigate('explorer_confirmation', data: professions);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionEntry(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'Ingresá tu profesión',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 4),
        
        // Example text
        Text(
          'Ej. Electricista, vendedor, peluquero, etc...',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        
        // Profession input and checkbox
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profession input
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _professions[index].profession = value;
                    });
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Ready for work checkbox
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '¡Listo para\nconseguir trabajo!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[800],
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Checkbox(
                    value: _professions[index].isReady,
                    onChanged: (value) {
                      setState(() {
                        _professions[index].isReady = value ?? false;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.black;
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        
        // Remove button (only show for additional professions)
        if (index > 0)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _removeProfession(index),
              child: Text(
                'Eliminar',
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 12,
                ),
              ),
            ),
          ),
        
        const SizedBox(height: 16),
      ],
    );
  }

  void _addProfession() {
    setState(() {
      _professions.add(ProfessionEntry(profession: '', isReady: false));
    });
  }

  void _removeProfession(int index) {
    setState(() {
      _professions.removeAt(index);
    });
  }
}

class ProfessionEntry {
  String profession;
  bool isReady;

  ProfessionEntry({
    required this.profession,
    required this.isReady,
  });

  Map<String, dynamic> toJson() {
    return {
      'profession': profession,
      'isReady': isReady,
    };
  }

  @override
  String toString() {
    return '$profession (${isReady ? 'Listo' : 'No listo'})';
  }
}

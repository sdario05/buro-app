class JobListing {
  final String id;
  final String name;
  final String title;
  final String type; // 'generator' (ofrece empleo) o 'explorer' (busca empleo)
  final String description;
  
  // Campos específicos para generadores (ofrecen empleo)
  final String? location;
  final String? salary;
  
  // Campos específicos para exploradores (buscan empleo)
  final String? experience;
  final String? availability;

  JobListing({
    required this.id,
    required this.name,
    required this.title,
    required this.type,
    required this.description,
    this.location,
    this.salary,
    this.experience,
    this.availability,
  });
  
  // Método para identificar si es un generador (ofrece empleo)
  bool get isGenerator => type == 'generator';
  
  // Método para identificar si es un explorador (busca empleo)
  bool get isExplorer => type == 'explorer';
}

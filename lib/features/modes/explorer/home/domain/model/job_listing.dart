class JobListing {
  final String? id;
  final String? name;
  final String? title;
  final String? type; // 'generator' (ofrece empleo) o 'explorer' (busca empleo)
  final String? description;
  
  // Campos específicos para generadores (ofrecen empleo)
  final String? location;
  final String? salary;
  
  // Campos específicos para exploradores (buscan empleo)
  final String? experience;
  final String? availability;

  JobListing({
    this.id,
    this.name,
    this.title,
    this.type,
    this.description,
    this.location,
    this.salary,
    this.experience,
    this.availability,
  });

  factory JobListing.fromJson(Map<String, dynamic> json) {
    return JobListing(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      type: json['type'],
      description: json['description'],
      location: json['location'],
      salary: json['salary'],
      experience: json['experience'],
      availability: json['availability'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'title': title,
    'type': type,
    'description': description,
    'location': location,
    'salary': salary,
    'experience': experience,
    'availability': availability,
  };
  
  // Método para identificar si es un generador (ofrece empleo)
  bool get isGenerator => type == 'generator';
  
  // Método para identificar si es un explorador (busca empleo)
  bool get isExplorer => type == 'explorer';
}
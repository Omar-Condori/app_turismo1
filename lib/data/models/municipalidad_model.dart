class MunicipalidadModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String redFacebook;
  final String redInstagram;
  final String redYoutube;
  final String coordenadasX;
  final String coordenadasY;
  final String frase;
  final String comunidades;
  final String historiaFamilias;
  final String historiaCapachica;
  final String comite;
  final String mision;
  final String vision;
  final String valores;
  final String ordenanzaMunicipal;
  final String alianzas;
  final String correo;
  final String horarioDeAtencion;
  final List<dynamic> slidersPrincipales;
  final List<dynamic> slidersSecundarios;
  final String fotoBienvenida;
  final String fotoHistoria;
  final String fotoComunidades;

  MunicipalidadModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.redFacebook,
    required this.redInstagram,
    required this.redYoutube,
    required this.coordenadasX,
    required this.coordenadasY,
    required this.frase,
    required this.comunidades,
    required this.historiaFamilias,
    required this.historiaCapachica,
    required this.comite,
    required this.mision,
    required this.vision,
    required this.valores,
    required this.ordenanzaMunicipal,
    required this.alianzas,
    required this.correo,
    required this.horarioDeAtencion,
    required this.slidersPrincipales,
    required this.slidersSecundarios,
    required this.fotoBienvenida,
    required this.fotoHistoria,
    required this.fotoComunidades,
  });

  factory MunicipalidadModel.fromJson(Map<String, dynamic> json) {
    return MunicipalidadModel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      redFacebook: json['red_facebook'],
      redInstagram: json['red_instagram'],
      redYoutube: json['red_youtube'],
      coordenadasX: json['coordenadas_x'],
      coordenadasY: json['coordenadas_y'],
      frase: json['frase'],
      comunidades: json['comunidades'],
      historiaFamilias: json['historiafamilias'],
      historiaCapachica: json['historiacapachica'],
      comite: json['comite'],
      mision: json['mision'],
      vision: json['vision'],
      valores: json['valores'],
      ordenanzaMunicipal: json['ordenanzamunicipal'],
      alianzas: json['alianzas'],
      correo: json['correo'],
      horarioDeAtencion: json['horariodeatencion'],
      slidersPrincipales: json['sliders_principales'] ?? [],
      slidersSecundarios: json['sliders_secundarios'] ?? [],
      fotoBienvenida: json['foto_bienvenida'] ?? '',
      fotoHistoria: json['foto_historia'] ?? '',
      fotoComunidades: json['foto_comunidades'] ?? '',
    );
  }
} 
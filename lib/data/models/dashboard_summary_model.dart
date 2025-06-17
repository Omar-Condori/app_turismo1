class DashboardSummaryModel {
  final int totalEmprendimientos;
  final int totalServicios;
  final int totalEventos;
  final int totalUsuarios;
  final List<Map<String, dynamic>> ultimosEmprendimientos;
  final List<Map<String, dynamic>> ultimosServicios;
  final List<Map<String, dynamic>> proximosEventos;

  DashboardSummaryModel({
    required this.totalEmprendimientos,
    required this.totalServicios,
    required this.totalEventos,
    required this.totalUsuarios,
    required this.ultimosEmprendimientos,
    required this.ultimosServicios,
    required this.proximosEventos,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryModel(
      totalEmprendimientos: json['total_emprendimientos'] ?? 0,
      totalServicios: json['total_servicios'] ?? 0,
      totalEventos: json['total_eventos'] ?? 0,
      totalUsuarios: json['total_usuarios'] ?? 0,
      ultimosEmprendimientos: List<Map<String, dynamic>>.from(json['ultimos_emprendimientos'] ?? []),
      ultimosServicios: List<Map<String, dynamic>>.from(json['ultimos_servicios'] ?? []),
      proximosEventos: List<Map<String, dynamic>>.from(json['proximos_eventos'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_emprendimientos': totalEmprendimientos,
      'total_servicios': totalServicios,
      'total_eventos': totalEventos,
      'total_usuarios': totalUsuarios,
      'ultimos_emprendimientos': ultimosEmprendimientos,
      'ultimos_servicios': ultimosServicios,
      'proximos_eventos': proximosEventos,
    };
  }
} 
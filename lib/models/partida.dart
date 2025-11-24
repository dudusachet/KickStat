class Partida {
  final int? id;
  final String data;
  final int timeCasaId;
  final int timeForaId;
  final int? placarCasa;
  final int? placarFora;
  final String? local;

  Partida({
    this.id,
    required this.data,
    required this.timeCasaId,
    required this.timeForaId,
    this.placarCasa,
    this.placarFora,
    this.local,
  });

  // Converte um Map (do SQLite) para um objeto Partida
  factory Partida.fromMap(Map<String, dynamic> map) {
    return Partida(
      id: map['id'],
      data: map['data'],
      timeCasaId: map['time_casa_id'],
      timeForaId: map['time_fora_id'],
      placarCasa: map['placar_casa'],
      placarFora: map['placar_fora'],
      local: map['local'],
    );
  }

  // Converte um objeto Partida para um Map (para o SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'time_casa_id': timeCasaId,
      'time_fora_id': timeForaId,
      'placar_casa': placarCasa,
      'placar_fora': placarFora,
      'local': local,
    };
  }
}

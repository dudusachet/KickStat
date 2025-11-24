class Estatistica {
  final int? id;
  final int jogadorId;
  final String? temporada;
  final int gols;
  final int assistencias;
  final int minutosJogados;
  final int cartoesAmarelos;
  final int cartoesVermelhos;
  final int partidaId;

  Estatistica({
    this.id,
    required this.jogadorId,
    this.temporada,
    this.gols = 0,
    this.assistencias = 0,
    this.minutosJogados = 0,
    this.cartoesAmarelos = 0,
    this.cartoesVermelhos = 0,
    required this.partidaId,
  });

  // Converte um Map (do SQLite) para um objeto Estatistica
  factory Estatistica.fromMap(Map<String, dynamic> map) {
    return Estatistica(
      id: map['id'],
      jogadorId: map['jogador_id'],
      temporada: map['temporada'],
      gols: map['gols'] ?? 0,
      assistencias: map['assistencias'] ?? 0,
      minutosJogados: map['minutos_jogados'] ?? 0,
      cartoesAmarelos: map['cartoes_amarelos'] ?? 0,
      cartoesVermelhos: map['cartoes_vermelhos'] ?? 0,
      partidaId: map['partida_id'],
    );
  }

  // Converte um objeto Estatistica para um Map (para o SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jogador_id': jogadorId,
      'temporada': temporada,
      'gols': gols,
      'assistencias': assistencias,
      'minutos_jogados': minutosJogados,
      'cartoes_amarelos': cartoesAmarelos,
      'cartoes_vermelhos': cartoesVermelhos,
      'partida_id': partidaId,
    };
  }
}

class Jogador {
  final int? id;
  final String nome;
  final int? idade;
  final String? posicao;
  final double? altura;
  final double? peso;
  final int timeId;

  Jogador({
    this.id,
    required this.nome,
    this.idade,
    this.posicao,
    this.altura,
    this.peso,
    required this.timeId,
  });

  // Converte um Map (do SQLite) para um objeto Jogador
  factory Jogador.fromMap(Map<String, dynamic> map) {
    return Jogador(
      id: map['id'],
      nome: map['nome'],
      idade: map['idade'],
      posicao: map['posicao'],
      altura: map['altura']?.toDouble(),
      peso: map['peso']?.toDouble(),
      timeId: map['time_id'],
    );
  }

  // Converte um objeto Jogador para um Map (para o SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'posicao': posicao,
      'altura': altura,
      'peso': peso,
      'time_id': timeId,
    };
  }
}

class Time {
  final int? id;
  final String nome;
  final String? estado;
  final String? liga;
  final int? anoFundacao;

  Time({
    this.id,
    required this.nome,
    this.estado,
    this.liga,
    this.anoFundacao,
  });

  // Converte um Map (do SQLite) para um objeto Time
  factory Time.fromMap(Map<String, dynamic> map) {
    return Time(
      id: map['id'],
      nome: map['nome'],
      estado: map['estado'],
      liga: map['liga'],
      anoFundacao: map['ano_fundacao'],
    );
  }

  // Converte um objeto Time para um Map (para o SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'estado': estado,
      'liga': liga,
      'ano_fundacao': anoFundacao,
    };
  }
}

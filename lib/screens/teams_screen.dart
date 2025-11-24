import 'package:flutter/material.dart';
import 'package:kickstat/models/time.dart';
import 'package:kickstat/services/database_service.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Time> _times = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTeams();
  }

  Future<void> _loadTeams() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final List<Map<String, dynamic>> maps = await _dbService.query('Times');
      _times = List.generate(maps.length, (i) {
        return Time.fromMap(maps[i]);
      });
    } catch (e) {
      // Em um app real, logar o erro e mostrar uma mensagem amigável
      // ignore: avoid_print
      print('Erro ao carregar times: \$e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addOrEditTeam({Time? team}) async {
    final result = await showDialog<Time>(
      context: context,
      builder: (context) => TeamFormDialog(team: team),
    );

    if (result != null) {
      if (result.id == null) {
        // Adicionar
        await _dbService.insert('Times', result.toMap());
      } else {
        // Editar
        await _dbService.update('Times', result.toMap(), where: 'id = ?', whereArgs: [result.id]);
      }
      _loadTeams();
    }
  }

  Future<void> _deleteTeam(int id) async {
    await _dbService.delete('Times', where: 'id = ?', whereArgs: [id]);
    _loadTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Times'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _times.isEmpty
              ? const Center(child: Text('Nenhum time cadastrado. Adicione um!'))
              : ListView.builder(
                  itemCount: _times.length,
                  itemBuilder: (context, index) {
                    final team = _times[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: const Icon(Icons.group),
                        title: Text(team.nome),
                        subtitle: Text("${team.liga ?? 'Sem Liga'} - ${team.estado ?? 'BR'}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _addOrEditTeam(team: team),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTeam(team.id!),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditTeam(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TeamFormDialog extends StatefulWidget {
  final Time? team;
  const TeamFormDialog({super.key, this.team});

  @override
  State<TeamFormDialog> createState() => _TeamFormDialogState();
}

class _TeamFormDialogState extends State<TeamFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _estadoController;
  late TextEditingController _ligaController;
  late TextEditingController _anoFundacaoController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.team?.nome ?? '');
    _estadoController = TextEditingController(text: widget.team?.estado ?? '');
    _ligaController = TextEditingController(text: widget.team?.liga ?? '');
    _anoFundacaoController = TextEditingController(text: widget.team?.anoFundacao?.toString() ?? '');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _estadoController.dispose();
    _ligaController.dispose();
    _anoFundacaoController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final newTeam = Time(
        id: widget.team?.id,
        nome: _nomeController.text,
        estado: _estadoController.text.isEmpty ? null : _estadoController.text,
        liga: _ligaController.text.isEmpty ? null : _ligaController.text,
        anoFundacao: int.tryParse(_anoFundacaoController.text),
      );
      Navigator.of(context).pop(newTeam);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.team == null ? 'Novo Time' : 'Editar Time'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome do Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _estadoController,
                decoration: const InputDecoration(labelText: 'Estado (Opcional)'),
              ),
              TextFormField(
                controller: _ligaController,
                decoration: const InputDecoration(labelText: 'Liga (Opcional)'),
              ),
              TextFormField(
                controller: _anoFundacaoController,
                decoration: const InputDecoration(labelText: 'Ano de Fundação (Opcional)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}

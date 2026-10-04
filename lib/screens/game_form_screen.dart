import 'package:flutter/material.dart';

import '../models/game.dart';
import '../theme/app_theme.dart';

/// Formulário usado tanto para criar (game == null) quanto para editar.
class GameFormScreen extends StatefulWidget {
  final Game? game;

  const GameFormScreen({super.key, this.game});

  @override
  State<GameFormScreen> createState() => _GameFormScreenState();
}

class _GameFormScreenState extends State<GameFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.game?.name);
  late final _genreController = TextEditingController(text: widget.game?.genre);
  late final _platformController =
      TextEditingController(text: widget.game?.platform);
  late final _ratingController = TextEditingController(
      text: widget.game == null ? '' : widget.game!.rating.toString());
  late final _descriptionController =
      TextEditingController(text: widget.game?.description);

  bool get _isEditing => widget.game != null;

  @override
  void dispose() {
    _nameController.dispose();
    _genreController.dispose();
    _platformController.dispose();
    _ratingController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _required(String? value, String message) =>
      (value == null || value.trim().isEmpty) ? message : null;

  double? _parseRating(String? value) =>
      double.tryParse((value ?? '').trim().replaceAll(',', '.'));

  String? _validateRating(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe a nota do jogo';
    final rating = _parseRating(value);
    if (rating == null) return 'Nota inválida: digite apenas números';
    if (rating < 0 || rating > 10) return 'A nota deve estar entre 0 e 10';
    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final genre = _genreController.text.trim();
    final platform = _platformController.text.trim();
    final rating = _parseRating(_ratingController.text)!;
    final description = _descriptionController.text.trim();

    final Game result = _isEditing
        ? widget.game!.copyWith(
            name: name,
            genre: genre,
            platform: platform,
            rating: rating,
            description: description,
          )
        : Game(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            name: name,
            genre: genre,
            platform: platform,
            rating: rating,
            description: description,
          );

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: AppTheme.spacing);

    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Editar jogo' : 'Novo jogo')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacing),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: 'Nome', prefixIcon: Icon(Icons.title)),
                    validator: (v) => _required(v, 'Informe o nome do jogo'),
                  ),
                  gap,
                  TextFormField(
                    controller: _genreController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: 'Gênero', prefixIcon: Icon(Icons.category)),
                    validator: (v) => _required(v, 'Informe o gênero do jogo'),
                  ),
                  gap,
                  TextFormField(
                    controller: _platformController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: 'Plataforma', prefixIcon: Icon(Icons.devices)),
                    validator: (v) =>
                        _required(v, 'Informe a plataforma do jogo'),
                  ),
                  gap,
                  TextFormField(
                    controller: _ratingController,
                    textInputAction: TextInputAction.next,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        labelText: 'Nota (0 a 10)',
                        prefixIcon: Icon(Icons.star)),
                    validator: _validateRating,
                  ),
                  gap,
                  TextFormField(
                    controller: _descriptionController,
                    minLines: 3,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        labelText: 'Descrição',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.notes)),
                    validator: (v) {
                      final text = (v ?? '').trim();
                      if (text.isEmpty) return 'Informe uma descrição';
                      if (text.length < 5) {
                        return 'A descrição deve ter ao menos 5 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppTheme.spacing * 1.5),
                  Semantics(
                    button: true,
                    label: _isEditing ? 'Salvar alterações' : 'Salvar jogo',
                    excludeSemantics: true,
                    child: FilledButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

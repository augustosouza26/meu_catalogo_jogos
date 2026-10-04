import 'package:flutter/material.dart';

import '../models/game.dart';
import '../theme/app_theme.dart';
import 'game_form_screen.dart';

class GameDetailScreen extends StatelessWidget {
  final Game game;

  const GameDetailScreen({super.key, required this.game});

  Future<void> _edit(BuildContext context) async {
    final updated = await Navigator.push<Game>(
      context,
      MaterialPageRoute(builder: (_) => GameFormScreen(game: game)),
    );
    if (!context.mounted || updated == null) return;
    // Devolve o jogo editado ao catálogo, que substitui o item pelo id.
    Navigator.pop(context, updated);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do jogo')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(game.name, style: textTheme.headlineMedium),
                const SizedBox(height: AppTheme.spacing),
                _InfoRow(icon: Icons.category, label: 'Gênero', value: game.genre),
                _InfoRow(
                    icon: Icons.devices, label: 'Plataforma', value: game.platform),
                _InfoRow(
                    icon: Icons.star,
                    label: 'Nota',
                    value: '${game.rating.toStringAsFixed(1)} / 10'),
                const SizedBox(height: AppTheme.spacing),
                Text('Descrição', style: textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(game.description, style: textTheme.bodyLarge),
                const SizedBox(height: AppTheme.spacing * 2),
                Semantics(
                  button: true,
                  label: 'Editar ${game.name}',
                  excludeSemantics: true,
                  child: FilledButton.icon(
                    onPressed: () => _edit(context),
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar jogo'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text('$label: ', style: Theme.of(context).textTheme.titleSmall),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

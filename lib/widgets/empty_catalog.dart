import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class EmptyCatalog extends StatelessWidget {
  final VoidCallback onAdd;

  const EmptyCatalog({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing * 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sports_esports, size: 96, color: color),
            const SizedBox(height: AppTheme.spacing),
            Text('Nenhum jogo cadastrado',
                style: textTheme.headlineSmall, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              'Toque no botão abaixo para cadastrar o primeiro jogo da sua coleção.',
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacing * 1.5),
            Semantics(
              button: true,
              label: 'Adicionar o primeiro jogo',
              excludeSemantics: true,
              child: FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar primeiro jogo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/game.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;

  const GameCard({super.key, required this.game, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Abrir detalhes de ${game.name}. ${game.genre}, ${game.platform}. '
          'Nota ${game.rating.toStringAsFixed(1)}',
      excludeSemantics: true,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          minVerticalPadding: 12,
          onTap: onTap,
          leading: const Icon(Icons.videogame_asset),
          title: Text(game.name, maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: Text('${game.genre} • ${game.platform}',
              maxLines: 2, overflow: TextOverflow.ellipsis),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 18),
              const SizedBox(width: 4),
              Text(game.rating.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}

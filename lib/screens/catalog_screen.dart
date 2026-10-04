import 'package:flutter/material.dart';

import '../models/game.dart';
import '../theme/app_theme.dart';
import '../widgets/empty_catalog.dart';
import '../widgets/game_card.dart';
import 'game_detail_screen.dart';
import 'game_form_screen.dart';

class CatalogScreen extends StatefulWidget {
  /// Permite iniciar a coleção com dados (útil em testes). Por padrão, vazia.
  final List<Game> initialGames;

  const CatalogScreen({super.key, this.initialGames = const []});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late final List<Game> _games = List<Game>.of(widget.initialGames);

  Future<void> _addGame() async {
    final created = await Navigator.push<Game>(
      context,
      MaterialPageRoute(builder: (_) => const GameFormScreen()),
    );
    if (!mounted || created == null) return;
    setState(() => _games.add(created));
  }

  Future<void> _openDetails(Game game) async {
    // A tela de detalhes devolve o jogo atualizado caso ele seja editado.
    final updated = await Navigator.push<Game>(
      context,
      MaterialPageRoute(builder: (_) => GameDetailScreen(game: game)),
    );
    if (!mounted || updated == null) return;
    setState(() {
      final index = _games.indexWhere((g) => g.id == updated.id);
      if (index != -1) _games[index] = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Catálogo de Jogos')),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Adicionar jogo',
        onPressed: _addGame,
        icon: const Icon(Icons.add),
        label: const Text('Adicionar jogo'),
      ),
      body: _games.isEmpty
          ? EmptyCatalog(onAdd: _addGame)
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                      AppTheme.spacing, AppTheme.spacing, AppTheme.spacing, 96),
                  itemCount: _games.length,
                  itemBuilder: (context, index) {
                    final game = _games[index];
                    return GameCard(
                      game: game,
                      onTap: () => _openDetails(game),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

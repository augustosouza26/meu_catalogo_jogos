import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meu_catalogo_jogos/screens/catalog_screen.dart';
import 'package:meu_catalogo_jogos/theme/app_theme.dart';

Widget _app() => MaterialApp(theme: AppTheme.light, home: const CatalogScreen());

void main() {
  testWidgets('exibe o estado vazio com ação para adicionar jogo',
      (tester) async {
    await tester.pumpWidget(_app());

    expect(find.text('Nenhum jogo cadastrado'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('Adicionar primeiro jogo'), findsOneWidget);
  });

  testWidgets('formulário vazio mostra erro de validação do nome',
      (tester) async {
    await tester.pumpWidget(_app());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    final saveButton = find.text('Salvar');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pump();

    expect(find.text('Informe o nome do jogo'), findsOneWidget);
  });
}

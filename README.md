# Meu Catálogo de Jogos

Aplicativo Flutter desenvolvido como trabalho final da disciplina **Desenvolvimento Mobile I**.

## Descrição e objetivo

Catálogo pessoal e local de jogos. O objetivo é demonstrar, de forma simples, navegação entre telas, coleção dinâmica com estado vazio, formulário com validação, criação/edição em estado local, Material 3, acessibilidade, responsividade e teste de widget.

Fluxo: **Catálogo → (adicionar) Formulário → Catálogo** e **Catálogo → Detalhes → (editar) Formulário → Catálogo**.

## Funcionalidades

- Visualizar a coleção de jogos (nome, gênero, plataforma, nota)
- Estado vazio ("Nenhum jogo cadastrado") com ação para adicionar
- Adicionar jogo
- Ver detalhes de um jogo
- Editar jogo (localizado por `id`) com atualização imediata da lista
- Validação de formulário (campos obrigatórios; nota numérica entre 0 e 10)

Os dados ficam apenas na memória durante a execução (sem banco, API, Firebase ou persistência).

## Tecnologias

Flutter, Dart, Material 3, `StatefulWidget` + `setState`. Sem dependências externas além de `flutter_lints` (desenvolvimento).

## Estrutura do projeto

```
lib/
  main.dart
  models/game.dart
  screens/
    catalog_screen.dart
    game_detail_screen.dart
    game_form_screen.dart
  widgets/
    game_card.dart
    empty_catalog.dart
  theme/app_theme.dart
test/
  catalog_screen_test.dart
```

## Como executar

Na primeira vez, gere as pastas de plataforma (android etc.) dentro desta pasta:

```
flutter create . --project-name meu_catalogo_jogos --platforms=android
flutter pub get
flutter run
```

## Análise estática e testes

```
flutter analyze
flutter test
```

## Gerar APK

```
flutter build apk
```

O arquivo fica em `build/app/outputs/flutter-apk/app-release.apk`.

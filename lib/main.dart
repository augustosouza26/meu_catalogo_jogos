import 'package:flutter/material.dart';

import 'screens/catalog_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const MeuCatalogoApp());

class MeuCatalogoApp extends StatelessWidget {
  const MeuCatalogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Catálogo de Jogos',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const CatalogScreen(),
    );
  }
}

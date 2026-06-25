// Testa o fluxo do questionário respondendo "Não"/nada a todas as questões.
// Resultado esperado pela Matriz de Risco AR PAX: Muito Baixo (20%).

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:desperte_mulher/main.dart';

void main() {
  testWidgets('respondendo Não/nada a tudo resulta em risco Muito Baixo (20%)', (
    tester,
  ) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Desperte Mulher'), findsOneWidget);

    await tester.tap(find.text('Iniciar questionário anonimamente'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Começar Avaliação'));
    await tester.pumpAndSettle();

    for (var page = 1; page <= 5; page++) {
      final isLastPage = page == 5;
      final advanceButton = find.widgetWithText(
        ElevatedButton,
        isLastPage ? 'Ver Resultado' : 'Avançar',
      );
      await tester.ensureVisible(advanceButton);
      await tester.pumpAndSettle();
      await tester.tap(advanceButton);
      await tester.pumpAndSettle();
    }

    expect(find.text('Grau de Risco'), findsOneWidget);
    expect(find.text('Muito Baixo'), findsOneWidget);
    expect(find.text('20%'), findsOneWidget);
  });
}

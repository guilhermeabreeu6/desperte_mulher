// Testa se o botão "Voltar" preserva a resposta já selecionada ao navegar
// de volta para uma etapa anterior do questionário.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:desperte_mulher/Models/answer.dart';
import 'package:desperte_mulher/main.dart';

void main() {
  testWidgets(
    'resposta da Etapa 1 é preservada ao voltar da Etapa 2 e avançar de novo',
    (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'teste@teste.com');
      await tester.enterText(find.byType(TextFormField).last, 'senha123');
      await tester.tap(find.text('Entrar'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Começar Avaliação'));
      await tester.pumpAndSettle();

      // Responde a primeira opção da primeira questão da Etapa 1.
      final firstQuestion = find.byKey(const ValueKey('page1_question0'));
      final firstRadio = find
          .descendant(
            of: firstQuestion,
            matching: find.byType(RadioListTile<Answer>),
          )
          .first;
      await tester.tap(firstRadio);
      await tester.pumpAndSettle();

      // Avança para a Etapa 2.
      await tester.tap(find.widgetWithText(ElevatedButton, 'Avançar'));
      await tester.pumpAndSettle();
      expect(find.text('Etapa 2 de 5'), findsOneWidget);

      // Volta para a Etapa 1.
      await tester.tap(find.widgetWithText(OutlinedButton, 'Voltar'));
      await tester.pumpAndSettle();
      expect(find.text('Etapa 1 de 5'), findsOneWidget);

      // A primeira opção da primeira questão deve continuar selecionada.
      final radioWidget = tester.widget<RadioListTile<Answer>>(firstRadio);
      final radioGroup = tester.widget<RadioGroup<Answer>>(
        find
            .ancestor(
              of: firstRadio,
              matching: find.byType(RadioGroup<Answer>),
            )
            .first,
      );
      expect(radioGroup.groupValue, equals(radioWidget.value));

      // Avança por todas as demais etapas sem responder mais nada.
      for (var page = 1; page <= 5; page++) {
        final isLastPage = page == 5;
        await tester.tap(
          find.widgetWithText(
            ElevatedButton,
            isLastPage ? 'Ver Resultado' : 'Avançar',
          ),
        );
        await tester.pumpAndSettle();
      }

      // A contribuição da Etapa 1 deve ter sobrevivido à ida e volta.
      expect(find.text('Grau de Risco'), findsOneWidget);
      expect(find.text('0.25'), findsOneWidget); // Vulnerabilidade
      expect(find.text('0.83'), findsOneWidget); // Ameaça
    },
  );
}

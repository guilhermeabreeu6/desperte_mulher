# Desperte Mulher

Aplicativo mobile de avaliação de risco de violência doméstica, baseado na metodologia científica **AR PAX/FRIDA**, desenvolvido em Flutter.

> Desenvolvido por **Guilherme Abreu**

---

## Sumário

- [Sobre o Projeto](#sobre-o-projeto)
- [Metodologia AR PAX/FRIDA](#metodologia-ar-paxfrida)
- [Funcionalidades](#funcionalidades)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Telas](#telas)
- [Algoritmo de Risco](#algoritmo-de-risco)
- [Como Executar](#como-executar)
- [Testes](#testes)
- [Considerações Finais](#considerações-finais)

---

## Sobre o Projeto

O **Desperte Mulher** é um aplicativo Flutter criado para auxiliar mulheres a avaliarem seu nível de risco de violência doméstica de forma estruturada, segura e offline. A ferramenta aplica a metodologia **AR PAX/FRIDA**, utilizada pelo programa Desperte Mulher, replicando fielmente o algoritmo da planilha oficial de avaliação de risco.

O app guia a usuária por um questionário de 5 etapas, calcula o grau de risco com base nas respostas e apresenta um resultado com recomendações personalizadas — incluindo contatos de emergência para situações de risco Alto ou Extremo.

**Nenhum dado é enviado a terceiros.** O aplicativo funciona 100% offline.

---

## Metodologia AR PAX/FRIDA

A metodologia AR PAX/FRIDA avalia o risco de violência doméstica a partir de dois eixos:

| Eixo | Critérios |
|---|---|
| **Vulnerabilidade** | Atratibilidade · Exposição · Casuística |
| **Ameaça** | Motivação · Histórico · Tendência |

O cruzamento dos dois eixos em uma **Matriz de Risco 5×5** resulta em uma das 5 classificações finais:

| Nível | Percentual |
|---|---|
| Muito Baixo | 20% |
| Baixo | 40% |
| Moderado | 60% |
| Alto | 80% |
| Extremo | 100% |

---

## Funcionalidades

- Questionário de 5 etapas com perguntas de escolha única e múltipla
- Algoritmo fiel à planilha oficial AR PAX/FRIDA (pesos, VR e matriz de risco)
- Preservação de respostas ao navegar entre etapas (botão Voltar)
- Resultado com nível de risco, eixos de vulnerabilidade e ameaça, e recomendação personalizada
- Banner de emergência com **Disque 180** e **Disque 190** para riscos Alto e Extremo
- Identidade visual consistente com tema centralizado (Material 3)
- Validação de formulário no login
- Funcionamento 100% offline

---

## Estrutura do Projeto

```
lib/
├── main.dart                         # Ponto de entrada + ThemeData global
├── common/
│   ├── app_routes.dart               # Rotas nomeadas centralizadas
│   └── risk_calculator.dart          # Algoritmo AR PAX/FRIDA
├── Models/
│   ├── answer.dart                   # Entidade de resposta
│   ├── criterion.dart                # Enum dos 6 critérios de risco
│   ├── question.dart                 # Entidade de questão (single/multiple)
│   ├── quiz_page.dart                # Modelo de página do quiz
│   └── risk_result.dart              # Resultado da avaliação + RiskLevel enum
├── login/
│   └── login_page.dart               # Tela de login com validação de formulário
├── profile/
│   └── profile_page.dart             # Tela de perfil do usuário
└── Screens/
    ├── quiz/
    │   ├── quiz_page.dart            # Questionário de 5 etapas com cache de estado
    │   ├── quiz_server.dart          # Carregamento dos JSONs de assets
    │   └── question_widget.dart      # Widget de questão (radio/checkbox)
    ├── registration/
    │   └── register_page.dart        # Tela de cadastro
    └── result/
        └── result_page.dart          # Tela de resultado com nível de risco

assets/
└── Mock/
    ├── page1.json                    # Questões — Etapa 1
    ├── page2.json                    # Questões — Etapa 2
    ├── page3.json                    # Questões — Etapa 3
    ├── page4.json                    # Questões — Etapa 4
    └── page5.json                    # Questões — Etapa 5

test/
├── quiz_back_button_test.dart        # Preservação de estado ao navegar
├── quiz_high_risk_test.dart          # Cenário de risco Extremo (100%)
└── quiz_low_risk_test.dart           # Cenário de risco Muito Baixo (20%)
```

---

## Telas

| Tela | Descrição |
|---|---|
| **Login** | Autenticação com validação de e-mail e senha (mín. 6 caracteres) |
| **Cadastro** | Criação de conta com feedback de sucesso |
| **Aviso** | Orientações sobre a avaliação e privacidade dos dados |
| **Quiz** | Questionário de 5 etapas com barra de progresso e navegação entre etapas |
| **Resultado** | Exibe nível de risco, eixos de vulnerabilidade/ameaça, recomendação e — para risco Alto ou Extremo — banner de emergência |
| **Perfil** | Dados do usuário e opções de conta |

---

## Algoritmo de Risco

O cálculo é realizado pela classe `RiskCalculator` (`lib/common/risk_calculator.dart`) em 6 etapas:

1. **Soma bruta** — conta as respostas afirmativas (`activates: true`) por critério
2. **VR (Valor de Risco)** — converte a soma bruta em um valor de 0 a 5 usando limiares por grupo de critério
3. **FINAL** — multiplica o VR pelo peso do critério (ex.: Motivação × 1,0 · Atratibilidade × 1/3)
4. **Eixos** — soma os 3 critérios de Vulnerabilidade e os 3 de Ameaça separadamente
5. **Nível de eixo** — classifica cada eixo em 5 níveis usando limiares numéricos
6. **Matriz** — cruza os dois eixos em uma matriz 5×5 para obter o risco final

O algoritmo replica fielmente as fórmulas da *Planilha Ajustada.xlsm* do programa Desperte Mulher, validado por simulação independente em Python.

---

## Como Executar

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.41 ou superior
- Dart 3.11 ou superior
- Android Studio ou VS Code com extensão Flutter

### Instalação

```bash
# Clone o repositório
git clone https://github.com/guilhermeabreeu6/troca_contexto.git
cd troca_contexto

# Instale as dependências
flutter pub get

# Execute o app
flutter run
```

### Plataformas suportadas

| Plataforma | Suporte |
|---|---|
| Android | ✅ |
| iOS | ✅ |
| Web | ✅ |
| Windows | ✅ |
| macOS | ✅ |
| Linux | ✅ |

---

## Testes

O projeto conta com 3 testes automatizados de widget, cobrindo os casos críticos do algoritmo:

```bash
flutter test
```

| Teste | O que valida |
|---|---|
| `quiz_low_risk_test` | Responder "Não" a tudo resulta em **Muito Baixo (20%)** |
| `quiz_high_risk_test` | Resposta mais grave em tudo resulta em **Extremo (100%)** |
| `quiz_back_button_test` | Respostas são preservadas ao navegar para etapa anterior |

---

## Considerações Finais

Este projeto foi desenvolvido com o objetivo de tornar a metodologia AR PAX/FRIDA acessível em dispositivos móveis, contribuindo com o trabalho do programa **Desperte Mulher** no enfrentamento à violência doméstica.

Toda decisão técnica foi tomada com foco na segurança e na experiência da usuária: o app não coleta dados, não depende de conexão com a internet e apresenta informações de emergência de forma clara quando o risco identificado é elevado.

**Recursos de emergência:**
- **180** — Central de Atendimento à Mulher
- **190** — Polícia Militar
- **Delegacia da Mulher** — atendimento especializado

---

**Autor:** Guilherme Abreu  
**Linguagem:** Dart · Flutter 3.41  
**Metodologia:** AR PAX/FRIDA — Desperte Mulher

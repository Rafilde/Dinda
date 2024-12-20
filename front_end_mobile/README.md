# Documentação Mobile

## Dependências Utilizadas
O aplicativo mobile utiliza as seguintes dependências no Flutter:

```yaml
cupertino_icons: ^1.0.6
flutter_bloc: ^8.1.6
http: ^1.2.2
google_nav_bar: ^5.0.7
flutter_masked_text2: ^0.9.1
carousel_slider: ^5.0.0
firebase_core: ^3.8.1
cloud_firestore: ^5.5.1
```

### Descrição das Dependências:
- **cupertino_icons**: Ícones no estilo iOS.
- **flutter_bloc**: Gerenciamento de estado reativo.
- **http**: Requisições HTTP para APIs.
- **google_nav_bar**: Barra de navegação personalizável.
- **flutter_masked_text2**: Máscaras para campos de texto, como preços.
- **carousel_slider**: Exibição de carrosséis para imagens e banners.
- **firebase_core**: Integração do aplicativo com o Firebase.
- **cloud_firestore**: Banco de dados em tempo real para salvar doces e pedidos.

---

## Estrutura do Projeto
A estrutura do projeto mobile segue uma arquitetura organizada com o uso do **BLoC** (Business Logic Component) para facilitar o gerenciamento de estado. Entretando, estou usando o Cubit para gerenciamento de estado, que é uma abstração do BLoC.

### Principais Diretórios:
- **lib/features/screen**: Contém os arquivos das telas principais do aplicativo.
- **lib/features/screen/api**: Lida com a comunicação e integrações com APIs externas.
- **lib/features/screen/cubit**: Contém os gerenciadores de estado utilizando o padrão Cubit.
- **lib/features/screen/widgets**: Inclui componentes específicos.
- **lib/shared/widgets**: Armazena widgets compartilhados entre diferentes telas.
- **lib/shared/models**: Modelos e estruturas de dados utilizados globalmente no aplicativo.
- **lib/shared**: Contém arquivos e componentes que são usados em várias partes do aplicativo.

---

## Funcionalidades Mobile Implementadas
- Tela de **Cadastro de Doces**: Adicione novos doces ao catálogo com nome, preço e imagem.
- Tela de **Listagem de Doces**: Visualize os doces cadastrados.
- Tela de **Detalhes do Doce**: Veja informações detalhadas de um doce, como preço e descrição. Ademais, é possível alterar as informações do doce.
- Tela de **Gerenciamento de Pedidos**: Visualize e atualize o status de pedidos realizados.

---

## Configuração do Firebase
Certifique-se de configurar corretamente o Firebase no aplicativo:
1. Crie um projeto no [Firebase Console](https://console.firebase.google.com/).
2. Siga o tutorial para conectar seu aplicativo flutter com firebase. [Tutorial](https://firebase.google.com/docs/flutter/setup?hl=pt-br&platform=ios).
3. Siga o tutorial para adicionar o Firestore ao seu aplicativo. [Tutorial](https://firebase.flutter.dev/docs/firestore/overview/).
---

## Próximos Passos
- Integração do backend para processamento de pedidos e comunicação com o catálogo web.
- Adicionar suporte a notificações push para pedidos atualizados.
- Implementar uma interface para relatórios de vendas e desempenho.

---

Este é apenas o início de um projeto que busca tornar o gerenciamento de um negócio de doces mais eficiente e prático. O aplicativo **Dinda** está sendo desenvolvido com o objetivo de crescer e atender todas as necessidades do negócio.


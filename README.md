# 🌸 Dona Josy

Aplicativo mobile desenvolvido em **Flutter** para a loja **Dona Josy**, com catálogo de cosméticos e marmitas, carrinho de compras e geração de código Pix. O aplicativo conta com autenticação de usuários e funcionalidades administrativas de acordo com o perfil de acesso.

## 📱 Telas do aplicativo

<p align="center">
  <img src="docs/images/login.jpg" alt="Tela de login do Dona Josy" width="260">
  &nbsp;&nbsp;
  <img src="docs/images/catalogo.jpg" alt="Catálogo de produtos do Dona Josy" width="260">
</p>

## ✨ Funcionalidades

- Cadastro e login de usuários.
- Exibição e busca de cosméticos e marmitas.
- Carrinho de compras com filtro por status, paginação e cálculo do total da compra.
- Geração e cópia do código Pix.
- Área administrativa para cadastrar, editar, ativar e inativar produtos.
- Atualização do status dos pedidos.
- Notificações dentro do aplicativo.
- Carregamento das imagens dos produtos a partir das URLs retornadas pela API.
- Controle de acesso às funcionalidades administrativas conforme o perfil do usuário.

## 🛠️ Tecnologias

- **Flutter** — desenvolvimento multiplataforma.
- **Dart** — linguagem de programação.
- **MobX** — gerenciamento de estado.
- **Provider** — disponibilização das stores na aplicação.
- **API REST** — comunicação com o backend.
- **Autenticação por token** — acesso autenticado aos endpoints protegidos.

## ⚙️ Configuração do ambiente

### Pré-requisitos

Antes de começar, instale e configure:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart](https://dart.dev/get-dart) (incluído na instalação do Flutter)
- [Android Studio](https://developer.android.com/studio) ou outro ambiente compatível
- Um emulador Android ou dispositivo físico conectado
- Acesso à API do Dona Josy

Verifique a instalação do Flutter:

```bash
flutter doctor
```

### Variáveis de ambiente

O aplicativo carrega as URLs da API por meio do arquivo `.env`, incluído nos assets do Flutter.

Exemplo de configuração:

```ini
API_BASE_URL=http://127.0.0.1:8080/api/v1
```

- `API_BASE_URL`: endereço base da API da loja.
- `ASSISTANT_API_BASE_URL`: endpoint do assistente.

Ajuste os valores conforme o ambiente utilizado. Confirme também que o arquivo `.env` está declarado corretamente na configuração de assets do `pubspec.yaml`.

> **Atenção:** arquivos incluídos como assets podem ser extraídos do aplicativo compilado. Utilize essas variáveis somente para configurações públicas. Não armazene senhas, tokens privados, chaves secretas ou outras credenciais no `.env` do aplicativo.

## 🚀 Instalação e execução

Clone o repositório:

```bash
git clone <URL_DO_REPOSITORIO>
cd <PASTA_DO_PROJETO>
```

Instale as dependências:

```bash
flutter pub get
```

Execute o aplicativo em um emulador ou dispositivo conectado:

```bash
flutter run
```

Para gerar um APK de depuração:

```bash
flutter build apk --debug
```

O arquivo gerado normalmente fica em:

```text
build/app/outputs/flutter-apk/app-debug.apk
```

## 👥 Perfis de acesso

### `USER`

- Consultar e pesquisar produtos.
- Adicionar itens ao carrinho.
- Acompanhar o status dos pedidos.
- Gerar e copiar o código Pix.

### `ADMIN`

- Cadastrar e editar cosméticos e marmitas.
- Ativar ou inativar produtos.
- Consultar pedidos.
- Atualizar o status dos pedidos.

O acesso administrativo depende do perfil atribuído ao usuário pela aplicação/API.

## 📂 Estrutura principal

```text
lib/
├── pages/          # Telas do aplicativo
├── components/     # Componentes reutilizáveis
├── store/          # Estado e operações das telas
├── services/
│   └── api/        # Integração com os endpoints da API
├── models/         # Modelos de dados
└── config/
    └── app_env.dart # Carregamento da configuração do ambiente

assets/
└── images/         # Imagens locais do aplicativo

mocks/              # Dados de exemplo
```

## 🔒 Segurança

- Não publique credenciais, senhas ou tokens.
- Não coloque segredos de autenticação no `.env` incluído no aplicativo.
- Mantenha a validação de autenticação e de permissões na API, além dos controles de interface no Flutter.

---

<img width="718" height="1599" alt="WhatsApp Image 2026-10-17 at 13 32 54" src="https://github.com/user-attachments/assets/ee4249cc-5425-48a6-a3ed-f77bd9b30098" />

<img width="718" height="1599" alt="WhatsApp Image 2026-10-17 at 13 32 54 (1)" src="https://github.com/user-attachments/assets/14ef5740-c189-44b3-9e3c-65f430973f81" />

<img width="718" height="1599" alt="WhatsApp Image 2026-10-17 at 13 32 54 (2)" src="https://github.com/user-attachments/assets/fa2043a7-d848-4b54-b10a-a042fb137432" />

<img width="718" height="1599" alt="WhatsApp Image 2026-10-17 at 13 32 55" src="https://github.com/user-attachments/assets/925109bd-e45f-4342-be3e-a0bea5b92c7a" />

<img width="718" height="1599" alt="WhatsApp Image 2026-10-17 at 13 32 55 (1)" src="https://github.com/user-attachments/assets/e9cdb2a3-e6f3-4b06-9fac-1669ca5c7c11" />

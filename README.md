# 🗳️ ApurAqui

Aplicativo mobile desenvolvido para facilitar o acompanhamento das eleições em tempo real, promovendo transparência e combate à desinformação.

Projeto acadêmico da disciplina de **Desenvolvimento Mobile** do **UNIPÊ**, ministrada pelo professor **Leandro Melo** (turno noite).

---

## 🚀 Objetivo

O **ApurAqui** tem como objetivo fornecer uma experiência rápida, clara e confiável para que eleitores acompanhem resultados eleitorais, acessem informações sobre candidatos e se preparem melhor para o dia da votação.

---

## ✨ Funcionalidades

### 📊 Acompanhamento de Resultados
- Linha do tempo da apuração em tempo real  
- Sistema de favoritos para estados e cidades  
- Notificações de mudanças no ranking eleitoral  

### 👤 Informações do Candidato
- Perfil completo com “santinho digital”  
- Comparador de propostas entre candidatos  

### 🗳️ Utilidade no Dia da Votação
- Localização do local de votação  
- Checklist de documentos necessários  
- Monitor colaborativo de tempo de fila  

### 🔍 Transparência e Informação
- Central de verificação de fake news  
- Agregador de notícias confiáveis  

---

## 🛠️ Tecnologias Utilizadas

- **Framework:** Flutter  
- **Linguagem:** Dart  
- **Integrações:**
  - APIs públicas (ex: TSE) *(planejado)*  
  - Dados locais em JSON *(para simulação)*  

---

## 🧱 Estrutura do Projeto (sugestão)
lib/
├── core/ # Configurações globais
├── features/ # Funcionalidades (modularizado)
│ ├── home/
│ ├── candidatos/
│ ├── resultados/
│ └── votacao/
├── services/ # APIs, mocks e integrações
├── models/ # Modelos de dados
└── main.dart


---

## 👥 Equipe

### 📌 Organização do Projeto

- **Francisco Serafim da Silva (Líder)**  
  - Configuração do projeto  
  - Sistema de notificações  
  - Gerenciamento do repositório  

- **Handrey Kaleu Matias Souza de Carvalho**  
  - Desenvolvimento de telas  
  - Linha do tempo de apuração  
  - Sistema de favoritos  
  - Monitor de tempo de fila  

- **Rafael Luna de Souza**  
  - Tela de perfil e santinho digital  
  - Comparador de propostas  
  - Localização do local de votação  
  - Checklist de documentos  
  - Central de fake news  

---

## 📦 Como Executar o Projeto

1. Clone o repositório:
```bash
git clone https://github.com/Giyuulol/apuraqui.git

2. Acesse a pasta do projeto:
cd apuraqui

3. Instale as dependências:
flutter pub get

4. Execute o app:
flutter run
# Drift and Riverpod Local Persistence Design

## Goal

Persist the current mobile prototype state across app restarts using SQLite through Drift and expose the data reactively through Riverpod.

## Scope

Persist:

- the authenticated local demo session;
- checked voting-document IDs;
- saved santinho IDs;
- the selected bottom-navigation index.

Do not persist the demo password. Do not introduce a remote backend or Riverpod's experimental provider persistence.

## Architecture

```text
UI
  -> Riverpod provider / controller
    -> repository interface
      -> Drift repository implementation
        -> AppDatabase
          -> SQLite
```

Drift owns storage, schema, migrations, and reactive queries. Riverpod owns dependency injection, asynchronous UI state, and subscriptions. Feature repositories preserve dependency inversion between UI rules and SQLite.

## Database Schema

### `app_sessions`

- `id`: singleton primary key;
- `user_id`: demo user identifier;
- `login`: authenticated login;
- `authenticated_at`: UTC timestamp.

### `checklist_progress`

- `document_id`: primary key matching the voting mock;
- `checked`: current completion state;
- `updated_at`: UTC timestamp.

### `saved_santinhos`

- `santinho_id`: primary key matching the santinho mock;
- `saved_at`: UTC timestamp.

### `app_preferences`

- `key`: primary key;
- `value`: string representation;
- `updated_at`: UTC timestamp.

## Authentication Contract

The temporary local demo credential is:

```text
login: demo@apuraqui.app
password: 123456
```

Successful authentication stores only session metadata. Invalid credentials do not modify the database. Logout removes the local session. At startup, the app opens the home when a session exists and the login page otherwise.

## Reactive UI Contract

- Checklist tiles observe checked IDs from Drift through Riverpod.
- Saving a santinho inserts its ID and updates every subscriber.
- Bottom-navigation selection persists through the preference repository.
- A logout action is visible in the shared app header and clears the session.

## Testing

- Use SQLite in memory for database and repository tests.
- Verify session save, invalid login, logout, checklist updates, saved santinhos, and navigation preferences.
- Verify startup routing, persisted UI state, and logout behavior with provider overrides.

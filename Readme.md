# Краткое описание:

GitHub Actions позволяет для тестирования развернуть экземпляр postgres в контейнере с помощью docker compose.

Миграции фактически применялись два раза: до шага 3 включительно - затем выполнялся аналитический запрос (выводится план запроса) и до шага 4 (создание индексов) - затем снова вполняется аналитический запрос.

# Отчёт по выполнению миграций и автотестов

## 1. Добавлены миграции в проект `dbops-project`:

- `V001__create_tables.sql` — создание таблиц.
- `V002__change_schema.sql` — нормализация схемы.
- `V003__insert_data.sql` — заполнение таблиц данными.
- `V004__create_index.sql` — создание индексов для отчётов.

## 2. GitHub Workflow

Добавлены шаги для выполнения миграция с помощью FlyWay

## 3. Автотесты

Автотесты успешно выполняются при каждом запуске пайплайна.

## 4. Права пользователя

Для целей безопасности не используются реальные значения из репозитория.

```sql
-- Создание базы данных
CREATE DATABASE ${{ secrets.DB_NAME }};

-- Создание пользователя с заданным паролем
CREATE USER ${{ secrets.DB_USER }} WITH PASSWORD '${{ secrets.DB_PASSWORD }}';

-- Назначение всех привилегий на базу данных пользователю
GRANT ALL PRIVILEGES ON DATABASE ${{ secrets.DB_NAME }} TO ${{ secrets.DB_USER }};

-- Назначение всех привилегий на схему public
GRANT ALL PRIVILEGES ON SCHEMA public TO ${{ secrets.DB_USER }};

-- Установка привилегий по умолчанию на будущие таблицы в схеме public
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO ${{ secrets.DB_USER }};

-- Установка привилегий по умолчанию на будущие последовательности в схеме public
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO ${{ secrets.DB_USER }};
```

## 5. SQL-запрос, который показывает, какое количество сосисок было продано за предыдущую неделю.

```sql
SELECT
    o.date_created,
    SUM(op.quantity)
FROM
    orders AS o
    JOIN order_product AS op ON o.id = op.order_id
WHERE
    o.status = 'shipped'
    AND o.date_created > (CURRENT_DATE - INTERVAL '7 DAYS')
GROUP BY
    o.date_created;
```


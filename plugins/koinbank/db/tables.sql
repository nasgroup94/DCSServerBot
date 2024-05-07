CREATE TABLE accounts(account_id TEXT PRIMARY KEY, balance NUMERIC NOT NULL);
CREATE TABLE transactions(id SERIAL PRIMARY KEY, from_account TEXT NOT NULL, to_account TEXT NOT NULL, amount NUMERIC NOT NULL, comment TEXT, time TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc'));
CREATE OR REPLACE FUNCTION transaction_insert() RETURNS trigger AS $BODY$ DECLARE total NUMERIC;BEGIN UPDATE accounts SET balance = balance + NEW.amount WHERE account_id = NEW.to_account;UPDATE accounts SET balance = balance - NEW.amount WHERE account_id = NEW.from_account;SELECT balance INTO total FROM accounts WHERE account_id = NEW.to_account;IF (total < 0) THEN RAISE EXCEPTION 'Not enough Koins on the account %', NEW.to_account;END IF;SELECT balance INTO total FROM accounts WHERE account_id = NEW.from_account;IF (total < 0) THEN RAISE EXCEPTION 'Not enough Koins on the account %', NEW.from_account;END IF;RETURN NEW;END;$BODY$ LANGUAGE 'plpgsql';
CREATE TRIGGER tgr_transactions_insert AFTER INSERT ON transactions FOR EACH ROW EXECUTE PROCEDURE transaction_insert();

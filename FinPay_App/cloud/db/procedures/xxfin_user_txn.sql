CREATE OR REPLACE PROCEDURE XXFIN_USER_TXN  ( p_src_id      IN  NUMBER
                                            , p_tar_id      IN  NUMBER
                                            , p_currency    IN  VARCHAR2
                                            , p_amount      IN  NUMBER
                                            , p_method      IN  VARCHAR2
                                            , p_gateway     IN  VARCHAR2
                                            , p_mode        IN  VARCHAR2
                                            , p_desc        IN  VARCHAR
                                            , p_error_msg   OUT VARCHAR2)
AS
    ln_src_bal      NUMBER := 0.00;
    ln_tar_bal      NUMBER := 0.00;
    lc_src_cur      VARCHAR2(10);
    lc_tar_cur      VARCHAR2(10);
    
    ln_adm_bal      NUMBER := 0.00;
    lc_adm_cur      VARCHAR2(10);
    ln_comm         NUMBER := 0.00;
    ln_check        NUMBER := 0.00;
    
    ln_amount       NUMBER := 0.00;
BEGIN

    ln_amount := TRUNC(p_amount, 2);

    SELECT XFU.balance, XFU.currency
      INTO ln_src_bal, lc_src_cur
      FROM xxfin_users XFU
    WHERE XFU.user_id = p_src_id;
    
    ln_comm := ln_amount * 0.02;
    
    IF (UPPER(p_mode) = 'DEPOSIT') THEN
        IF (ln_amount >= 100) THEN
            UPDATE xxfin_users XFU
               SET XFU.balance = ln_src_bal + ln_amount
             WHERE XFU.user_id = p_src_id;
             
             INSERT INTO xxfin_txn( gateway, method, description, amount, currency, auth_id, source_id
                                  , target_id, txn_event, status, error_msg, creation_date, created_by)
                            VALUES( p_gateway, p_method, p_desc, ln_amount, UPPER(p_currency), p_src_id, p_src_id
                                  , p_tar_id, UPPER(p_mode), 'S', NULL, SYSDATE, p_src_id);
        ELSE
            p_error_msg := 'Minimun deposit amount is INR 100.';
            INSERT INTO xxfin_txn( gateway, method, description, amount, currency, auth_id, source_id
                                  , target_id, txn_event, status, error_msg, creation_date, created_by)
                            VALUES( p_gateway, p_method, p_desc, ln_amount, UPPER(p_currency), p_src_id, p_src_id
                                  , p_tar_id, UPPER(p_mode), 'E', p_error_msg, SYSDATE, p_src_id);
        END IF;

    ELSIF (UPPER(p_mode) = 'WITHDRAW') THEN
        IF (ln_src_bal < ln_amount) THEN
            p_error_msg := 'Insufficient balance!';
            INSERT INTO xxfin_txn( gateway, method, description, amount, currency, auth_id, source_id
                                  , target_id, txn_event, status, error_msg, creation_date, created_by)
                            VALUES( p_gateway, p_method, p_desc, ln_amount, UPPER(p_currency), p_src_id, p_src_id
                                  , p_tar_id, UPPER(p_mode), 'E', p_error_msg, SYSDATE, p_src_id);
        ELSE
            UPDATE xxfin_users XFU
               SET XFU.balance = ln_src_bal - ln_amount
             WHERE XFU.user_id = p_src_id;
             
             INSERT INTO xxfin_txn( gateway, method, description, amount, currency, auth_id, source_id
                                  , target_id, txn_event, status, error_msg, creation_date, created_by)
                            VALUES( p_gateway, p_method, p_desc, ln_amount, UPPER(p_currency), p_src_id, p_src_id
                                  , p_tar_id, UPPER(p_mode), 'S', NULL, SYSDATE, p_src_id);
        END IF;
    ELSIF (UPPER(p_mode) = 'P2P') THEN
        ln_check := ln_amount + ln_comm;
        IF (ln_src_bal < ln_check) THEN
            p_error_msg := 'Insufficient balance!';
            INSERT INTO xxfin_txn( gateway, method, description, amount, currency, auth_id, source_id
                                  , target_id, txn_event, status, error_msg, creation_date, created_by)
                            VALUES( p_gateway, p_method, p_desc, ln_amount, UPPER(p_currency), p_src_id, p_src_id
                                  , p_tar_id, UPPER(p_mode), 'E', p_error_msg, SYSDATE, p_src_id);
        ELSIF (ln_src_bal >= ln_check) THEN
            SELECT XFU.balance, XFU.currency
              INTO ln_tar_bal, lc_tar_cur
              FROM xxfin_users XFU
            WHERE XFU.user_id = p_tar_id;
            
            UPDATE xxfin_users XFU
               SET XFU.balance = ln_src_bal - ln_check
             WHERE XFU.user_id = p_src_id;
             
             UPDATE xxfin_users XFU
               SET XFU.balance = ln_tar_bal + ln_amount
             WHERE XFU.user_id = p_tar_id;
             
             SELECT XFU.balance, XFU.currency
              INTO ln_adm_bal, lc_adm_cur
              FROM xxfin_users XFU
            WHERE XFU.user_id = -1;
            
            UPDATE xxfin_users XFU
               SET XFU.balance = ln_adm_bal + ln_comm
             WHERE XFU.user_id = -1;
             
             INSERT INTO xxfin_txn( gateway, method, description, amount, currency, auth_id, source_id
                                  , target_id, txn_event, status, error_msg, creation_date, created_by)
                            VALUES( p_gateway, p_method, p_desc, ln_amount, UPPER(p_currency), p_src_id, p_src_id
                                  , p_tar_id, UPPER(p_mode), 'S', NULL, SYSDATE, p_src_id);
        END IF;
    END IF;

    COMMIT;
    
EXCEPTION
WHEN OTHERS THEN
    p_error_msg := SQLERRM;
    ROLLBACK;
    INSERT INTO xxfin_txn( gateway, method, description, amount, currency, auth_id, source_id
                          , target_id, txn_event, status, error_msg, creation_date, created_by)
                    VALUES( p_gateway, p_method, p_desc, ln_amount, UPPER(p_currency), p_src_id, p_src_id
                          , p_tar_id, UPPER(p_mode), 'E', p_error_msg, SYSDATE, p_src_id);
    COMMIT;
END;
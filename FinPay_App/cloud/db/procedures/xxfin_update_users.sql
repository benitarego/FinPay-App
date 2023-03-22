CREATE OR REPLACE PROCEDURE XXFIN_UPDATE_USER   ( p_fname   IN  VARCHAR2
                                                , p_lname   IN  VARCHAR2
                                                , p_email   IN  VARCHAR2
                                                , p_mobile  IN  VARCHAR2
                                                , p_user_id IN  NUMBER
                                                , p_ids     OUT NUMBER
                                                , p_error   OUT VARCHAR2)
AS
    lc_fname  VARCHAR2(120) := p_fname;
    lc_lname  VARCHAR2(120) := p_lname;
    lc_email  VARCHAR2(50)  := p_email;
    lc_mobile VARCHAR2(20)  := p_mobile;
    lc_e_ver  VARCHAR2(5)   := 'N';
    lc_m_ver  VARCHAR2(5)   := 'N';
    ln_id     NUMBER        := p_user_id;
BEGIN
    FOR ln_i IN 1..4 LOOP
        IF (ln_i = 1 AND lc_fname = '#NULL') THEN
            SELECT first_name
            INTO lc_fname
            FROM xxfin_users
            WHERE user_id = ln_id;
        ELSIF (ln_i = 2 AND lc_lname = '#NULL') THEN
            SELECT last_name
            INTO lc_lname
            FROM xxfin_users
            WHERE user_id = ln_id;
        ELSIF (ln_i = 3 AND lc_email = '#NULL') THEN
            SELECT email, email_verified
            INTO lc_email, lc_e_ver
            FROM xxfin_users
            WHERE user_id = ln_id;
        ELSIF (ln_i = 4 AND lc_mobile = '#NULL') THEN
            SELECT mobile, mobile_verified
            INTO lc_mobile, lc_m_ver
            FROM xxfin_users
            WHERE user_id = ln_id;
        END IF;
    END LOOP;
    
    UPDATE xxfin_users XFU 
    SET XFU.first_name = lc_fname
        , XFU.last_name = lc_lname
        , XFU.email = lc_email
        , XFU.mobile = lc_mobile
        , XFU.email_verified = lc_e_ver
        , XFU.mobile_verified = lc_m_ver
        , XFU.last_updated_date = SYSDATE
    WHERE XFU.user_id = ln_id
    RETURNING XFU.user_id INTO p_ids;
    
    COMMIT;
EXCEPTION
WHEN OTHERS THEN
    p_error := SQLERRM;
END;
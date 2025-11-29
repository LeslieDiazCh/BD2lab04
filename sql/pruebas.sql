
SET SERVEROUTPUT ON SIZE UNLIMITED;
SET LINESIZE 200;
SET PAGESIZE 100;

-- ============================================
-- 4.1.1: Partes no de París con peso > 10
-- ============================================
PROMPT ========================================
PROMPT 4.1.1: COLOR Y CIUDAD (No Paris, Peso>10)
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_color P.COLOR%TYPE;
    v_city P.CITY%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('COLOR', 15) || RPAD('CIUDAD', 15));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 15, '-') || RPAD('-', 15, '-'));
    
    SP_PARTES_NO_PARIS_PESO(v_cursor);
    LOOP
        FETCH v_cursor INTO v_color, v_city;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(v_color, 15) || RPAD(v_city, 15));
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.2: Número y peso en gramos
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.2: NÚMERO DE PARTE Y PESO EN GRAMOS
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_pnum P.P_NUM%TYPE;
    v_peso_gramos NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('P#', 10) || RPAD('PESO (gramos)', 20));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 10, '-') || RPAD('-', 20, '-'));
    
    SP_PARTES_PESO_GRAMOS(v_cursor);
    LOOP
        FETCH v_cursor INTO v_pnum, v_peso_gramos;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(v_pnum, 10) || RPAD(ROUND(v_peso_gramos, 2), 20));
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.3: Detalle completo de proveedores
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.3: DETALLE COMPLETO DE PROVEEDORES
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_snum S.S_NUM%TYPE;
    v_sname S.SNAME%TYPE;
    v_status S.STATUS%TYPE;
    v_city S.CITY%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('S#', 8) || RPAD('NOMBRE', 15) || RPAD('STATUS', 10) || RPAD('CIUDAD', 15));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 8, '-') || RPAD('-', 15, '-') || RPAD('-', 10, '-') || RPAD('-', 15, '-'));
    
    SP_DETALLE_PROVEEDORES(v_cursor);
    LOOP
        FETCH v_cursor INTO v_snum, v_sname, v_status, v_city;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(v_snum, 8) || RPAD(v_sname, 15) || RPAD(v_status, 10) || RPAD(v_city, 15));
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.4: Proveedores y partes co-localizados
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.4: PROVEEDORES Y PARTES CO-LOCALIZADOS
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_snum S.S_NUM%TYPE;
    v_sname S.SNAME%TYPE;
    v_pnum P.P_NUM%TYPE;
    v_pname P.PNAME%TYPE;
    v_city S.CITY%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('S#', 8) || RPAD('PROVEEDOR', 15) || RPAD('P#', 8) || RPAD('PARTE', 15) || RPAD('CIUDAD', 15));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 8, '-') || RPAD('-', 15, '-') || RPAD('-', 8, '-') || RPAD('-', 15, '-') || RPAD('-', 15, '-'));
    
    SP_PROV_PARTES_COLOCALIZADOS(v_cursor);
    LOOP
        FETCH v_cursor INTO v_snum, v_sname, v_pnum, v_pname, v_city;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(v_snum, 8) || RPAD(v_sname, 15) || RPAD(v_pnum, 8) || RPAD(v_pname, 15) || RPAD(v_city, 15));
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.5: Pares de ciudades
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.5: PARES DE CIUDADES (Proveedor → Parte)
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_ciudad_prov VARCHAR2(50);
    v_ciudad_parte VARCHAR2(50);
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('CIUDAD PROVEEDOR', 25) || RPAD('CIUDAD PARTE', 25));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 25, '-') || RPAD('-', 25, '-'));
    
    SP_PARES_CIUDADES_ABASTECE(v_cursor);
    LOOP
        FETCH v_cursor INTO v_ciudad_prov, v_ciudad_parte;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(v_ciudad_prov, 25) || RPAD(v_ciudad_parte, 25));
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.6: Pares de proveedores co-localizados
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.6: PARES DE PROVEEDORES CO-LOCALIZADOS
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_prov1 S.S_NUM%TYPE;
    v_prov2 S.S_NUM%TYPE;
    v_city S.CITY%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('PROVEEDOR 1', 15) || RPAD('PROVEEDOR 2', 15) || RPAD('CIUDAD', 15));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 15, '-') || RPAD('-', 15, '-') || RPAD('-', 15, '-'));
    
    SP_PARES_PROV_COLOCALIZADOS(v_cursor);
    LOOP
        FETCH v_cursor INTO v_prov1, v_prov2, v_city;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(v_prov1, 15) || RPAD(v_prov2, 15) || RPAD(v_city, 15));
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.7: Total de proveedores (FUNCIÓN)
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.7: TOTAL DE PROVEEDORES
PROMPT ========================================

BEGIN
    DBMS_OUTPUT.PUT_LINE('Total de proveedores: ' || FN_TOTAL_PROVEEDORES());
END;
/

-- ============================================
-- 4.1.8: Cantidad mínima y máxima para P2
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.8: CANTIDAD MIN Y MAX PARA PARTE P2
PROMPT ========================================

DECLARE
    v_min NUMBER;
    v_max NUMBER;
BEGIN
    SP_MIN_MAX_PARTE_P2(v_min, v_max);
    DBMS_OUTPUT.PUT_LINE('Cantidad Mínima: ' || v_min);
    DBMS_OUTPUT.PUT_LINE('Cantidad Máxima: ' || v_max);
END;
/

-- ============================================
-- 4.1.9: Partes y total despachado
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.9: PARTES Y TOTAL DESPACHADO
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_pnum P.P_NUM%TYPE;
    v_total NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('P#', 10) || RPAD('TOTAL DESPACHADO', 20));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 10, '-') || RPAD('-', 20, '-'));
    
    SP_PARTES_TOTAL_DESPACHADO(v_cursor);
    LOOP
        FETCH v_cursor INTO v_pnum, v_total;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(v_pnum, 10) || RPAD(v_total, 20));
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.10: Partes por más de un proveedor
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.10: PARTES ABASTECIDAS POR MÁS DE UN PROVEEDOR
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_pnum P.P_NUM%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Número de Parte');
    DBMS_OUTPUT.PUT_LINE('---------------');
    
    SP_PARTES_VARIOS_PROVEEDORES(v_cursor);
    LOOP
        FETCH v_cursor INTO v_pnum;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_pnum);
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.11: Proveedores que abastecen P2
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.11: PROVEEDORES QUE ABASTECEN P2
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_nombre S.SNAME%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Nombre Proveedor');
    DBMS_OUTPUT.PUT_LINE('----------------');
    
    SP_PROVEEDORES_PARTE_P2(v_cursor);
    LOOP
        FETCH v_cursor INTO v_nombre;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_nombre);
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.12: Proveedores que abastecen al menos una parte
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.12: PROVEEDORES QUE ABASTECEN AL MENOS UNA PARTE
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_nombre S.SNAME%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Nombre Proveedor');
    DBMS_OUTPUT.PUT_LINE('----------------');
    
    SP_PROV_ABASTECEN_PARTES(v_cursor);
    LOOP
        FETCH v_cursor INTO v_nombre;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_nombre);
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.13: Proveedores con status menor al máximo
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.13: PROVEEDORES CON STATUS MENOR AL MÁXIMO
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_snum S.S_NUM%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('S# (Status < Max)');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    
    SP_PROV_STATUS_MENOR_MAX(v_cursor);
    LOOP
        FETCH v_cursor INTO v_snum;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_snum);
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.14: Proveedores que abastecen P2 (EXISTS)
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.14: PROVEEDORES QUE ABASTECEN P2 (usando EXISTS)
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_nombre S.SNAME%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Nombre Proveedor');
    DBMS_OUTPUT.PUT_LINE('----------------');
    
    SP_PROV_P2_EXISTS(v_cursor);
    LOOP
        FETCH v_cursor INTO v_nombre;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_nombre);
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.15: Proveedores que NO abastecen P2
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.15: PROVEEDORES QUE NO ABASTECEN P2
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_nombre S.SNAME%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Nombre Proveedor');
    DBMS_OUTPUT.PUT_LINE('----------------');
    
    SP_PROV_NO_ABASTECEN_P2(v_cursor);
    LOOP
        FETCH v_cursor INTO v_nombre;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_nombre);
    END LOOP;
    CLOSE v_cursor;
END;
/

-- ============================================
-- 4.1.16: Proveedores que abastecen TODAS las partes
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.16: PROVEEDORES QUE ABASTECEN TODAS LAS PARTES
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_nombre S.SNAME%TYPE;
    v_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Nombre Proveedor');
    DBMS_OUTPUT.PUT_LINE('----------------');
    
    SP_PROV_TODAS_PARTES(v_cursor);
    LOOP
        FETCH v_cursor INTO v_nombre;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_nombre);
        v_count := v_count + 1;
    END LOOP;
    CLOSE v_cursor;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('(Ningún proveedor abastece todas las partes)');
    END IF;
END;
/

-- ============================================
-- 4.1.17: Partes peso > 16 O abastecidas por S2
-- ============================================
PROMPT
PROMPT ========================================
PROMPT 4.1.17: PARTES CON PESO > 16 O ABASTECIDAS POR S2
PROMPT ========================================

DECLARE
    v_cursor SYS_REFCURSOR;
    v_pnum P.P_NUM%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Número de Parte');
    DBMS_OUTPUT.PUT_LINE('---------------');
    
    SP_PARTES_PESO_O_S2(v_cursor);
    LOOP
        FETCH v_cursor INTO v_pnum;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_pnum);
    END LOOP;
    CLOSE v_cursor;
END;
/

PROMPT
PROMPT ========================================
PROMPT FIN DE PRUEBAS
PROMPT ========================================

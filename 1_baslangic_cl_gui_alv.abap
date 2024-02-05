*&---------------------------------------------------------------------*
*& Report ZAB_C5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zab_c5.

INCLUDE ZAB_C5_top.
INCLUDE ZAB_C5_pbo.
INCLUDE ZAB_C5_pai.
INCLUDE ZAB_C5_frm.

START-OF-SELECTION.

  PERFORM get_data.

  CALL SCREEN 0100.



*&---------------------------------------------------------------------*
*& Include          ZAB_C5_TOP
*&---------------------------------------------------------------------*


"oo alv OBJESİ data tanımlaması.
DATA: go_alv TYPE REF TO cl_gui_alv_grid. "gl_gui_alv_gridden referans al


"custom containerin objesini oluşturduk
DATA: go_cont TYPE REF TO cl_gui_custom_container.

DATA: gt_mara TYPE TABLE OF mara.



*&---------------------------------------------------------------------*
*& Include          ZAB_C5_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.
  PERFORM display_alv.
ENDMODULE.



*&---------------------------------------------------------------------*
*& Include          ZAB_C5_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.



*&---------------------------------------------------------------------*
*& Include          ZAB_C5_FRM
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form display_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .
  "CUSTOM CONTAINER'I TUTACAK OLAN CONTAINER OBJESINE CC_ALV'Yİ(0100 EKRANININ CUSTOM CONTAINERI) VERDİK.
  "subcontainer tarzı şeyler yapılabilir.
  CREATE OBJECT go_cont
    EXPORTING
      container_name = 'CC_ALV'.


  "CLGUI ALVYI CREATE EDIP IÇERİSİNDE ÇALIŞACAK CONTAINERİ I_PARENT KISMINA VERDİK.
  CREATE OBJECT go_alv
    EXPORTING
      i_parent = go_cont. "cl_gui_container=>screen0. deseydik fullscreen alv şeklinde ekrana basacaktı.

  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
      i_structure_name = 'MARA'
    CHANGING
      it_outtab        = gt_mara.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT * FROM mara
    INTO TABLE gt_mara.
ENDFORM.
  

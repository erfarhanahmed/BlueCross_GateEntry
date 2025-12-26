class ZCL_ZF_RGP_APPROVAL_DPC_EXT definition
  public
  inheriting from ZCL_ZF_RGP_APPROVAL_DPC
  create public .

public section.
protected section.

  methods ADMINPANELSET_GET_ENTITY
    redefinition .
  methods ADMINPANELSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZF_RGP_APPROVAL_DPC_EXT IMPLEMENTATION.


  method ADMINPANELSET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->ADMINPANELSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.


    data(lt_keys) = IO_TECH_REQUEST_CONTEXT->GET_KEYS( ).
*data(ls_key) = keys[ 1 ]-VALUE.
    READ TABLE lt_keys INTO DATA(ls_key) WITH KEY name = 'ROLE'.
     IF sy-subrc = 0 AND ls_key-value IS NOT INITIAL.
    DATA(lv_role) = ls_key-value.
    ENDIF.
    CLEAr:ls_key.
        READ TABLE lt_keys INTO ls_key WITH KEY name = 'USER'.
     IF sy-subrc = 0 AND ls_key-value IS NOT INITIAL.
    DATA(lv_user) = ls_key-value.
    ENDIF.

select single from Agr_Users fields AGR_NAME ,UNAME where AGR_NAME = @lv_role and uname = @lv_user  INTO @data(ls_role).
"select single Agr_Users fields UNAME where AGR_NAME = LS_KEY INTO table @data(uname).
  if ls_role is NOT INITIAL.
ER_ENTITY-ROLE = ls_role-AGR_NAME.
ER_ENTITY-USER = ls_role-UNAME.
ENDIF.



*DATA: lt_filter TYPE /iwbep/t_mgw_select_option,
*      ls_filter LIKE LINE OF lt_filter,
*      ls_selopt LIKE LINE OF ls_filter-select_options,
*      lv_user   TYPE agr_users-uname,
*      lv_role   TYPE agr_users-agr_name.
*
*lt_filter = it_filter-select_options.
*
*LOOP AT lt_filter INTO ls_filter.
*  CASE ls_filter-property.
*    WHEN 'User'.
*      READ TABLE ls_filter-select_options INTO ls_selopt INDEX 1.
*      lv_user = ls_selopt-low.
*
*    WHEN 'Role'.
*      READ TABLE ls_filter-select_options INTO ls_selopt INDEX 1.
*      lv_role = ls_selopt-low.
*  ENDCASE.
*ENDLOOP.
*
*IF lv_user IS NOT INITIAL AND lv_role IS NOT INITIAL.
*  SELECT SINGLE agr_name, uname
*    FROM agr_users
*    WHERE agr_name = @lv_role
*      AND uname    = @lv_user
*    INTO @DATA(ls_role).
*
*  IF sy-subrc = 0.
*    er_entity-role = ls_role-agr_name.
*    er_entity-user = ls_role-uname.
*  ENDIF.
*ENDIF.
  endmethod.


  method ADMINPANELSET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->ADMINPANELSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
*     DATA(ls_key) = IT_FILTER_SELECT_OPTIONS.
*    data(ls_key1) = ls_key[ 1 ]-select_options.

*   SELECT FROM agr_users FIELDS uname
**     WHERE agr_name in @ls_key1
*     INTO TABLE @DATA(uname).
**ER_ENTITY-ROLE = LS_KEY.
**ER_ENTITY-USER = UNAME.
*
*
*
*   ET_ENTITYSET = value #( for ls_entity in uname
*                           ( role = ls_entity-uname )   ).
   DATA: lt_filter TYPE /iwbep/t_mgw_select_option,
      ls_filter LIKE LINE OF lt_filter,
      ls_selopt LIKE LINE OF ls_filter-select_options,
      lv_user   TYPE agr_users-uname,
      lv_role   TYPE agr_users-agr_name.

lt_filter = it_filter_select_options.
   LOOP AT lt_filter INTO ls_filter.
     CASE ls_filter-property.
    WHEN 'User'.
      READ TABLE ls_filter-select_options INTO ls_selopt INDEX 1.
      lv_user = ls_selopt-low.

    WHEN 'Role'.
      READ TABLE ls_filter-select_options INTO ls_selopt INDEX 1.
      lv_role = ls_selopt-low.
  ENDCASE.
ENDLOOP.

IF lv_user IS NOT INITIAL AND lv_role IS NOT INITIAL.
  SELECT SINGLE agr_name, uname
    FROM agr_users
    WHERE agr_name = @lv_role
      AND uname    = @lv_user
    INTO @DATA(ls_role).
data:er_entity like line of et_entityset.
  IF sy-subrc = 0.
    er_entity-role = ls_role-agr_name.
    er_entity-user = ls_role-uname.

     append er_entity to et_entityset.
  ENDIF.
ENDIF.

  endmethod.
ENDCLASS.

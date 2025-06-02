/*
Название:	Витрина 5 - Сделка
Описание:	Основной массив данных в представляет собой сделки юридических лиц которые построены на витрине portfolio_all_core , клиенты которых входят IRBF портфель
Прототип на выходе формирует витрины:
	1) portfolio_deal_tab - техническая таблица с типом хранения данных SCD-2.
	2) portfolio_deal – итоговая пользовательская вью.
--------------------
*/
DROP TABLE IF EXISTS sbx.portfolio_deal_tab 
;
CREATE TABLE sbx.portfolio_deal_tab
(
	  report_dt 			DATE  			COMMENT 'PK | Отчетная дата'
	, client_core_id		BIGINT       	COMMENT 'PK | Идентификатор клиента из core'
	, proj_asvr_id          BIGINT          COMMENT 'Идентификатор клиента АС ВР (Проектное финансирование)'
	, def_client_core_id	BIGINT          COMMENT 'Конечный носитель риска'
	, def_client_tp			STRING          COMMENT 'Тип связи с КНР'
	, deal_core_main_id		BIGINT      	COMMENT 'NN | Идентификатор головной сделки из core'
	, deal_core_id			BIGINT       	COMMENT 'PK | Идентификатор сделки из core'
	, deal_abs_id			BIGINT 			COMMENT 'NN | Идентификатор сделки АБС'
	, deal_type				STRING 			COMMENT 'NN | Тип сделки'
	, deal_fin_oper_type    STRING          COMMENT 'Тип финансовой операции по сделке'
	, deal_num				STRING 			COMMENT 'NN | Номер сделки'
	, ccf					DECIMAL(38,17) 	COMMENT 'NN | Коэффициент кредитной конверсии из небаланса в баланс'
	, debt_sum				DECIMAL(38,17) 	COMMENT 'NN | Сумма остатка по сделке'
	, ead					DECIMAL(38,17) 	COMMENT 'NN | Величина кредитных требований по сделке'
	, deal_ebg_flg         	TINYINT         COMMENT 'Признак электронной банковской гарантии'
	, model_flg             TINYINT         COMMENT 'Признак входждения сделки в расчет модели'
	, deal_covering_flg		TINYINT         COMMENT 'Признак покрытия аккредитива'
/* Технические атрибуты */
	, valid_from_dttm		TIMESTAMP		COMMENT 'NN | Дата и время начала действия технической версии записи'
	, valid_to_dttm			TIMESTAMP		COMMENT 'NN | Дата и время окончания действия технической версии записи'
	, t_source_system_id  	SMALLINT        COMMENT 'NN | Идентификатор системы-источника'
	, t_changed_dttm      	TIMESTAMP       COMMENT 'NN | Дата и время изменения записи'
	, t_deleted_flg       	TINYINT         COMMENT 'NN | Признак удаления записи'
	, t_active_flg			TINYINT			COMMENT 'NN | Признак активной записи'
	, t_author				STRING          COMMENT 'NN | Имя джоба'
	, t_process_task_id		INTEGER         COMMENT 'NN | Идентификатор процесса загрузки'
)
COMMENT 'Витрина 5 - Сделка'
;
DROP VIEW IF EXISTS sbx.portfolio_deal
;
CREATE VIEW sbx.portfolio_deal
(
      report_dt 				COMMENT 'PK | Отчетная дата'
	, client_core_id			COMMENT 'PK | Идентификатор клиента из core'
	, proj_asvr_id          	COMMENT 'Идентификатор клиента АС ВР (Проектное финансирование)'
	, def_client_core_id		COMMENT 'Конечный носитель риска'
	, def_client_tp				COMMENT 'Тип связи с КНР'
	, deal_core_main_id			COMMENT 'NN | Идентификатор головной сделки из core'
	, deal_core_id				COMMENT 'PK | Идентификатор сделки из core'
	, deal_abs_id				COMMENT 'NN | Идентификатор сделки АБС'
	, deal_type					COMMENT 'NN | Тип сделки'
	, deal_fin_oper_type    	COMMENT 'Тип финансовой операции по сделке'
	, deal_num					COMMENT 'NN | Номер сделки'
	, ccf						COMMENT 'NN | Коэффициент кредитной конверсии из небаланса в баланс'
	, debt_sum					COMMENT 'NN | Сумма остатка по сделке'
	, ead						COMMENT 'NN | Величина кредитных требований по сделке'
	, deal_ebg_flg         		COMMENT 'Признак электронной банковской гарантии'
	, model_flg             	COMMENT 'Признак вхождения сделки в расчет модели'
	, deal_covering_flg			COMMENT 'Признак покрытия аккредитива'
/* Технические атрибуты */
	, t_source_system_id		COMMENT 'NN | Идентификатор системы-источника'
	, t_changed_dttm			COMMENT 'NN | Дата и время изменения записи'
	, t_process_task_id			COMMENT 'NN | Идентификатор процесса загрузки'
)
AS SELECT
	  report_dt
	, client_core_id
	, proj_asvr_id
	, def_client_core_id
	, def_client_tp
	, deal_core_main_id
	, deal_core_id
	, deal_abs_id
	, deal_type
	, deal_fin_oper_type
	, deal_num
	, ccf
	, debt_sum
	, ead
	, deal_ebg_flg
	, model_flg
	, deal_covering_flg
	, t_source_system_id
	, t_changed_dttm
	, t_process_task_id			
FROM sbx.portfolio_deal_tab
WHERE t_deleted_flg = 0
	AND	t_active_flg = 1
;
DROP TABLE IF EXISTS sbx.portfolio_deal_off_bal 
;
/* Поиск внебелансовых счетов */
CREATE TABLE sbx.portfolio_deal_off_bal AS
SELECT /* Внебаланс */
	  dp.report_dt
	, a.account_id
FROM dm_core.d_account_base AS a
JOIN sbx.ref_params AS dp
WHERE 1=1
	AND a.t_raw_status IN ('A','N','K','L','M','F')
	AND a.t_srs_id IN (9,201)
	AND a.chapter_nm = 'В' 
	AND dp.report_dt BETWEEN a.open_dt AND a.close_dt 
;
/* Модельный коэфицент кредитной конверсии CCF (В рамках расчета модели) */
DROP TABLE IF EXISTS sbx.portfolio_ccf_dict 
;
CREATE TABLE sbx.portfolio_ccf_dict AS
WITH ccf_map AS (
	SELECT
		REPLACE(di.name,'^^','^NULL^') AS sb
	FROM dm_rdm.object_classification AS oc
	JOIN dm_rdm.dict_item AS di
		ON oc.dict_item_id = di.dict_item_id
	WHERE '2024-06-30' BETWEEN oc.valid_from AND oc.valid_to
		AND oc.classifier_id = 237
)
, dict AS (
	SELECT
		  CAST(dict_item_id AS STRING) AS dict_item_id
		, name
	FROM dm_rdm.dict_item
	WHERE dict_id IN (84,85,86,87,88)
)
SELECT
	  di1.name AS guarantee_type
	, di2.name AS guarantee_type_suffix
	, di3.name AS rating_guarantee_type
	, CAST(di4.name AS SMALLINT) AS rating_guarantee_code
	, CAST(di5.name AS DECIMAL(18,10)) AS ccf
	, CAST(di6.name AS DECIMAL(18,10)) AS model_ccf
	, CAST(di7.name AS DECIMAL(18,10)) AS model_ccf_downturn
	FROM ccf_map AS cm
	LEFT JOIN dict AS di1
		ON SUBSTRING(cm.sb,1,4) = di1.dict_item_id
	LEFT JOIN dict AS di2
		ON SUBSTRING(cm.sb,6,4) = di2.dict_item_id
	LEFT JOIN dict AS di3
		ON SUBSTRING(cm.sb,11,4) = di3.dict_item_id
	LEFT JOIN dict AS di4
		ON SUBSTRING(cm.sb,16,4) = di4.dict_item_id
	LEFT JOIN dict AS di5
		ON SUBSTRING(cm.sb,21,4) = di5.dict_item_id
	LEFT JOIN dict AS di6
		ON SUBSTRING(cm.sb,26,4) = di6.dict_item_id
	LEFT JOIN dict AS di7
		ON SUBSTRING(cm.sb,31,4) = di7.dict_item_id
;
DROP TABLE IF EXISTS sbx.portfolio_guar 
;
CREATE TABLE IF NOT EXISTS sbx.portfolio_guar as 
SELECT
	  pr.report_dt
	, i.abs_id
	, i.instrument_id 			AS deal_stage_id
	, i.instrument_core_id		AS deal_core_id
	, bi.`number` 				AS deal_num
	, bi.start_date				AS deal_start_dt
	, bi.fact_final_date 		AS deal_fact_end_dt
	, bi.planned_final_date 	AS deal_plan_end_dt
	, bi.product_id 			AS product_id
	, p.name 					AS product_nm
	, p.code 					AS product_cd
	, g.guarantee_type_id
	, UPPER(gt.code) 			AS guarantee_type_cd
	, gt.name 					AS guarantee_type_nm
	, g.source_system_id
FROM sbx.ref_params AS pr
JOIN dm_stage_nsal.bank_instrument AS bi
	ON	pr.report_dt BETWEEN bi.start_date AND NVL(bi.fact_final_date, bi.planned_final_date) 
	AND bi.source_system_id in (9, 201)
	AND bi.changed < 3       
JOIN dm_stage_nsal.instrument AS i
	ON	i.instrument_id = bi.instrument_id  
	AND i.source_system_id in (9, 201)
	AND i.changed < 3
JOIN dm_stage_nsal.guarantee AS g
	ON	g.bank_instrument_id = bi.bank_instrument_id 
	AND g.changed < 3
	AND g.source_system_id in (9, 201)
JOIN dm_stage_nsal.guarantee_type AS gt
	ON	gt.guarantee_type_id = g.guarantee_type_id 
	AND gt.changed < 3
	AND gt.source_system_id in (9, 201)
JOIN dm_stage_nsal.product AS p
	ON	p.product_id = bi.product_id 
	AND p.changed < 3
	AND p.source_system_id in (9,201)
;
DROP TABLE IF EXISTS sbx.portfolio_akkr 
;
CREATE TABLE IF NOT EXISTS sbx.portfolio_akkr as 
SELECT
	  pr.report_dt
	, i.abs_id
	, i.instrument_id 			AS deal_stage_id
	, i.instrument_core_id		AS deal_core_id
	, bi.start_date				AS deal_start_dt
	, bi.fact_final_date 		AS deal_fact_end_dt
	, bi.planned_final_date 	AS deal_plan_end_dt
	, l.covering_flag			AS deal_covering_flg
FROM sbx.ref_params AS pr
JOIN dm_stage_nsal.bank_instrument AS bi
	ON	pr.report_dt BETWEEN bi.start_date AND NVL(bi.fact_final_date, bi.planned_final_date) 
	AND bi.source_system_id IN (9, 201)
	AND bi.changed < 3       
JOIN dm_stage_nsal.instrument AS i
	ON	i.instrument_id = bi.instrument_id  
	AND i.source_system_id IN (9, 201)
	AND i.changed < 3
	AND i.instrument_type_id = 5 /* Аккредитив */
JOIN dm_stage_nsal.letter_of_credit AS l 
	ON	bi.bank_instrument_id = l.bank_instrument_id 
    AND l.changed < 3
WHERE l.covering_flag  = 1
;
DROP TABLE IF EXISTS sbx.portfolio_deal_ccf 
;
/* Коэфицент кредитной конверсии CCF */
CREATE TABLE sbx.portfolio_deal_ccf AS
WITH ccf AS (
	SELECT
		  a.stage_id AS deal_stage_id
		, a.abs_id AS deal_abs_id
		, ii.instrument_core_id AS deal_core_id
		, i.rate_type_cd
		, i.provision_rate
		, i.provision_cd
		, i.provision_nm
		, i.period_from_dt
		, i.period_to_dt 
	FROM dm_rdm.agreement_provision_ifrs AS i
	JOIN dm_evd_nsal.agreement AS a
		ON  a.agreement_rk = i.agreement_rk 
		AND a.t_source_system_id = 318 
	JOIN dm_stage_nsal.instrument AS ii
		ON	a.stage_id = ii.instrument_id 
		AND ii.changed < 3
		AND ii.source_system_id = 318
	WHERE i.rate_type_cd IN ('CCF_GUAR', 'CFF_CRED_F')
)
, ccf_rate AS (
	SELECT
		  dp.report_dt
		, i.deal_stage_id
		, i.deal_abs_id
		, i.deal_core_id
		, i.rate_type_cd AS ccf_tp_cd
		, i.provision_rate AS ccf
		, ROW_NUMBER() OVER(PARTITION BY dp.report_dt, i.deal_core_id
								ORDER BY CASE
											WHEN i.rate_type_cd = 'CCF_GUAR'
												THEN 1
											WHEN i.rate_type_cd = 'CFF_CRED_F'
												THEN 2
											ELSE 4
										 END) AS rn
	FROM ccf AS i
	JOIN sbx.ref_params AS dp
	WHERE dp.report_dt BETWEEN i.period_from_dt AND i.period_to_dt 
)
SELECT
	  i.report_dt
	, i.deal_stage_id
	, i.deal_abs_id
	, i.deal_core_id
	, i.ccf_tp_cd
	, i.ccf
FROM ccf_rate AS i
WHERE i.rn = 1
;
/* Качественные/Групповые атрибуты Проекта*/
DROP TABLE IF EXISTS sbx.proj_attr 
;
CREATE TABLE sbx.proj_attr AS
WITH rating AS (
	SELECT
		  dp.report_dt
		, ROW_NUMBER() OVER (PARTITION BY dp.report_dt ORDER BY oc_low.value DESC) AS id
		, ROW_NUMBER() OVER (PARTITION BY dp.report_dt ORDER BY oc_low.value) AS id2
		, r.code AS rating
		, oc_low.value AS low
		, oc_mid.value AS middle
		, oc_up.value AS up
	FROM dm_ds_rdm.ASKO_RATING AS r
	CROSS JOIN sbx.ref_params AS dp
	JOIN dm_rdm.OBJECT_CLASSIFICATION AS oc_low
		ON	oc_low.RDM_TABLEOBJECT_ID = r.ASKO_RATING_ID
		AND oc_low.CLASSIFIER_ID = 76
		AND dp.report_dt BETWEEN NVL(oc_low.valid_from, '1900-01-01') AND NVL(oc_low.VALID_TO, '4000-12-31') 
	JOIN dm_rdm.OBJECT_CLASSIFICATION oc_up
		ON	oc_up.RDM_TABLEOBJECT_ID = r.ASKO_RATING_ID
		AND oc_up.CLASSIFIER_ID = 77
		AND dp.report_dt BETWEEN NVL(oc_up.valid_from, '1900-01-01') AND NVL(oc_up.VALID_TO, '4000-12-31') 
	JOIN dm_rdm.OBJECT_CLASSIFICATION oc_mid
		ON	oc_mid.RDM_TABLEOBJECT_ID = r.ASKO_RATING_ID
		AND oc_mid.CLASSIFIER_ID = 52
		AND dp.report_dt BETWEEN NVL(oc_mid.valid_from, '1900-01-01') AND NVL(oc_mid.VALID_TO, '4000-12-31') 
	WHERE r.changed < 3
)
, rating_scale AS (
	SELECT
		  report_dt
		, id
		, id2
		, rating
		, low
		, middle
		, up
	FROM rating
	WHERE rating <> 'D'
)
, asvr_indicators AS (
	SELECT	
		  p.report_dt
	    , c.client_asvr_id
	    , c.calculation_asvr_id
		, c.rating_with_add_cond
		, c.correct_expert
		, c.is_correct_guar_rating
		, c.guar_rating_pit
		, c.grp_rating_pit
		, c.gs_2
		, c.gs_9
	FROM sbx.rating_calc_indicators c
	JOIN sbx.portfolio_client_asvr p 
		ON c.client_asvr_id = p.client_asvr_id 
		AND c.calculation_asvr_id = p.calculation_asvr_id
	JOIN sbx.ref_params AS rp
		ON p.report_dt = rp.report_dt
)
SELECT
	  c1.report_dt
	, c1.client_asvr_id
	, c1.is_correct_guar_rating
	, c1.rating_with_add_cond
	, c1.correct_expert
	, rs2.rating AS correct_rating
	, CAST(rs2.middle AS DECIMAL(38,17)) AS correct_pd
	, c1.guar_rating_pit
	, rs3.rating AS grp_rat_pit
	, CAST(rs3.middle AS DECIMAL(38,17)) AS grp_rat_pit_pd
	, c1.gs_2
	, c1.gs_9
FROM asvr_indicators AS c1
LEFT JOIN rating_scale AS rs 
	ON	rs.rating = c1.rating_with_add_cond
	AND rs.report_dt = c1.report_dt
LEFT JOIN rating_scale AS rs2 
	ON	rs2.id = CASE 
					WHEN rs.id + NVL(c1.correct_expert, 0) < 0 
						THEN 1 
					WHEN rs.id + NVL(c1.correct_expert, 0) > 20 
						THEN 20
					ELSE rs.id + NVL(c1.correct_expert, 0)
				END
	AND rs2.report_dt = c1.report_dt
LEFT JOIN rating_scale AS rs3
	ON	rs3.id2 = c1.grp_rating_pit
	AND rs3.report_dt = c1.report_dt	
;
/* Проектное финансирование, связь сделки АБС с проектом АСВР */
DROP TABLE IF EXISTS sbx.poject_fin_deal_lnk 
;
CREATE TABLE sbx.poject_fin_deal_lnk AS
WITH proj_deal_fin_lnk AS (
	SELECT
		  rp.report_dt
		, ad.id								AS deal_asvr_id
		, CAST(ad.id_external AS BIGINT)	AS deal_abs_id
		, co.par_obj_id					 	AS proj_asvr_id
		, co.attr_id
		, CASE
			WHEN ad.external_system = 'CFT_F1'
				THEN 201
			WHEN ad.external_system = '5NT'
				THEN 9
			WHEN ad.external_system = 'DIA.BEANS'
				THEN 209
		  END AS t_srs_id
	FROM sbx.ref_params AS rp
	JOIN dm_asvr_ultra_gpb_d.v_ext_abc_deal AS ad
		ON ad.external_system IN ('5NT', 'CFT_F1', 'DIA.BEANS')
	JOIN dm_asvr_ultra_gpb_d.v_ext_contractor_attrs_obj AS co
		ON	ad.id = co.obj_id
		AND rp.report_dt BETWEEN CAST(co.start_date AS DATE) AND co.end_date
		AND co.attr_id = 1490020639	/* ATTR_DEAL_PROJECT - Проект по сделке */
)
, proj_fin_risk_owner as (
	SELECT 
		  dt.report_dt
		, guar.obj_id
		, prj.client_core_id
	FROM sbx.ref_params AS dt 
	/* Поручитель по проекту */
	LEFT JOIN dm_asvr_ultra_gpb_d.v_ext_contractor_attrs_obj AS guar 
		ON	guar.attr_id = 1200086082  /* ATTR_GUARANTEE_BAIL - Гарант/поручитель по проекту */
	/* Поручитель */
	LEFT JOIN sbx.portfolio_client_asvr AS prj
		ON	prj.report_dt = dt.report_dt
		AND prj.client_asvr_id = guar.par_obj_id
)
/* Проектное финансирование, определение конечно носителя риска (КНР) + регресс на проучителя */
SELECT
	  d.report_dt
	, d.deal_abs_id
	, d.proj_asvr_id
	, CASE
		WHEN g_attr.is_correct_guar_rating = 'Да'
			AND g_attr.correct_pd > prj.client_pd_pit
			AND g_attr.guar_rating_pit IS NOT NULL
			THEN ro.client_core_id /* Поручитель по проекту */
	  END def_client_core_id
	/* Предусмотреть логику на рейтинг Д сразу брать с заемщика */
	, CASE
		WHEN nvl(g_attr.is_correct_guar_rating, '') = 'Да'
			AND g_attr.correct_pd > prj.client_pd_pit 
			AND g_attr.guar_rating_pit IS NOT NULL
			THEN 'Текущее финансирование - риск на поручителя' /* Грантор по проект */
		WHEN nvl(g_attr.is_correct_guar_rating, '') <> 'Да'
			AND g_attr.gs_9 IN ('Полная рейтинговая связь','Ограниченная рейтинговая связь')
			AND g_attr.gs_2 IS NOT NULL
			AND g_attr.correct_pd <>  prj.client_pd_pit
			AND g_attr.grp_rat_pit_pd = prj.client_pd_pit
			THEN 'Текущее финансирование - риск на группу' /* Заемщик */
		ELSE 'Специализированное кредитование'
	  END def_client_tp
	, d.t_srs_id
FROM proj_deal_fin_lnk AS d
/* Проект */
LEFT JOIN sbx.portfolio_client_asvr AS prj
	ON	prj.report_dt = d.report_dt
	AND prj.client_asvr_id = d.proj_asvr_id
/* Качственные показатели c проекта */
LEFT JOIN sbx.proj_attr AS g_attr
	ON	g_attr.report_dt = d.report_dt
	AND g_attr.client_asvr_id = d.proj_asvr_id
/* Поручитель по проекту */
LEFT JOIN proj_fin_risk_owner AS ro 
	ON	ro.report_dt = d.report_dt
	AND ro.obj_id = d.proj_asvr_id
;
INSERT INTO sbx.portfolio_deal_tab
(
	  report_dt
	, client_core_id
	, proj_asvr_id
	, def_client_core_id
	, def_client_tp
	, deal_core_main_id
	, deal_core_id
	, deal_abs_id
	, deal_type
	, deal_fin_oper_type
	, deal_num
	, ccf
	, debt_sum
	, ead
	, deal_ebg_flg
	, model_flg
	, deal_covering_flg
	, valid_from_dttm
	, valid_to_dttm
	, t_source_system_id
	, t_changed_dttm
	, t_deleted_flg
	, t_active_flg
	, t_author
	, t_process_task_id		
)
WITH model_irbf_portf AS (
    /* Риск сегментация из справочника для расчета модельного LGD (в рамках расчета модели)*/
	SELECT
		  dp.report_dt
		, b.irbf_nm
	FROM sbx.ref_params AS dp 
	JOIN in_manual_corp_models.LGD_IRBF_BUCKET AS b 
		ON dp.report_dt BETWEEN b.period_from_dt AND b.period_to_dt 
		AND b.ident = 'CORP'
) 
, client as (
	SELECT
		  dp.report_dt
		, c.client_core_id
		, c.client_asvr_id
		, c.client_irbf_nm
		, CASE
			WHEN m.irbf_nm IS NOT NULL
				THEN 1
			ELSE 0
		  END AS model_flg
	FROM sbx.ref_params AS dp 
	JOIN sbx.portfolio_client_asvr AS c
		ON	c.report_dt = dp.report_dt
	LEFT JOIN model_irbf_portf AS m 
		ON	m.report_dt = c.report_dt
		AND m.irbf_nm = c.client_irbf_nm	 	   
)
, ccf_cls AS (
	SELECT
		CASE
			WHEN c.guarantee_type_suffix IS NOT NULL 
	            THEN CONCAT('^', c.guarantee_type, '[_-]?',guarantee_type_suffix,'$','|^', guarantee_type_suffix, '[_-]?',c.guarantee_type,'$')
			ELSE CONCAT('^', c.guarantee_type,'$')
		  END AS reg_code
		, c.ccf
		, c.model_ccf 
	FROM sbx.portfolio_ccf_dict AS c	
)
, pac AS (
		SELECT
		  d.report_dt 
		, d.client_core_id
		, d.deal_main_core_id 		AS deal_core_main_id
		, d.deal_core_id
		, d.deal_abs_id
		, d.deal_type_cd 			AS deal_type
		, d.deal_product_cd			AS deal_fin_oper_type
		, d.deal_num
		, d.deal_product_subtype_cd
		, d.deal_open_dt
		, IF(d.deal_fact_close_dt = '5000-01-01', d.deal_plan_close_dt, d.deal_fact_close_dt) AS deal_close_dt
		, d.balance_account_2lvl_num
		, CAST(d.deal_rest_amt_rub AS DECIMAL(38,8)) AS debt_rur_amt
		, d.account_id
		, d.t_source_system_id
	FROM sbx.ref_params AS dp  
	JOIN sbx.PORTFOLIO_DEAL_REST AS d
		ON d.report_dt = dp.report_dt
	WHERE  d.t_source_system_id IN (9, 201, 209)
	/*  Факторинг */
	UNION ALL
	SELECT
		  dp.report_dt
		, fd.def_client_core_id 	AS client_core_id
		, CAST(NULL AS BIGINT) 		AS deal_core_main_id
		, fd.deal_core_id
		, fd.deal_abs_id
		, fd.deal_type_cd
		, fd.deal_product_cd 		AS deal_fin_oper_type
		, fd.deal_num
		, CAST(NULL AS STRING) 		AS deal_product_subtype_cd
		, fd.deal_open_dt
		, IF(fd.deal_fact_close_dt = '5000-01-01', fd.deal_close_dt, fd.deal_fact_close_dt) AS deal_close_dt
		, CAST(NULL AS STRING)		AS balance_account_2lvl_num
		, CAST(fd.tranch_amount_rub AS DECIMAL(38,8)) AS debt_rur_amt
		, CAST(NULL AS BIGINT) 		AS account_id
		, fd.t_source_system_id
	FROM sbx.ref_params AS dp  
	JOIN sbx.FACTORING_DEAL_HIST AS fd
		ON dp.report_hist_dttm BETWEEN fd.valid_from_dttm AND fd.valid_to_dttm
	WHERE fd.t_source_system_id = 251
		AND fd.def_client_core_id IS NOT NULL
)
, risk_bearer AS (
	SELECT 
		  dp.report_dt
		, CAST(d.ext_deal_id AS BIGINT) AS deal_abs_id
		, CAST(d.risk_bearer AS BIGINT) AS def_client_asvr_id
		, ROW_NUMBER() OVER (PARTITION BY dp.report_dt, d.ext_deal_id ORDER BY d.rep_date DESC) AS rn
	FROM sbx.ref_params AS dp  
	JOIN dm_asvr_ultra_gpb_d.v_ext_beans_deal AS d
		ON CAST(d.rep_date AS DATE) <= dp.report_dt
	WHERE d.risk_bearer IS NOT NULL
)
, deal AS (
	SELECT
		  d.report_dt 
		, d.client_core_id
		, prj.proj_asvr_id
		, COALESCE(prj.def_client_core_id, cl.client_core_id, pc.client_core_id) AS def_client_core_id
		, CASE 
			WHEN rb.deal_abs_id IS NOT NULL AND prj.proj_asvr_id IS NULL
				THEN 'Конечный риск определен АС ВР'
			ELSE NVL(prj.def_client_tp, 'Текущее финансирование - риск на заемщике') 
		  END AS def_client_tp
		, d.deal_core_main_id
		, d.deal_core_id
		, d.deal_abs_id
		, d.deal_type
		, d.deal_fin_oper_type
		, d.deal_num
		, d.deal_open_dt
		, d.deal_close_dt
		, CASE
			WHEN a.account_id IS NOT NULL 
	            THEN 1
	            ELSE 0
		  END                      AS off_bal_flg
		, d.debt_rur_amt AS debt_rur_amt
		, CASE WHEN d.deal_product_subtype_cd  = 'GPS_GUAR_EBG'
		       THEN 1
		       ELSE 0
		  END 						AS deal_ebg_flg
		, CASE
			WHEN d.balance_account_2lvl_num = '91317'
				AND d.deal_type = 'КРЕДИТ_ЛИНИЯ'
				THEN 1
			ELSE 0
		  END						AS deal_unused_limit_flg
		, pc.model_flg
		, d.t_source_system_id
	FROM pac AS d
	LEFT JOIN client AS pc /* Добавление данных клиентов для определения портфеля */
		ON	pc.report_dt = d.report_dt
		AND pc.client_core_id = d.client_core_id
	/* Признак внебаланса */
	LEFT JOIN sbx.portfolio_deal_off_bal AS a
		ON a.report_dt = d.report_dt
		AND a.account_id = d.account_id
	/* Проектное финансирование */
	LEFT JOIN sbx.poject_fin_deal_lnk AS prj
		ON prj.report_dt = d.report_dt
		AND prj.deal_abs_id = d.deal_abs_id
		AND prj.t_srs_id = d.t_source_system_id
	/* КНР по АС ВР */
	LEFT JOIN risk_bearer AS rb
		ON	rb.report_dt = d.report_dt
		AND rb.deal_abs_id = d.deal_abs_id
		AND rb.rn = 1
	LEFT JOIN client AS cl
		ON	rb.report_dt = cl.report_dt
		AND cl.client_asvr_id = rb.def_client_asvr_id
	WHERE 1=1
		AND d.debt_rur_amt > 0
)
, deal_2 AS (
	SELECT
		  d.report_dt 
		, d.client_core_id
		, d.proj_asvr_id
		, d.def_client_core_id
		, d.def_client_tp
		, d.deal_core_main_id
		, d.deal_core_id
		, d.deal_abs_id
		, d.deal_type
		, d.deal_fin_oper_type
		, d.deal_num
		, d.deal_open_dt
		, d.deal_close_dt
		, d.off_bal_flg
		, d.debt_rur_amt
		, d.deal_ebg_flg
		, d.deal_unused_limit_flg
		, CASE 
			WHEN d.def_client_tp <> 'Специализированное кредитование'  /* Берем только сделки в рамках риск-сегменатции класс. 211 НЕ спецкред */
				THEN d.model_flg
			ELSE 0
		  END AS model_flg /* Признак вхождение сделки в модельный расчет */
		, d.t_source_system_id
		, DATEDIFF(d.deal_close_dt, d.deal_open_dt) AS deal_cnt_day
	FROM deal AS d
)
, deal_ead AS (
	SELECT
		  d.report_dt 
		, d.client_core_id
		, d.proj_asvr_id
		, CAST(d.def_client_core_id AS BIGINT) AS def_client_core_id
		, d.def_client_tp
		, d.deal_core_main_id
		, d.deal_core_id
		, d.deal_abs_id
		, d.deal_type
		, d.deal_fin_oper_type
		, d.deal_num
		, d.debt_rur_amt
		, NVL(pa.deal_covering_flg, 0) AS deal_covering_flg
		, CASE WHEN d.off_bal_flg = 1  /* Внебаланс */
				THEN CASE WHEN d.deal_unused_limit_flg = 1 /* Неиспользуемые кредитные лимиты */
					     THEN CASE WHEN d.deal_cnt_day <= 365 
					               THEN 0.2 
					               WHEN d.deal_cnt_day > 365
					               THEN 0.5
					         END
	           	         WHEN d.deal_type = 'ГАРАНТИЯ'
	           	         THEN COALESCE (CASE WHEN g.product_cd = 'GPS_GUAR_EBG' /* Если ЭБГ в не зависимости от модельной сделки или нет */ 
				           	         		 THEN 0.28
											 WHEN d.model_flg = 1 /* Если модельная сделка */
				           	         		 THEN CASE WHEN c.model_ccf IS NOT NULL 
						            		  		   THEN c.model_ccf
						                      	  END
						                     WHEN d.model_flg = 0 /* Если не модельная сделка*/
						                     THEN c.ccf 
						                END, dc.ccf, 0.5)
			              WHEN d.deal_type = 'АККРЕДИТИВ' 
			              THEN NVL (dc.ccf, 1)	   
	           		END
	       	   WHEN off_bal_flg = 0 /* Баланс */
	       	   THEN 1
	      END AS ccf
		, d.off_bal_flg
		, d.deal_ebg_flg
		, d.model_flg
		, d.t_source_system_id
	FROM deal_2 AS d
	/* Сделки АС ВР, расчитанный CCF */
	LEFT JOIN sbx.portfolio_deal_ccf AS dc
		ON	dc.report_dt = d.report_dt
		AND dc.deal_core_id = d.deal_core_id
	/* Гарантии с типом продукта */
	LEFT JOIN sbx.portfolio_guar AS g
		ON g.report_dt = d.report_dt
		AND g.deal_core_id = d.deal_core_id
	/* Аккредитив с признаком покрытия */
	LEFT JOIN sbx.portfolio_akkr AS pa
		ON	pa.report_dt = d.report_dt
		AND pa.deal_core_id = d.deal_core_id
	/* Классификатор модель */
    LEFT JOIN ccf_cls AS c
    	ON regexp_like(g.guarantee_type_cd, c.reg_code)
)
, deal_agr AS (
	SELECT
		  d.report_dt 
		, d.client_core_id
		, MAX(d.proj_asvr_id)		AS proj_asvr_id
		, MAX(d.deal_core_main_id)  AS deal_core_main_id
		, d.deal_core_id
		, MAX(d.def_client_core_id)	AS def_client_core_id
		, MAX(d.def_client_tp)		AS def_client_tp
		, MAX(d.deal_abs_id)        AS deal_abs_id
		, MAX(d.deal_type)          AS deal_type
		, MAX(d.deal_fin_oper_type) AS deal_fin_oper_type
		, MAX(d.deal_num)           AS deal_num
		, MIN(d.ccf)                AS ccf
		, SUM(d.debt_rur_amt)       AS debt_sum
		, SUM(d.debt_rur_amt * d.ccf)	AS ead
		, MAX(d.deal_ebg_flg)       AS deal_ebg_flg
		, MAX(d.model_flg)			AS model_flg
		, MAX(d.deal_covering_flg)	AS deal_covering_flg
		, MAX(d.t_source_system_id) AS t_source_system_id
	FROM deal_ead AS d
	GROUP BY
		  d.report_dt 
		, d.client_core_id 
		, d.deal_core_id
)
SELECT
	  d.report_dt
	, CAST(d.client_core_id AS BIGINT) AS client_core_id
	, d.proj_asvr_id
	, d.def_client_core_id
	, d.def_client_tp
	, d.deal_core_main_id
	, d.deal_core_id
	, CAST(d.deal_abs_id AS BIGINT) AS deal_abs_id
	, d.deal_type
	, d.deal_fin_oper_type
	, d.deal_num
	, CAST(d.ccf AS DECIMAL(38,17))      AS ccf
	, CAST(d.debt_sum AS DECIMAL(38,17)) AS debt_sum
	, CAST(d.ead AS DECIMAL(38,17))      AS ead
	, CAST(d.deal_ebg_flg AS TINYINT)       AS deal_ebg_flg
	, CAST(d.model_flg AS TINYINT)			AS model_flg
	, CAST(deal_covering_flg AS TINYINT)	AS deal_covering_flg
	, CAST(now() AS TIMESTAMP)				AS valid_from_dttm
	, CAST('2100-01-01 00:00:00' AS TIMESTAMP) AS valid_to_dttm
	, d.t_source_system_id
	, CAST(now() AS timestamp)  AS t_changed_dttm
	, CAST(0 AS tinyint)        AS t_deleted_flg
	, CAST(1 AS TINYINT)		AS t_active_flg
	, CAST(NULL AS STRING)      AS t_author
	, CAST(NULL AS INTEGER)     AS t_process_task_id
FROM deal_agr AS d
;
/* технические проверки прототипа */
/* Дубли по PK */
SELECT report_dt, client_core_id, deal_core_id, COUNT(*)
FROM sbx.portfolio_deal
GROUP BY report_dt, client_core_id, deal_core_id
HAVING COUNT(*)>1
LIMIT 100
;
/* NULL в PK */
SELECT *
FROM sbx.portfolio_deal
WHERE report_dt IS NULL 
OR client_core_id IS NULL
OR deal_core_id IS NULL
LIMIT 100

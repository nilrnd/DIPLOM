/*
Название:	Витрина 4 - Обеспечение
Описание:	Основной массив данных в представляет собой обеспечения юридических лиц со следующими типам продукта
Прототип на выходе формирует витрины:
	1) portfolio_collateral_tab - техническая таблица с типом хранения данных SCD-2.
	2) portfolio_collateral – итоговая пользовательская вью.
--------------
*/
DROP TABLE IF EXISTS sbx.portfolio_collateral_tab 
;
CREATE TABLE IF NOT EXISTS sbx.portfolio_collateral_tab
(
	  report_dt				DATE				 	COMMENT 'PK | Отчетная дата'
	, pledger_id			BIGINT       			COMMENT 'NN | Идентификатор залогодателя из core'
	, coll_core_main_id		BIGINT      			COMMENT 'NN | Идентификатор головного обеспечения из core'
	, coll_core_id			BIGINT      			COMMENT 'PK | Идентификатор обеспечения из core'
	, coll_abs_id           BIGINT                  COMMENT 'Идентификатор обеспечения из АБС'
	, coll_nbr				STRING	                COMMENT 'Номер обеспечения'
	, coll_ccy_cd			STRING	                COMMENT 'NN | ISO код валюты'
	, coll_ccy_rate			DECIMAL(38,17)	        COMMENT 'Курс валюты на дату'
	, coll_pr_subtype_cd	STRING	                COMMENT 'Подтип продукта'
	, coll_pr_type_cd		STRING	                COMMENT 'NN | Тип продукта'
	, coll_pr_id            BIGINT                  COMMENT 'Идентификатор продукта'
	, coll_pr_nm			STRING					COMMENT 'NN | Имя Продукта'
	, coll_fin_oper_code	STRING					COMMENT 'NN | Код финансовой операций'
	, coll_open_dt			STRING					COMMENT 'NN | Дата открытия'
	, coll_plan_close_dt	STRING					COMMENT 'NN | Плановая дата закрытия'
	, coll_fact_close_dt	STRING					COMMENT 'NN | Фактическая дата закрытия'
	, coll_status_cd		STRING					COMMENT 'NN | Статус обеспечения'
	, coll_surety_flg		TINYINT					COMMENT 'NN | Флаг поручительства'
	, coll_cs_accept_flg	TINYINT					COMMENT 'Признак согласования залоговой службой'
	, coll_quality_catg		STRING					COMMENT 'Категория качества'
	, coll_amt				DECIMAL(38,17)			COMMENT 'Первоначальная стоимость'
	, coll_amt_rur			DECIMAL(38,17)			COMMENT 'Первоначальная стоимость в рублях'
	, coll_full_cost		DECIMAL(38,17)			COMMENT 'Полная стоимость'
	, coll_full_cost_rur	DECIMAL(38,17)			COMMENT 'Полная стоимость в рублях'
	, coll_fair_prior_flg	TINYINT					COMMENT 'Признак приоритета на справедливую стоимость при учете покрытия'
	, coll_fair_cost		DECIMAL(38,17)			COMMENT 'Справедливая стоимость'
	, coll_fair_cost_rur	DECIMAL(38,17)			COMMENT 'Справедливая стоимость в рублях'
	, coll_market_cost		DECIMAL(38,17)			COMMENT 'Рыночная стоимость'
	, coll_market_cost_rur	DECIMAL(38,17)			COMMENT 'Рыночная стоимость в рублях'
	, coll_kind_cd          STRING                  COMMENT 'Код вида обеспечения'
/* Технические атрибуты */
	, valid_from_dttm		TIMESTAMP				COMMENT 'NN | Дата и время начала действия технической версии записи'
	, valid_to_dttm			TIMESTAMP				COMMENT 'NN | Дата и время окончания действия технической версии записи'
	, t_source_system_id	SMALLINT       			COMMENT 'NN | Идентификатор системы-источника'
    , t_changed_dttm		TIMESTAMP     			COMMENT 'NN | Дата и время изменения записи'
    , t_deleted_flg			TINYINT        			COMMENT 'NN | Признак удаления записи'
	, t_active_flg			TINYINT					COMMENT 'NN | Признак активной записи'
    , t_author				STRING         			COMMENT 'NN | Имя джоба'
    , t_process_task_id		INT            			COMMENT 'NN | Идентификатор процесса загрузки'
) 
COMMENT 'Витрина 4 - Обеспечение'
;
DROP VIEW IF EXISTS sbx.portfolio_collateral
;
CREATE VIEW sbx.portfolio_collateral
(
	  report_dt				COMMENT 'PK | Отчетная дата'
	, pledger_id			COMMENT 'NN | Идентификатор залогодателя из core'
	, coll_core_main_id		COMMENT 'NN | Идентификатор головного обеспечения из core'
	, coll_core_id			COMMENT 'PK | Идентификатор обеспечения из core'
	, coll_abs_id           COMMENT 'Идентификатор обеспечения из АБС'
	, coll_nbr				COMMENT 'Номер обеспечения'
	, coll_ccy_cd			COMMENT 'NN | ISO код валюты'
	, coll_ccy_rate			COMMENT 'Курс валюты на дату'
	, coll_pr_subtype_cd	COMMENT 'Подтип продукта'
	, coll_pr_type_cd		COMMENT 'NN | Тип продукта'
	, coll_pr_id            COMMENT 'Идентификатор продукта'
	, coll_pr_nm			COMMENT 'NN | Имя Продукта'
	, coll_fin_oper_code	COMMENT 'NN | Код финансовой операций'
	, coll_open_dt			COMMENT 'NN | Дата открытия'
	, coll_plan_close_dt	COMMENT 'NN | Плановая дата закрытия'
	, coll_fact_close_dt	COMMENT 'NN | Фактическая дата закрытия'
	, coll_status_cd		COMMENT 'NN | Статус обеспечения'
	, coll_surety_flg		COMMENT 'NN | Флаг поручительства'
	, coll_cs_accept_flg	COMMENT 'Признак согласования залоговой службой'
	, coll_quality_catg		COMMENT 'Категория качества'
	, coll_amt				COMMENT 'Первоначальная стоимость'
	, coll_amt_rur			COMMENT 'Первоначальная стоимость в рублях'
	, coll_full_cost		COMMENT 'Полная стоимость'
	, coll_full_cost_rur	COMMENT 'Полная стоимость в рублях'
	, coll_fair_prior_flg	COMMENT 'Признак приоритета на справедливую стоимость при учете покрытия'
	, coll_fair_cost		COMMENT 'Справедливая стоимость'
	, coll_fair_cost_rur	COMMENT 'Справедливая стоимость в рублях'
	, coll_market_cost		COMMENT 'Рыночная стоимость'
	, coll_market_cost_rur	COMMENT 'Рыночная стоимость в рублях'
	, coll_kind_cd          COMMENT 'Код вида обеспечения'
/* Технические атрибуты */
	, t_source_system_id	COMMENT 'NN | Идентификатор системы-источника'
    , t_changed_dttm		COMMENT 'NN | Дата и время изменения записи'
    , t_process_task_id		COMMENT 'NN | Идентификатор процесса загрузки'
)
AS SELECT 
	  report_dt
	, pledger_id
	, coll_core_main_id
	, coll_core_id
	, coll_abs_id
	, coll_nbr
	, coll_ccy_cd
	, coll_ccy_rate
	, coll_pr_subtype_cd
	, coll_pr_type_cd
	, coll_pr_id
	, coll_pr_nm
	, coll_fin_oper_code
	, coll_open_dt
	, coll_plan_close_dt
	, coll_fact_close_dt
	, coll_status_cd
	, coll_surety_flg
	, coll_cs_accept_flg
	, coll_quality_catg
	, coll_amt
	, coll_amt_rur
	, coll_full_cost
	, coll_full_cost_rur
	, coll_fair_prior_flg
	, coll_fair_cost
	, coll_fair_cost_rur
	, coll_market_cost
	, coll_market_cost_rur
	, coll_kind_cd
    , t_source_system_id
	, t_changed_dttm
	, t_process_task_id			
FROM sbx.portfolio_collateral_tab
WHERE T_DELETED_FLG = 0
	AND	t_active_flg = 1
;
INSERT INTO sbx.portfolio_collateral_tab
(
	  report_dt
	, pledger_id
	, coll_core_main_id
	, coll_core_id
	, coll_abs_id
	, coll_nbr
	, coll_ccy_cd
	, coll_ccy_rate
	, coll_pr_subtype_cd
	, coll_pr_type_cd
	, coll_pr_id
	, coll_pr_nm
	, coll_fin_oper_code
	, coll_open_dt
	, coll_plan_close_dt
	, coll_fact_close_dt
	, coll_status_cd
	, coll_surety_flg
	, coll_cs_accept_flg
	, coll_quality_catg
	, coll_amt
	, coll_amt_rur
	, coll_full_cost
	, coll_full_cost_rur
	, coll_fair_prior_flg
	, coll_fair_cost
	, coll_fair_cost_rur
	, coll_market_cost
	, coll_market_cost_rur
	, coll_kind_cd
	, valid_from_dttm
	, valid_to_dttm
    , t_source_system_id
	, t_changed_dttm
	, t_deleted_flg
	, t_active_flg
	, t_author
	, t_process_task_id
)
WITH cls AS
(
 /* Разметка обеспечений */
	SELECT
		  dp.report_dt
		, oc.classifier_id
		, di.name
		, CASE
			WHEN classifier_id = 203 
				THEN 'pled_prop'
			WHEN classifier_id = 204
				THEN 'pled_real'
			WHEN classifier_id = 205
				THEN 'pled_cb'
			WHEN classifier_id = 207
				THEN 'surety'
			WHEN classifier_id = 208
				THEN 'guar_dep'
		  END coll_kind_cd /* Код вида обеспечения */
	FROM sbx.ref_params AS dp 
	JOIN dm_rdm.object_classification AS oc
		ON	dp.report_dt BETWEEN oc.valid_from AND oc.valid_to
	JOIN dm_rdm.dict_item AS di 
		ON	oc.dict_item_id = di.dict_item_id
	WHERE classifier_id in (203,204,205,207,208)
)
, agr AS (
    /* Договора обеспечений*/
	SELECT
		  dp.report_dt
		, agd_p.abs_id
		, agd_p.cntr_entity_id
		, agd_p.main_agreement_id
		, agd_p.agreement_id    
		, agd_p.agreement_nbr
		, agd_p.agreement_type_cd
		, agd_p.amount
		, agd_p.amount_eqv
		, agd_p.crcy_iso_alpha_cd
		, agd_p.crcy_iso_numeric_cd
		, agd_p.prdct_kind_cd
		, agd_p.prdct_subtype_cd
		, agd_p.prdct_type_cd
		, agd_p.product_id
		, agd_p.product_nm
		, agd_p.product_cd
		, agd_p.open_dt
		, agd_p.plan_close_dt
		, agd_p.fact_close_dt
		, agd_p.status_cd
		, agd_p.t_srs_id
	FROM dm_core.d_agreement_base	AS agd_p  
	JOIN sbx.ref_params	AS dp
	WHERE 1=1
		AND agd_p.t_raw_status IN ('A','N','K','L','M','F')
		AND agd_p.t_srs_id IN (9,201)
		AND dp.report_dt  BETWEEN agd_p.open_dt AND agd_p.fact_close_dt
		AND agreement_type_cd IN (
			'ОБЕСПЕЧЕНИЕ',
			'ОБЕСПЕЧЕНИЕ_ДОП',
			'ОБЕСПЕЧЕНИЕ_НАЧУСЛ',
			'ДЕПОЗИТ',
			'ДЕПОЗИТ_ДОП',
			'ДЕПОЗИТ_ЛИНИЯ',
			'ДЕПОЗИТ_ПРОЛОНГ',
			'ДЕПОЗИТ_ПРОЛОНГ_ТЕХН',
			'ДЕПОЗИТ_ТРАНШ'
 		)
)
, cur AS (
    /* Курсы валют */
	SELECT
		  dp.report_dt
		, cur_c.currency_rate_id
		, cur_c.base_crcy_id
		, cur_c.base_crcy_num_cd
		, cur_c.rate_direct_value
	FROM dm_core.f_currency_rate AS cur_c 
	JOIN sbx.ref_params AS dp
	WHERE 1=1
		AND cur_c.quote_crcy_num_cd = '810'
		AND cur_c.rate_dt = dp.report_dt
		AND cur_c.t_raw_status IN ('A','N','K','L','M','F')
		AND cur_c.t_srs_id = 201 
)
, cost AS (
	SELECT
		  dp.report_dt
		, c_cost.cltrl_entity_id AS cntr_entity_id
		, c_cost.cltrl_agmt_id AS agreement_id
		, c_cost.quality_catg_cd	/* Категория качества*/
		, c_cost.cltrl_cost			/* Полная стоимость*/
		, CASE
			WHEN c_cost.t_srs_id = 201
				THEN c_cost.fair_cost
			WHEN c_cost.t_srs_id = 9
				THEN c_cost.estim_cost
		  END AS fair_cost /* Справедливая стоимость*/
		, c_cost.market_cost		/* Рыночная стоимость*/
		, c_cost.start_date
		, c_cost.final_date
		, CAST(NOW() AS DATE) AS now_dt
	FROM dm_core.f_agmt_cltrl_cost	AS c_cost 
	JOIN sbx.ref_params	AS dp	
	WHERE  1=1
		AND c_cost.t_srs_id IN (9,201)
		AND c_cost.t_raw_status IN ('A','N','K','L','M','F')
		AND dp.report_dt >= c_cost.start_date
)
, coll_cost AS (
	SELECT
		  report_dt
		, cntr_entity_id
		, agreement_id
		, quality_catg_cd
		, cltrl_cost
		, fair_cost
		, market_cost
		, start_date
		, final_date
		, now_dt
		, DATEDIFF(now_dt, start_date) AS diff_cnt_now
        , LAG(fair_cost) OVER (PARTITION BY agreement_id, report_dt ORDER BY start_date) AS prvs_fair_cost
	FROM cost
)
, collateral AS (
	SELECT 
		  c.report_dt
		, c.cntr_entity_id                 AS pledger_id
		, c.main_agreement_id              AS coll_core_main_id
		, c.agreement_id                   AS coll_core_id
		, c.abs_id                         AS coll_abs_id
		, c.agreement_nbr                  AS coll_nbr
		, c.crcy_iso_alpha_cd              AS coll_ccy_cd
		, cur.rate_direct_value            AS coll_ccy_rate
		, c.prdct_subtype_cd               AS coll_pr_subtype_cd 
		, c.prdct_type_cd                  AS coll_pr_type_cd
		, c.product_id                     AS coll_pr_id
		, c.product_nm                     AS coll_pr_nm
		, c.product_cd                     AS coll_fin_oper_code
		, c.open_dt                        AS coll_open_dt
		, c.plan_close_dt                  AS coll_plan_close_dt
		, c.fact_close_dt                  AS coll_fact_close_dt
		, c.status_cd                      AS coll_status_cd
		, CASE
			WHEN c.product_id IN (5005, 29888, 29889)
				THEN 1
			ELSE 0
		  END							AS coll_surety_flg		/* флаг Поручительства*/
		, c.amount						AS coll_amt				/* Первоначальная стоимость*/
		, CASE
			WHEN cl.coll_kind_cd = 'guar_dep'
				AND c.t_srs_id = 9
				THEN '1'
			ELSE cc.quality_catg_cd
		  END							AS coll_quality_catg	/* Категория качества */
		, NVL(cc.cltrl_cost, c.amount)	AS coll_full_cost		/* Полная стоимость*/
		, CASE 
			WHEN c.prdct_type_cd = 'ДЕПОЗИТ'
				AND c.t_srs_id = 9
				THEN dr.deal_rest_amt
			WHEN (NVL(fair_cost, -1) > 0) OR (diff_cnt_now > 2) OR (NVL(fair_cost, -1) IN (0, -1) AND NVL(fair_cost, -1) = NVL(prvs_fair_cost, -1)) 
                THEN fair_cost
			ELSE prvs_fair_cost
          END AS coll_fair_cost	
		, cc.market_cost				AS coll_market_cost		/* Рыночная стоимость*/
		, cl.coll_kind_cd
		, c.t_srs_id
	FROM agr AS c
	LEFT JOIN coll_cost AS cc
		ON c.report_dt = cc.report_dt
		AND c.agreement_id = cc.agreement_id
		AND cc.report_dt BETWEEN cc.start_date AND cc.final_date
	LEFT JOIN cur
		ON cur.report_dt = c.report_dt 
		AND cur.base_crcy_num_cd = c.crcy_iso_numeric_cd
	LEFT JOIN cls AS cl
		ON  cl.report_dt = c.report_dt 
		AND cl.name = c.product_cd
	LEFT JOIN sbx.PORTFOLIO_DEAL_REST AS dr
		ON	c.report_dt = dr.report_dt
		AND CAST(c.abs_id AS BIGINT) = dr.deal_abs_id 
		AND dr.deal_type_cd  = 'ДЕПОЗИТ'
		AND dr.t_source_system_id = 9
)
, asvr_collateral AS (
SELECT
	  c1.report_dt
	, c1.pledger_id
	, c1.coll_core_main_id
	, c1.coll_core_id
	, CAST(c1.coll_abs_id AS bigint) AS coll_abs_id
	, c1.coll_nbr
	, c1.coll_ccy_cd
	, c1.coll_ccy_rate
	, c1.coll_pr_subtype_cd
	, c1.coll_pr_type_cd
	, c1.coll_pr_id
	, c1.coll_pr_nm
	, c1.coll_fin_oper_code
	, c1.coll_open_dt
	, c1.coll_plan_close_dt
	, c1.coll_fact_close_dt
	, c1.coll_status_cd
	, c1.coll_surety_flg
	, c1.coll_quality_catg
	, CAST(c1.coll_amt AS DECIMAL(38,17)) AS coll_amt
	, CAST((c1.coll_amt * c1.coll_ccy_rate) AS DECIMAL(38,17)) 			AS coll_amt_rur
	, CAST(c1.coll_full_cost AS DECIMAL(38,17))							AS coll_full_cost 
	, CAST((c1.coll_full_cost  * c1.coll_ccy_rate) AS DECIMAL(38,17))	AS coll_full_cost_rur
	, CAST(c1.coll_fair_cost AS DECIMAL(38,17))							AS coll_fair_cost
	, CAST((c1.coll_fair_cost * c1.coll_ccy_rate) AS DECIMAL(38,17))	AS coll_fair_cost_rur
	, CAST(c1.coll_market_cost AS DECIMAL(38,17))						AS coll_market_cost
	, CAST((c1.coll_market_cost * c1.coll_ccy_rate) AS DECIMAL(38,17))	AS coll_market_cost_rur
	, c1.coll_kind_cd
	, c1.t_srs_id
FROM collateral AS c1
)
, asvr_fair AS ( 
	SELECT 
		  ac.report_dt
		, ac.coll_abs_id
		, CAST(asvr.spr_summ  AS DECIMAL(38,17))							AS fair_cost
		, CAST(asvr_rub.spr_summ  AS DECIMAL(38,17))						AS fair_cost_rur
		, COALESCE(asvr.cs_accept_flg,asvr_rub.cs_accept_flg) 				AS coll_cs_accept_flg
		, CASE 
			WHEN COALESCE(asvr.cs_accept_flg,asvr_rub.cs_accept_flg) = 1 OR coll_quality_catg IN ('1','2')
				THEN 1 /* Переопределение стоимости для залогов 1 и 2 КК или согласованных ЗС */
			ELSE 0
		  END AS include_flg
	FROM asvr_collateral AS ac
	JOIN dm_corp_models.v_ext_spr_prov_msfo  AS asvr
		ON	CAST(ac.report_dt AS TIMESTAMP) BETWEEN asvr.start_date AND asvr.end_date 
		AND asvr.ext_provision_id  = ac.coll_abs_id
		AND asvr.prov_ident = 'spr_porv_msfo'
	LEFT JOIN dm_corp_models.v_ext_spr_prov_msfo  AS asvr_rub
		ON	CAST(ac.report_dt AS TIMESTAMP) BETWEEN asvr_rub.start_date AND asvr_rub.end_date 
		AND asvr.ext_provision_id = asvr_rub.ext_provision_id
		AND asvr.start_date = asvr_rub.start_date 
		AND asvr.end_date = asvr_rub.end_date
		AND asvr_rub.prov_ident = 'spr_porv_msfo_rub'
	WHERE ac.coll_kind_cd IN ('pled_prop','pled_real')
)
SELECT
	  ac.report_dt
	, ac.pledger_id
	, ac.coll_core_main_id
	, ac.coll_core_id
	, ac.coll_abs_id
	, ac.coll_nbr
	, ac.coll_ccy_cd
	, ac.coll_ccy_rate
	, ac.coll_pr_subtype_cd
	, ac.coll_pr_type_cd
	, ac.coll_pr_id
	, ac.coll_pr_nm	
	, ac.coll_fin_oper_code
	, ac.coll_open_dt
	, ac.coll_plan_close_dt
	, ac.coll_fact_close_dt
	, ac.coll_status_cd
	, ac.coll_surety_flg
	, COALESCE(asvr.coll_cs_accept_flg,0) AS coll_cs_accept_flg
	, ac.coll_quality_catg
	, ac.coll_amt
	, ac.coll_amt_rur
	, ac.coll_full_cost 
	, ac.coll_full_cost_rur
	, CASE 
		WHEN asvr.coll_abs_id IS NULL THEN 0
		ELSE 1
	  END AS coll_fair_prior_flg /* При наличии СПРАВЕДЛИВОЙ стоимости в витрине ССО - берем ее в покрытии*/
	, COALESCE(asvr.fair_cost, ac.coll_fair_cost) AS coll_fair_cost
	, COALESCE(asvr.fair_cost_rur, ac.coll_fair_cost_rur) AS coll_fair_cost_rur
	, ac.coll_market_cost
	, ac.coll_market_cost_rur
	, ac.coll_kind_cd
	, CAST(now() AS TIMESTAMP)											AS valid_from_dttm
	, CAST('2100-01-01 00:00:00' AS TIMESTAMP) 							AS valid_to_dttm
	, CAST(t_srs_id AS SMALLINT)										AS t_source_system_id
	, CAST(now() AS timestamp)											AS t_changed_dttm
	, CAST(0 AS TINYINT)												AS t_deleted_flg
	, CAST(1 AS TINYINT)												AS t_active_flg
	, CAST(NULL AS STRING) 	 											AS t_author
	, CAST(NULL AS INTEGER)	 											AS t_process_task_id
FROM asvr_collateral AS ac
LEFT JOIN asvr_fair AS asvr
	ON	asvr.report_dt = ac.report_dt
	AND asvr.coll_abs_id = ac.coll_abs_id
	AND asvr.include_flg = 1
;
/* технические проверки прототипа */
/* Дубли по PK*/
SELECT report_dt, coll_core_id, COUNT(*)
FROM sbx.portfolio_collateral
GROUP BY report_dt, coll_core_id
HAVING COUNT(*) > 1
LIMIT 100
;
/*NULL в PK*/
SELECT *
FROM sbx.portfolio_collateral
WHERE report_dt IS NULL 
OR coll_core_id IS NULL
LIMIT 100

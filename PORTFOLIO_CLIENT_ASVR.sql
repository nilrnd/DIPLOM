/*
Название:	Витрина 2 - Клиент АС ВР
Описание:	Основной массив данных в представляет собой клиентов АС ВР, полученный массив данных дополняется информацией (необходимой для расчета входного вектора) о отрасль, irbf портфель, рейтингах, финансовых показателях, качественных показателях, триггерах дефолта и т.д.
Прототип на выходе формирует витрины:
	1) portfolio_client_asvr_tab - техническая таблица.
	2) portfolio_client_asvr – итоговая пользовательская вью.
-----------------
*/
DROP TABLE IF EXISTS sbx.portfolio_client_asvr_tab 
;
CREATE TABLE IF NOT EXISTS sbx.portfolio_client_asvr_tab
(
	  report_dt						DATE				 	COMMENT 'PK | Дата отчета'
	, client_asvr_id				BIGINT					COMMENT 'NN | Идентификатор клиента из АС ВР'
	, client_core_id				BIGINT					COMMENT 'Идентификатор клиента из core'
	, client_stage_id				BIGINT					COMMENT 'PK | Идентификатор клиента из stage'
	, client_guid 					STRING					COMMENT 'GUID клиента'
	, client_rko_cd					STRING					COMMENT 'Код РКО клиента'
	, crm_abs_id					STRING					COMMENT 'Идентификатор CRM источника'
	, client_type_cd				STRING					COMMENT 'NN | Тип клиента'
	, client_nm						STRING					COMMENT 'NN | Имя клиента'
	, client_inn					STRING					COMMENT 'ИНН клиента'
	, client_country				STRING					COMMENT 'Страна регистрации клиента'
	, client_risk_country			STRING					COMMENT 'Страна основной деятельности контрагента'
	, client_resident_flg			TINYINT					COMMENT 'NN | Признак резидента'
	, client_status					STRING					COMMENT 'NN | Статус клиента'
	, client_public_flg				TINYINT					COMMENT 'NN | Флаг публичного контрагента'
	, client_contractor_flg			TINYINT					COMMENT 'Признак контрактника'
	, client_industry_nm			STRING					COMMENT 'Отрасль клиента'
	, client_large_industry_nm		STRING					COMMENT 'Укрупнённая отрасль клиента'
	, client_irbf_nm				STRING					COMMENT 'Портфель IRBF клиента'
	, calculation_asvr_id			BIGINT					COMMENT 'Идентификатор расчета рейтинга'
	, client_rating_method          STRING                  COMMENT 'Методика расчета PIT'
	, client_rating_pit				STRING					COMMENT 'Внутренний рейтинг PIT'
	, client_pd_pit					DECIMAL(38,17)			COMMENT 'Вероятность дефолта PIT'
	, client_rating_ttc				STRING					COMMENT 'Внутренний рейтинг TTC'
	, client_pd_ttc					DECIMAL(38,17)			COMMENT 'Вероятность дефолта TTC'
	, client_wl						STRING					COMMENT 'Значение из WatchList'
	, grp_stage_id					BIGINT					COMMENT 'Идентификатор группы клиента'
	, client_grp_lnk				STRING					COMMENT 'Тип группы'
	, client_uplift					INT						COMMENT 'Групповой фактор поддержки клиента'
	, client_wgr					DECIMAL(38,17)			COMMENT 'Веса групповой поддержки'
	, client_wgr_kik				DECIMAL(38,17)			COMMENT 'Веса групповой поддержки c учетом КиК'
	, ql_1							STRING					COMMENT 'Поддержка и контроль со стороны акционеров/участников'
	, pled_of_share                 STRING                  COMMENT 'Наличие залога контролирующих (50% +) долей в капитале'
	, assets						DECIMAL(38,17)			COMMENT 'Совокупные Активы'
	, cur_assets					DECIMAL(38,17)			COMMENT 'Оборотные Активы'
	, osnov_srva					DECIMAL(38,17)			COMMENT 'Основные средства'
	, lt_liab						DECIMAL(38,17)          COMMENT	'Долгосрочные обязательства'
	, st_liab						DECIMAL(38,17)			COMMENT 'Среднесрочные обязательства'
	, ebitda_prc					DECIMAL(38,17)			COMMENT 'Ebitda/Проценты к уплате'
	, cash_mean_inv_cur_liab		DECIMAL(38,17)			COMMENT 'Среднее значение денеж. средства к кратк. обязательствам'
	, structure_dolg				DECIMAL(38,17)			COMMENT 'Краткосрочный долг'
	, cash_inv_cur_liab				DECIMAL(38,17)			COMMENT 'Среднее значение денеж. средства и кратк. инвестиции к кратк. обязательствам'
	, cash_inv_cur_liab_mean_ann	DECIMAL(38,17)			COMMENT 'Среднее значение денеж. средства и кратк. инвестиции к кратк. обязательствам (среднее значение за 5 последних квартальных дат)'
	, osnov_srva_td        			DECIMAL(38,17)			COMMENT 'Основные средства заемщика'
    , gross_profit_margin  			DECIMAL(38,17)			COMMENT 'Валовая прибыль/Выручка'
	, default_first_reason			STRING					COMMENT 'Причина дефолта'
	, default_second_reason			STRING					COMMENT 'Причина дефолта'
	, default_start_dt				DATE					COMMENT 'Дата дефолта'
	, day_after_report				INT						COMMENT 'NN | Кол-во дней в дефолте'
	, type_of_model					STRING					COMMENT 'NN | Тип расчета в модели'
/* Технические атрибуты */
	, t_source_system_id			SMALLINT      			COMMENT 'NN | Идентификатор системы-источника'
    , t_changed_dttm				TIMESTAMP      			COMMENT 'NN | Дата и время изменения записи'
    , t_deleted_flg					TINYINT        			COMMENT 'NN | Признак удаления записи'
    , t_author						STRING         			COMMENT 'NN | Имя джоба'
    , t_process_task_id				INT            			COMMENT 'NN | Идентификатор процесса загрузки'
)
COMMENT 'Витрина 2 - Клиент АС ВР'
;
DROP VIEW IF EXISTS sbx.portfolio_client_asvr
;
CREATE VIEW sbx.portfolio_client_asvr
(
	  report_dt						COMMENT 'PK | Дата отчета'
	, client_asvr_id				COMMENT 'NN | Идентификатор клиента из АС ВР'
	, client_core_id				COMMENT 'Идентификатор клиента из core'
	, client_stage_id				COMMENT 'PK | Идентификатор клиента из stage'
	, client_guid 					COMMENT 'GUID клиента'
	, client_rko_cd					COMMENT 'Код РКО клиента'
	, crm_abs_id					COMMENT 'Идентификатор CRM источника'
	, client_type_cd				COMMENT 'NN | Тип клиента'
	, client_nm						COMMENT 'NN | Имя клиента'
	, client_inn					COMMENT 'ИНН клиента'
	, client_country				COMMENT 'Страна регистрации клиента'
	, client_risk_country			COMMENT 'Страна основной деятельности контрагента'
	, client_resident_flg			COMMENT 'NN | Признак резидента'
	, client_status					COMMENT 'NN | Статус клиента'
	, client_public_flg				COMMENT 'NN | Флаг публичного контрагента'
	, client_contractor_flg			COMMENT 'Признак контрактника'
	, client_industry_nm			COMMENT 'Отрасль клиента'
	, client_large_industry_nm		COMMENT 'Укрупнённая отрасль клиента'
	, client_irbf_nm				COMMENT 'Портфель IRBF клиента'
	, calculation_asvr_id			COMMENT 'Идентификатор расчета рейтинга'
	, client_rating_method          COMMENT 'Методика расчета PIT'
	, client_rating_pit				COMMENT 'Внутренний рейтинг PIT'
	, client_pd_pit					COMMENT 'Вероятность дефолта PIT'
	, client_rating_ttc				COMMENT 'Внутренний рейтинг TTC'
	, client_pd_ttc					COMMENT 'Вероятность дефолта TTC'
	, client_wl						COMMENT 'Значение из WatchList'
	, grp_stage_id					COMMENT 'Идентификатор группы клиента'
	, client_grp_lnk				COMMENT 'Тип группы'
	, client_uplift					COMMENT 'Групповой фактор поддержки клиента'
	, client_wgr					COMMENT 'Веса групповой поддержки'
	, client_wgr_kik				COMMENT 'Веса групповой поддержки c учетом КиК'
	, ql_1							COMMENT 'Поддержка и контроль со стороны акционеров/участников'
	, pled_of_share                 COMMENT 'Наличие залога контролирующих (50% +) долей в капитале'
	, assets						COMMENT 'Совокупные активы'
	, cur_assets					COMMENT 'Оборотные активы'
	, osnov_srva					COMMENT 'Основные средства'
	, lt_liab						COMMENT	'Долгосрочные обязательства'
	, st_liab						COMMENT 'Среднесрочные обязательства'
	, ebitda_prc					COMMENT 'Ebitda/Проценты к уплате'
	, cash_mean_inv_cur_liab		COMMENT 'Среднее значение денеж. средств к кратк. обязательствам'
	, structure_dolg				COMMENT 'Краткосрочный долг'
	, cash_inv_cur_liab				COMMENT 'Среднее значение денеж. средств и кратк. инвестиции к кратк. обязательствам'
	, cash_inv_cur_liab_mean_ann	COMMENT 'Среднее значение денеж. средств и кратк. инвестиции к кратк. обязательствам (среднее значение за 5 последних квартальных дат)'
	, osnov_srva_td        			COMMENT 'Основные средства заемщика'
    , gross_profit_margin  			COMMENT 'Валовая прибыль/Выручка'
	, default_first_reason			COMMENT 'Причина дефолта'
	, default_second_reason			COMMENT 'Причина дефолта'
	, default_start_dt				COMMENT 'Дата дефолта'
	, day_after_report				COMMENT 'NN | Количество дней в дефолте'
	, type_of_model					COMMENT 'NN | Тип расчета в модели'
/* Технические атрибуты */
	, t_source_system_id			COMMENT 'NN | Идентификатор системы-источника'
    , t_changed_dttm				COMMENT 'NN | Дата и время изменения записи'
    , t_process_task_id				COMMENT 'NN | Идентификатор процесса загрузки'
)
AS SELECT 
	  report_dt
	, client_asvr_id
	, client_core_id
	, client_stage_id
	, client_guid
	, client_rko_cd
	, crm_abs_id
	, client_type_cd
	, client_nm
	, client_inn
	, client_country
	, client_risk_country
	, client_resident_flg
	, client_status
	, client_public_flg
	, client_contractor_flg
	, client_industry_nm
	, client_large_industry_nm
	, client_irbf_nm
	, calculation_asvr_id
	, client_rating_method
	, client_rating_pit
	, client_pd_pit
	, client_rating_ttc
	, client_pd_ttc
	, client_wl
	, grp_stage_id
	, client_grp_lnk
	, client_uplift
	, client_wgr
	, client_wgr_kik
	, ql_1
	, pled_of_share
	, assets
	, cur_assets
	, osnov_srva
	, lt_liab
	, st_liab
	, ebitda_prc
	, cash_mean_inv_cur_liab
	, structure_dolg
	, cash_inv_cur_liab
	, cash_inv_cur_liab_mean_ann
	, osnov_srva_td
    , gross_profit_margin
	, default_first_reason
	, default_second_reason
	, default_start_dt
	, day_after_report
	, type_of_model
	, t_source_system_id
	, t_changed_dttm
	, t_process_task_id
FROM sbx.portfolio_client_asvr_tab
WHERE t_deleted_flg = 0
;
/* Рейтинги */
DROP TABLE IF EXISTS sbx.portfolio_client_asvr_rating 
;
CREATE TABLE sbx.portfolio_client_asvr_rating AS
WITH pd_scale AS (
	SELECT 
		  rating
		, `mid` AS `value`
	FROM in_manual_corp_models.scale_rating
)
, cur_rat AS (
	SELECT
		  dp.report_dt
		, CAST(rat.contractor_id AS BIGINT) AS client_asvr_id
		, rat.calc_id AS calculation_asvr_id
		, rat.report_dt AS report_date
		, rat.calc_dttm
		, rat.actual_dttm
		, rat.status_name 
		, rat.method_name
		, rat.indicator_name
		, rat.calc_value AS rating
		, CAST(pd.`value` AS DECIMAL(38,17)) AS pd
		, rat.df_calc_type  AS rating_type
 	FROM dm_corp_models.asvr_client_ratings AS rat
	JOIN sbx.ref_params AS dp
	LEFT JOIN pd_scale AS pd
		ON rat.calc_value = pd.rating
  	WHERE rat.status_name IN ('Утвержден', 'Согласован', 'Неактуальный', 'Архив')
		AND dp.report_dt BETWEEN CAST(rat.calc_dttm AS DATE) AND CAST(rat.actual_dttm AS DATE)
		AND rat.calc_value NOT IN ('Без рейтинга', 'D')
		AND rat.df_calc_type IN ('RATING_PIT','RATING_TTC')
)
, rat_d_1 AS (
	SELECT
		  rat.report_dt
		, rat.client_asvr_id
		, rat.calculation_asvr_id
		, rat.report_date
		, rat.calc_dttm
		, rat.actual_dttm
		, rat.status_name
		, rat.method_name
		, rat.indicator_name
		, rat.rating
		, rat.pd
		, rat.rating_type
		, rat.lead_rating
		, CASE
			WHEN rat.rating <> rat.lead_rating
				OR rat.lead_rating IS NULL
				THEN 1
			ELSE 0
		  END AS filter_rating
	FROM (
		SELECT
			  dp.report_dt
			, CAST(contractor_id AS BIGINT) AS client_asvr_id
			, rat.calc_id AS calculation_asvr_id
			, rat.report_dt AS report_date
			, rat.calc_dttm
			, rat.actual_dttm
			, rat.status_name
			, rat.method_name
			, rat.indicator_name
			, calc_value AS rating
			, CAST(pd.`value` AS DECIMAL(38,17)) AS pd
			, rat.df_calc_type  AS rating_type
			, LEAD(calc_value) OVER(PARTITION BY dp.report_dt, CAST(contractor_id AS BIGINT), rat.df_calc_type ORDER BY rat.calc_dttm DESC, rat.actual_dttm DESC) AS lead_rating
		FROM dm_corp_models.asvr_client_ratings AS rat
		JOIN sbx.ref_params AS dp
		LEFT JOIN pd_scale AS pd
			ON rat.calc_value = pd.rating
		WHERE CAST(rat.calc_dttm AS DATE) <= dp.report_dt
			AND rat.calc_value NOT IN ('Без рейтинга')
	) AS rat 
)
, rat_d_2 AS (
	SELECT
		  rat2.report_dt
		, rat2.client_asvr_id
		, rat2.calculation_asvr_id
		, rat2.report_date
		, rat2.calc_dttm
		, rat2.actual_dttm
		, rat2.status_name
		, rat2.method_name
		, rat2.indicator_name
		, rat2.rating
		, rat2.pd
		, rat2.rating_type
		, rat2.lead_rating
		, rat2.filter_rating
	FROM (
		SELECT
			  rat2.report_dt
			, rat2.client_asvr_id
			, rat2.calculation_asvr_id
			, rat2.report_date
			, rat2.calc_dttm
			, rat2.actual_dttm
			, rat2.status_name
			, rat2.method_name
			, rat2.indicator_name
			, rat2.rating
			, rat2.pd
			, rat2.rating_type
			, rat2.lead_rating
			, rat2.filter_rating
			, DENSE_RANK() OVER(PARTITION BY rat2.report_dt, CAST(rat2.client_asvr_id AS BIGINT), rat2.rating_type ORDER BY rat2.calc_dttm DESC, rat2.actual_dttm DESC) AS rn
		FROM rat_d_1 AS rat2
		WHERE rat2.filter_rating = 1
	) AS rat2
	WHERE rat2.rn = 1
	  AND rat2.rating = 'D'
)
, rat AS (
	SELECT
		  r.report_dt
		, r.client_asvr_id
		, r.calculation_asvr_id
		, r.report_date
		, r.calc_dttm
		, r.actual_dttm
		, r.status_name
		, r.method_name
		, r.indicator_name
		, r.rating
		, r.pd
		, r.rating_type
	FROM cur_rat AS r
	UNION ALL
	SELECT
		  rd.report_dt
		, rd.client_asvr_id
		, rd.calculation_asvr_id
		, rd.report_date
		, rd.calc_dttm
		, rd.actual_dttm
		, rd.status_name
		, rd.method_name
		, rd.indicator_name
		, rd.rating
		, rd.pd
		, rd.rating_type
	FROM rat_d_2 AS rd
	WHERE NOT EXISTS (
		SELECT 1
		FROM cur_rat AS r
		WHERE r.report_dt = rd.report_dt
			AND r.client_asvr_id = rd.client_asvr_id
	)
)
, rat1 AS (
	SELECT
		  rat.report_dt
		, rat.client_asvr_id
		, rat.calculation_asvr_id
		, rat.report_date
		, rat.calc_dttm
		, rat.actual_dttm
		, rat.method_name
		, rat.indicator_name
		, rat.rating
		, rat.pd
		, rat.status_name
		, rat.rating_type
		, ROW_NUMBER() OVER(PARTITION BY rat.report_dt, rat.client_asvr_id, rat.rating_type
								ORDER BY
									DECODE(rat.status_name
										   , 'Утвержден', 1
										   , 'Согласован', 2
										   , 'Неактуальный', 3
										   , 'Архив', 4) 
						            , rat.calc_dttm DESC
						            , rat.actual_dttm DESC
							) AS rnk
	FROM  rat
)
SELECT
	  rat1.report_dt
	, rat1.client_asvr_id
	, rat1.calculation_asvr_id
	, rat1.report_date
	, rat1.calc_dttm
	, rat1.actual_dttm
	, rat1.method_name
	, rat1.indicator_name
	, rat1.rating
	, rat1.pd
	, rat1.status_name
	, rat1.rating_type
FROM  rat1
WHERE rat1.rnk = 1
;
/* Финансовые фичи на основе фин отчености */
DROP TABLE IF EXISTS sbx.lgd_finrep_feature_input 
;
CREATE TABLE sbx.lgd_finrep_feature_input AS 
WITH rat as (
	SELECT
		  dp.report_dt
		, r.client_asvr_id
		, r.report_date
	FROM sbx.portfolio_client_asvr_rating AS r 
	JOIN sbx.ref_params AS dp
		ON r.report_dt = dp.report_dt
	WHERE r.rating_type IS NOT NULL
	GROUP BY
		  dp.report_dt
		, r.client_asvr_id
		, r.report_date
)
, finrep_feature_actual AS (
	SELECT
	      dp.report_dt
	    , ff.ea_asvr_id
	    , ff.repdate
	    , MAX(CASE
				WHEN ff.feature_nm = 'cash_inv_cur_liab_mean_ann_w_rent' 
					THEN ff.feature_value 
			END) AS cash_mean_inv_cur_liab
	    , MAX(CASE
				WHEN ff.feature_nm = 'structure_dolg'
					THEN ff.feature_value 
			END) AS structure_dolg
	    , MAX(CASE
				WHEN ff.feature_nm = 'cash_inv_cur_liab'
					THEN ff.feature_value 
			END) AS cash_inv_cur_liab
		, MAX(CASE
				WHEN ff.feature_nm = 'cash_inv_cur_liab_mean_ann'
					THEN ff.feature_value 
			END) AS cash_inv_cur_liab_mean_ann
		, MAX(CASE
				WHEN ff.feature_nm = 'EBITDA_prc'
					THEN ff.feature_value 
			END) AS ebitda_prc
		, MAX(CASE
				WHEN ff.feature_nm = 'osnov_srva_td'
					THEN ff.feature_value 
			END) AS osnov_srva_td
		, MAX(CASE
				WHEN ff.feature_nm = 'gross_profit_margin'
					THEN ff.feature_value 
			END) AS gross_profit_margin
		, MAX(CASE 
				WHEN r.report_dt is not null  /* Если отчетность равна расчету */
					THEN 1
			    WHEN datediff(dp.report_dt, ff.repdate) / 365 <=  2 /* Если отчетности не более два года */
					THEN 2
			    ELSE null
			END) AS actual
	FROM dm_corp_models.finrep_feature AS ff
	JOIN sbx.ref_params AS dp
	LEFT JOIN rat AS r
		ON	r.report_dt = dp.report_dt
		AND r.report_date = ff.repdate 
		AND r.client_asvr_id = ff.ea_asvr_id
	WHERE ff.repdate <= dp.report_dt
	GROUP BY
		  dp.report_dt
		, ff.ea_asvr_id
		, ff.repdate
)
, finrep_feature AS (
	SELECT
		  t.report_dt
	    , t.ea_asvr_id
	    , t.repdate
	    , t.cash_mean_inv_cur_liab
	    , t.structure_dolg
	    , t.cash_inv_cur_liab
		, t.cash_inv_cur_liab_mean_ann
		, t.ebitda_prc
		, t.osnov_srva_td
		, t.gross_profit_margin
		, t.actual
	FROM finrep_feature_actual AS t
	WHERE t.actual IS NOT NULL
)
, finrep_feature_sort AS (
	SELECT 
		  ff.report_dt
		, ff.ea_asvr_id
		, ff.repdate
		, ff.cash_mean_inv_cur_liab
		, ff.structure_dolg
		, ff.cash_inv_cur_liab
		, ff.cash_inv_cur_liab_mean_ann
		, ff.ebitda_prc
		, ff.osnov_srva_td
		, ff.gross_profit_margin
		, ROW_NUMBER() OVER(PARTITION BY ff.report_dt, ff.ea_asvr_id ORDER BY ff.actual, ff.repdate DESC) AS rn
	FROM  finrep_feature AS ff
)
SELECT
	  ff.report_dt
	, ff.ea_asvr_id
	, ff.repdate
	, ff.cash_mean_inv_cur_liab
	, ff.structure_dolg
	, ff.cash_inv_cur_liab
	, ff.cash_inv_cur_liab_mean_ann
	, ff.ebitda_prc
	, ff.osnov_srva_td        /* Основные средства заемщика */
    , ff.gross_profit_margin  /* Валовая прибыль/Выручка */
FROM finrep_feature_sort AS ff
WHERE ff.rn = 1
;
/* Финансовая отчетность */
drop table if EXISTS sbx.finrep_stat_input 
;
create table sbx.finrep_stat_input AS 
WITH rat as (
	SELECT
		  dp.report_dt
		, r.client_asvr_id
		, r.report_date
	FROM sbx.portfolio_client_asvr_rating AS r
	JOIN sbx.ref_params AS dp
		ON r.report_dt = dp.report_dt
	WHERE r.rating_type IS NOT NULL
	GROUP BY
		  dp.report_dt
		, r.client_asvr_id
		, r.report_date
)
, fst_actual AS (
	SELECT
		  dp.report_dt
		, fst.repdate
		, fst.ea_asvr_id
		, fst.cur_assets	/* Оборотные Активы */
		, fst.ebitda
		, fst.int_pay		/* Проценты к уплате*/
		, fst.osnov_srva	/* Основные средства*/
		, fst.assets		/* Совокупные Активы*/
		, fst.lt_liab           /* Долгосрочные обязательства*/
		, fst.st_liab 			/* Среднесрочные обязательства*/															  
		, CASE
			WHEN r.report_dt IS NOT NULL  /* Если отчетность равна расчету */
		       THEN 1
			WHEN DATEDIFF(dp.report_dt, fst.repdate) / 365 <=  2
		       THEN 2
			ELSE NULL
		  END AS actual
	FROM dm_corp_models.finrep_stat_t AS fst
	JOIN sbx.ref_params AS dp
	LEFT JOIN rat AS r
		ON	r.report_dt = dp.report_dt
		AND r.report_date = fst.repdate
		AND r.client_asvr_id = fst.ea_asvr_id
	WHERE fst.repdate <= dp.report_dt
		AND fst.cur_cd='RUB'
)
, fst AS (
	SELECT
		  t.report_dt
		, t.repdate
		, t.ea_asvr_id
		, t.cur_assets
		, t.osnov_srva	/* Основные средства */
		, t.assets		/* Совокупные Активы */
		, t.lt_liab
		, t.st_liab
	    , ROW_NUMBER() OVER(PARTITION BY t.report_dt, t.ea_asvr_id ORDER BY t.actual, t.repdate DESC) AS rn
	FROM fst_actual AS t
	WHERE t.actual IS NOT NULL
)
SELECT
	  fst.report_dt
	, fst.ea_asvr_id AS client_asvr_id
	, fst.repdate		/* Дата фин отчености */
	, fst.cur_assets	/* Оборотные Активы */
	, fst.osnov_srva	/* Основные средства */
	, fst.assets		/* Совокупные Активы */
	, fst.lt_liab		/* Долгосрочные обязательства */
	, fst.st_liab		/* Среднесрочные обязательства */
FROM  fst 
WHERE rn = 1
;
/* Данные реестра дефолтов */
DROP TABLE IF EXISTS sbx.lgd_reestr_defaults_input 
;
CREATE TABLE sbx.lgd_reestr_defaults_input AS 
WITH rd1 AS (
	SELECT
		  dp.report_dt
		, rdt.asvr_id
		, rdt.default_trigger_first_reason          AS default_first_reason
		, rdt.default_trigger_type                  AS default_second_reason
		, CAST(rdt.default_trigger_type_num AS INT) AS default_type_num
		, rdt.default_trigger_start_dt              AS default_start_dt
		, rdt.default_trigger_end_dt                AS default_end_dt
		, 'trg'                                     AS default_tab
	FROM dm_corp_models.reestr_default_triggers AS rdt
	JOIN sbx.ref_params AS dp
	WHERE dp.report_dt BETWEEN rdt.default_trigger_start_dt AND rdt.default_trigger_end_dt
	
	UNION 
	SELECT
		  dp.report_dt
		, rd.asvr_id
		, rd.default_first_reason
		, rd.default_first_reason_type
		, rd.default_first_reason_type_num
		, rd.default_start_dt
		, rd.default_end_dt
		, 'reestr'
	FROM dm_corp_models.reestr_defaults AS rd
		JOIN sbx.ref_params AS dp
	WHERE dp.report_dt BETWEEN rd.default_start_dt AND rd.default_end_dt
)
, rd2 AS (
	SELECT
		  rd1.report_dt
		, rd1.asvr_id 
		, rd1.default_first_reason
		, rd1.default_second_reason
		, rd1.default_type_num
		, rd1.default_start_dt
		, rd1.default_end_dt,default_tab
		, ROW_NUMBER() OVER(PARTITION BY rd1.report_dt, rd1.asvr_id
								ORDER BY rd1.default_start_dt) AS rn
	FROM rd1
	WHERE rd1.default_first_reason IN ('D', 'Плохое')
)
SELECT
	  rd2.report_dt
	, rd2.asvr_id
	, rd2.default_first_reason
	, rd2.default_second_reason
	, rd2.default_type_num
	, rd2.default_start_dt
	, rd2.default_end_dt
	, rd2.default_tab
FROM rd2 
WHERE rd2.rn = 1
;
DROP TABLE IF EXISTS sbx.portfolio_client_asvr_cntr_lnk 
;
CREATE TABLE IF NOT EXISTS sbx.portfolio_client_asvr_cntr_lnk AS
/* контрактники */
SELECT
	  dp.report_dt
	, CAST(cl.asvr_id AS BIGINT) AS client_asvr_id
FROM sbx.ref_params AS dp
JOIN dm_korpro.data_factory_object AS fo
	ON	dp.report_dt BETWEEN NVL(TRUNC(fo.date_created, 'dd'), '1900-01-01') AND NVL(TRUNC(fo.date_end,'dd'), '4000-12-31')
JOIN dm_korpro.contractor_link AS cl
	ON	cl.rating_id = fo.rating_id 
	AND dp.report_dt BETWEEN NVL(TRUNC(cl.date_created, 'dd'), '1900-01-01') AND NVL(TRUNC(cl.date_end,'dd'), '4000-12-31')
JOIN dm_korpro.data_factory_object_value AS fov
	ON	fo.id = fov.data_factory_object_id
	AND fov.data_factory_attr_code = 'is_contractor' 
	AND fov.`value` = 'EG_PRSIGN_OSHFO60_YES'
GROUP BY 
	  dp.report_dt
	, cl.asvr_id
;
INSERT INTO sbx.portfolio_client_asvr_tab
(
  report_dt
	, client_asvr_id
	, client_core_id
	, client_stage_id
	, client_guid
	, client_rko_cd
	, crm_abs_id
	, client_type_cd
	, client_nm
	, client_inn
	, client_country
	, client_risk_country
	, client_resident_flg
	, client_status
	, client_public_flg
	, client_contractor_flg
	, client_industry_nm
	, client_large_industry_nm
	, client_irbf_nm
	, calculation_asvr_id
	, client_rating_method
	, client_rating_pit
	, client_pd_pit
	, client_rating_ttc
	, client_pd_ttc
	, client_wl
	, grp_stage_id
	, client_grp_lnk
	, client_uplift
	, client_wgr
	, client_wgr_kik
	, ql_1
	, pled_of_share
	, assets
	, cur_assets
	, osnov_srva
	, lt_liab
	, st_liab
	, ebitda_prc
	, cash_mean_inv_cur_liab
	, structure_dolg
	, cash_inv_cur_liab
	, cash_inv_cur_liab_mean_ann
	, osnov_srva_td
    , gross_profit_margin
	, default_first_reason
	, default_second_reason
	, default_start_dt
	, day_after_report
	, type_of_model
	, t_source_system_id
	, t_changed_dttm
	, t_deleted_flg
    , t_author
	, t_process_task_id
)
WITH status AS (
    /* Статусы контрагента */
	SELECT
		  cs.contractor_id AS client_stage_id
		, cs.status_id
		, s.name AS status
	FROM dm_stage_nsal.contractor_status AS cs
	JOIN dm_stage_nsal.status AS s
		ON	s.status_id = cs.status_id 
		AND s.source_system_id = 318
		AND s.changed < 3
	WHERE cs.source_system_id = 318
		AND cs.changed < 3	
		AND s.name IN ('Утвержден', 'Согласован', 'Черновик', 'Архив')
)
, guid_crm AS (
	SELECT
		  l.contractor_id AS client_stage_id
		, l.guid AS client_guid
		, crm1.abs_id AS crm_abs_id
	FROM dm_stage_nsal.legal AS l
	/* Переход на мастер-клиента CRM */                 
	LEFT JOIN dm_stage_nsal.contractor_link AS cl1
		ON	l.contractor_id = cl1.child_contractor_id 
		AND cl1.changed < 3
		AND cl1.source_system_id = 301 
		AND cl1.parent_role_id = 197463 /* MASTER CLIENT ROLE */
	LEFT JOIN dm_stage_nsal.contractor AS crm1 
		ON	cl1.parent_contractor_id = crm1.contractor_id 
		AND crm1.changed < 3
		AND crm1.source_system_id = 301
	WHERE l.source_system_id = 318
		AND l.changed < 3
)
, lnk AS (
	SELECT
		  cl.report_dt
		, cl.client_stage_id
		, cl.source_system_id
	FROM (
		SELECT
			  dp.report_dt
			, cl.child_contractor_id AS client_stage_id
			, cl.source_system_id
			, ROW_NUMBER() OVER (PARTITION BY dp.report_dt, cl.child_contractor_id
									 ORDER BY cl.start_date) AS cnt
		FROM sbx.ref_params AS dp 
		JOIN dm_stage_nsal.contractor_link AS cl 
		WHERE dp.report_dt BETWEEN cl.start_date AND cl.final_date
	        AND cl.changed < 3
	        AND cl.source_system_id IN (300)
	) AS cl 
	WHERE cl.cnt = 1 	
)
, client_attr AS (
/* Основные атрибуты контрагента */
	SELECT 
		  dp.report_dt
		, cntr.id 								AS client_asvr_id
		, c.contractor_id          				AS client_stage_id
		, c.contractor_core_id     				AS client_core_id
		, TRIM(cntr.short_name)					AS client_nm
		, cntr.inn								AS client_inn
		, CAST(cntr.country_id AS BIGINT)		AS country_id
		, cntry.name AS client_country
		, main_cntry.name AS client_risk_country
		, CASE
				WHEN COALESCE(cntr.country_id,-1) = 1000455856 AND COALESCE(obj.par_obj_id,-1) = 1000455856 /* РОССИЯ */
				THEN 1
				ELSE 0
		  END as client_resident_flg /* страна основной деятельности и страна контрагента - Россия => резидент */
		, cntr.client_type_ident 				AS client_type_cd
		, gc.client_guid
		, cntr.kod_abs 							AS client_rko_cd
		, gc.crm_abs_id
		, cntr.status
		, wl.category_bl 						AS category_wl
		, 318									AS source_system_id
		, COUNT(*) OVER (PARTITION BY dp.report_dt, c.contractor_core_id) AS client_cnt
	FROM dm_asvr_ultra_gpb_d.v_ext_l_contractor_spr AS cntr
	JOIN sbx.ref_params AS dp
	JOIN dm_stage_nsal.contractor AS c
		ON	CAST(c.abs_id AS BIGINT) = cntr.id
		AND c.changed < 3
		AND c.source_system_id = 318
	LEFT JOIN guid_crm AS gc
		ON	gc.client_stage_id = c.contractor_id
	JOIN status st
		ON	st.client_stage_id = c.contractor_id /* Только в статусе [Черновик, Утвержден, Согласован] */
	LEFT JOIN dm_asvr_ultra_gpb_d.v_ext_tmp_wl AS wl
		ON cntr.id = wl.id_org 
		AND dp.report_dt BETWEEN wl.date_include AND wl.date_exclude
	LEFT JOIN dm_asvr_ultra_gpb_d.v_ext_contractor_attrs_obj obj
		ON	cntr.id = obj.obj_id 
		AND dp.report_dt BETWEEN obj.start_date AND obj.end_date 
		AND obj.attr_id = 1300375385 /* Страна основной деятельности (принятия риска) */
	LEFT JOIN dm_asvr_ultra_gpb_d.v_ext_country_spr main_cntry
		ON	main_cntry.id = obj.par_obj_id 
	LEFT JOIN dm_asvr_ultra_gpb_d.v_ext_country_spr cntry
		ON	cntry.id = cntr.country_id
)
, industry AS (
	SELECT 
		  i.obj_id						AS client_asvr_id
		, CAST(i.start_date AS DATE) 	AS start_date
		, CAST(i.end_date AS DATE) 		AS end_date
		, i.name						AS industry
		, li.master_name				AS large_industry
	FROM dm_asvr_ultra_gpb_d.v_ext_contractor_attrs_mval AS i
	LEFT JOIN dm_asvr_ultra_gpb_d.v_ext_branch_spr AS li
		ON i.`key` = li.id
	WHERE i.ident = 'ATTR_SECTOR'
)
, risk_segment AS (
	SELECT
		  client_asvr_id
		, IF(rn_num = 1, '1900-01-01', start_dt) AS start_dt /*для первой записи делаем начало 1900.01.01, чтобы максимально охватить периоды */
		, end_dt
		, name
	FROM (
		SELECT 
			  cav.obj_id AS client_asvr_id
			, cav.nvalue
			, TO_DATE(cav.start_date) AS start_dt
			, TO_DATE(cav.end_date) AS end_dt
			, mir.name
			, ROW_NUMBER() OVER(PARTITION BY cav.obj_id 
									ORDER BY TO_DATE(cav.start_date)
							   ) AS rn_num
		FROM dm_asvr_ultra_gpb_d.v_ext_contractor_attrs_val AS cav
		LEFT JOIN dm_asvr_ultra_gpb_d.v_ext_mis_irbf_refer AS mir
			ON cav.nvalue = CAST(mir.id AS STRING)
		WHERE cav.ident IN ('ATTR_IRBF')
		) t
)
, reg_top_grp AS ( 
	SELECT 
		  rp.report_dt
		, grp.contractor_asvr_id AS client_asvr_id
		, grp.group_id AS client_grp_id
		, grp.link_hierarchy_lvl 
		, ROW_NUMBER() OVER (partition by rp.report_dt,grp.contractor_asvr_id order by grp.link_hierarchy_lvl desc) AS top_rn /* Топ группа */
	FROM sbx.asvr_group_hierarchy AS grp
	JOIN sbx.ref_params AS rp
		ON rp.report_dt BETWEEN grp.period_from_dt AND grp.period_to_dt
)
/* Контрагент */
SELECT
	  a.report_dt
	, a.client_asvr_id
	, a.client_core_id
	, a.client_stage_id
	/* Связь с MIS */
	, a.client_guid
	, a.client_rko_cd
	, a.crm_abs_id
	, a.client_type_cd
	, a.client_nm
	, a.client_inn
	, a.client_country
	, a.client_risk_country
	, a.client_resident_flg
	, a.status              	AS client_status
	, CASE
		WHEN regexp_like(UPPER(a.client_nm),  '^\\s*\[(]*(АО|ОАО|НАО|ПАО|КАО|JSC|IPJSC)\[)]*\\s+')
			THEN 1
		WHEN regexp_like(UPPER(a.client_nm), '\\s+\[(]*(АО|ОАО|НАО|ПАО|КАО|КАО|JSC|IPJSC)\[)]*$')
           THEN 1
		ELSE 0
	  END                    	AS client_public_flg	/* Флаг публичного контрагента  */
	, CASE
		WHEN cl.client_asvr_id IS NOT NULL
			THEN 1
		ELSE 0
	  END						AS client_contractor_flg	/* Контрактник */
	/* Отрасль */
	, i.industry        		AS client_industry_nm
	, i.large_industry  		AS client_large_industry_nm
	/* IRBF группа */
	, irbf.name					AS client_irbf_nm
	/* Рейтинг pit */
	, rp.calculation_asvr_id	AS calculation_asvr_id
	, rp.method_name            AS client_rating_method
	, rp.rating               	AS client_rating_pit
	, rp.pd                   	AS client_pd_pit
	/* Рейтинг ttc */
	, rt.rating               	AS client_rating_ttc
	, rt.pd                   	AS client_pd_ttc       
	/* wl лист */
	, a.category_wl          	AS client_wl
	/* Группы рег и топ */
	, COALESCE(rg.client_grp_id, tp.client_grp_id) 		AS grp_stage_id
	, CASE 
		WHEN rg.client_grp_id IS NOT NULL THEN 'reg_grp'
		WHEN tp.client_grp_id IS NOT NULL THEN 'top_grp'
		ELSE NULL
	  END AS client_grp_lnk
	/* Групповые факторы */
	, qf.uplift              					AS client_uplift
	, qf.wgr                 					AS client_wgr
	, qf.wgr_kik             					AS client_wgr_kik
	/* Качественные факторы */
	, qf.ql_1
	, qf.pled_of_share
	/* Сводные статьи */
	, CAST(fsi.assets AS DECIMAL(38,17)) 		AS assets		/* Совокупные Активы */
	, CAST(fsi.cur_assets AS DECIMAL(38,17)) 	AS cur_assets	/*  Оборотные Активы */
	, CAST(fsi.osnov_srva AS DECIMAL(38,17)) 	AS osnov_srva	/* Основные средства */
	, CAST(fsi.lt_liab AS DECIMAL(38,17))       AS lt_liab
	, CAST(fsi.st_liab AS DECIMAL(38,17))       AS st_liab
	/* Финансовые факторы */
	, ff.ebitda_prc	/* Ebitda/Проценты к уплате */
	, ff.cash_mean_inv_cur_liab
	, ff.structure_dolg
	, ff.cash_inv_cur_liab
	, ff.cash_inv_cur_liab_mean_ann 
	, ff.osnov_srva_td        									/* Основные средства заемщика */
    , ff.gross_profit_margin  									/* Валовая прибыль / Выручка */
	/* Данные по дефолту */
	, IF(rp.rating= 'D', df.default_first_reason, NULL) AS default_first_reason
	, IF(rp.rating= 'D', df.default_second_reason, NULL) AS default_second_reason
	, IF(rp.rating= 'D', df.default_start_dt, NULL) AS default_start_dt
	/* Тип модели */
	, NVL(DATEDIFF(a.report_dt, CASE
									WHEN df.default_first_reason IS NOT NULL 
										AND rp.rating = 'D' 
										THEN df.default_start_dt
									WHEN df.default_first_reason IS NULL
										AND rp.rating = 'D' 
										THEN rp.calc_dttm 
								END), 0) AS day_after_report 
	, CASE
		WHEN NVL(rp.rating, rt.rating) = 'D'
            THEN 'in default'
            ELSE 'longrun' 
	  END AS type_of_model
	/* Тех поля */
	, a.source_system_id
	, CAST(now() AS timestamp) AS t_changed_dttm
	, CAST(0 AS TINYINT) AS t_deleted_flg
	, CAST('portfolio_client_asvr' AS STRING) AS t_author
	, CAST(NULL AS INTEGER) AS t_process_task_id
FROM client_attr AS a
/* Связь с внешней системой */
LEFT JOIN lnk AS l
	ON l.report_dt = a.report_dt
	AND l.client_stage_id = a.client_stage_id
LEFT JOIN industry AS i
	ON	a.client_asvr_id = i.client_asvr_id
	AND a.report_dt BETWEEN i.start_date AND i.end_date 
LEFT JOIN risk_segment AS irbf 
	ON	a.client_asvr_id = irbf.client_asvr_id
	AND a.report_dt BETWEEN irbf.start_dt AND irbf.end_dt 
LEFT JOIN sbx.portfolio_client_asvr_rating AS rp
	ON	rp.report_dt = a.report_dt
	AND rp.client_asvr_id = a.client_asvr_id
	AND rp.rating_type = 'RATING_PIT'
/* Рейтинги ttc */
LEFT JOIN sbx.portfolio_client_asvr_rating AS rt
	ON	rt.report_dt = a.report_dt
	AND rt.client_asvr_id = a.client_asvr_id
	AND rt.rating_type = 'RATING_TTC'
/* Витрина качественных факторов */
LEFT JOIN sbx.rating_calc_indicators AS qf
	ON	a.client_asvr_id = qf.client_asvr_id 
	AND rp.calculation_asvr_id = qf.calculation_asvr_id 
/* Витрина финансовых факторов */
LEFT JOIN sbx.lgd_finrep_feature_input AS ff
	ON	ff.report_dt = a.report_dt
	AND ff.ea_asvr_id = a.client_asvr_id
/* Данные реестра дефолтов */
LEFT JOIN sbx.lgd_reestr_defaults_input AS df
	ON	df.report_dt = a.report_dt
	AND df.asvr_id = a.client_asvr_id 
/* Сводные статьи */
LEFT JOIN sbx.finrep_stat_input AS fsi
	ON	fsi.report_dt = a.report_dt
	AND fsi.client_asvr_id = a.client_asvr_id 
/* Рег группы */
LEFT JOIN reg_top_grp AS rg
	ON	rg.report_dt = a.report_dt
	AND rg.client_asvr_id = a.client_asvr_id
	AND rg.link_hierarchy_lvl = 1
	AND a.client_type_cd <> 'GROUP_OF_COMPANIES'
/* Топ группы */
LEFT JOIN reg_top_grp AS tp
	ON	tp.report_dt = a.report_dt
	AND tp.client_asvr_id = a.client_asvr_id
	AND tp.top_rn = 1 
	AND a.client_type_cd = 'GROUP_OF_COMPANIES'
LEFT JOIN sbx.portfolio_client_asvr_cntr_lnk AS cl
	ON	cl.report_dt = a.report_dt
	AND cl.client_asvr_id = a.client_asvr_id
WHERE (a.client_cnt = 1
   OR (a.client_cnt > 1 AND l.source_system_id = 300))
;
/* технические проверки прототипа */
/* Дубли по PK */
SELECT report_dt,client_stage_id, COUNT(*)
FROM sbx.portfolio_client_asvr AS c
GROUP BY report_dt,client_stage_id
HAVING COUNT(*) > 1
LIMIT 100
;
/* NULL в PK */
SELECT *
FROM sbx.portfolio_client_asvr
WHERE report_dt IS NULL 
OR client_stage_id IS NULL
LIMIT 100

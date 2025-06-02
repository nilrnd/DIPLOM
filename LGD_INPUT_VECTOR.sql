/*
Название:	Витрина 7 - Входной вектор в модель
Описание:	Основной массив данных представляет собой входную витрину подаваемую на вход модели (GPB-CRD-LGD-CE-3.0) расчета значений LGD (агрегат Витрины 6 - Факторы покрытия обогащённой информацией из Витрина 2 - Клиент АС ВР).
	1) lgd_input_vector_tab - техническая таблица с типом хранения данных SCD-2.
	2) lgd_input_vector – итоговая пользовательская вью.
--------------------
*/
DROP TABLE IF EXISTS sbx.lgd_input_vector_tab 
;
CREATE TABLE IF NOT EXISTS sbx.lgd_input_vector_tab
(
	  report_dt						DATE				COMMENT 'PK | Отчетная дата'
	, client_core_id				BIGINT				COMMENT 'PK | Идентификатор клиента из core'
	, client_asvr_id				BIGINT				COMMENT 'NN | Идентификатор клиента из АС ВР'
	, client_exp_mod_flg            INT                 COMMENT 'Признак экспертного рейтинга'
	, client_irbf_nm_up_wgr_kik		STRING				COMMENT 'IRBF сегмент КиК'
	, client_ind_nm_up_wgr_kik		STRING				COMMENT 'Отрасль КиК'
	, client_lrg_ind_nm_bucket		STRING				COMMENT 'NN | Корзина вхождение укрупнённой отрасли контрагента с учетом группы'
	, client_public_flg				TINYINT				COMMENT 'NN | Флаг публичности контрагента'
	, deal_core_id					BIGINT				COMMENT 'PK | Идентификатор сделки из core'
	, deal_abs_id					BIGINT				COMMENT 'NN | Идентификатор сделки из АБС'
	, deal_num						STRING				COMMENT 'NN | Номер сделки'
	, deal_ebg_flg                  INT                 COMMENT 'Признак электронной банковской гарантии'
	, ead							DECIMAL(38,17)		COMMENT 'NN | Прогнозируемая сумма убытков, в случае неисполнение должником ссуды'
	, ead_with_grp					DECIMAL(38,17)		COMMENT 'Сумма долга по группе/клиенту'
	, deal_cover_part      			DECIMAL(38,17)      COMMENT 'Доля покрытия сделки категорийными поручителями, депозитом и ценными бумагами'
	, imush_nedv_pai_to_ead_corr    DECIMAL(38,17)		COMMENT 'Доля обеспечения недвижимости, имущества и паев в EAD'
	, pai_all_flg					TINYINT				COMMENT 'NN | Флаг наличия на сделки паев и ЦБ'
	, osnov_srva_ead				DECIMAL(38,17)		COMMENT 'Основные средства/EAD'
	, cur_assets_ead				DECIMAL(38,17)		COMMENT 'Оборотные активы/EAD'
	, cur_assets_with_grp_ead		DECIMAL(38,17)		COMMENT 'Оборотные активы с учетом группы/EAD'
	, osnov_srva_td_grp				DECIMAL(38,17)		COMMENT 'Основные средства с учетом группы/Total Debt с учетом группы'
	, gross_prof_margin_grp			DECIMAL(38,17)		COMMENT 'Валовая прибыль с учетом группы/Выручка с учетом группы'
	, cash_inv_cur_liab_mean_ann	DECIMAL(38,17)		COMMENT 'Среднее значение денеж. средств и кратк. инвестиции к кратк. обязательствам с учетом группы'
	, ebitda_prc					DECIMAL(38,17)		COMMENT 'Ebitda/Проценты к уплате'
	, ql_1							STRING				COMMENT 'Поддержка и контроль со стороны акционеров/участников'
	, default_first_reason			STRING				COMMENT 'Причина дефолта'
	, default_second_reason			STRING				COMMENT 'Причина дефолта'
	, day_after_report				INT					COMMENT 'NN | Кол-во дней в дефолте (Кол-во дней после присвоения рейтинга D)'
	, client_liq_flg				TINYINT				COMMENT 'NN | Факт наличия признака/отсутствия ликвидации заемщика в Watch List'
	, var_1							TINYINT				COMMENT 'NN | Корзина распределения клиента по IRBF сегмент'
	, type_of_model					STRING 				COMMENT 'NN | Тип расчета в модели'
/* Технические атрибуты */
	, valid_from_dttm				TIMESTAMP			COMMENT 'NN | Дата и время начала действия технической версии записи'
	, valid_to_dttm					TIMESTAMP			COMMENT 'NN | Дата и время окончания действия технической версии записи'
	, t_source_system_id        	SMALLINT			COMMENT 'NN | Идентификатор системы-источника'
    , t_changed_dttm            	TIMESTAMP			COMMENT 'NN | Дата и время изменения записи'
	, t_deleted_flg             	TINYINT        		COMMENT 'NN | Признак удаления записи'
	, t_active_flg					TINYINT				COMMENT 'NN | Признак активной записи'
    , t_author                  	STRING         		COMMENT 'NN | Имя джоба'
    , t_process_task_id         	INT					COMMENT 'NN | Идентификатор процесса загрузки'
) 
COMMENT 'Витрина 7 - Входной вектор в модель'
;
DROP VIEW IF EXISTS sbx.lgd_input_vector
;
CREATE VIEW sbx.lgd_input_vector
(
	  report_dt						COMMENT 'PK | Отчетная дата'
	, client_core_id				COMMENT 'PK | Идентификатор клиента из core'
	, client_asvr_id				COMMENT 'NN | Идентификатор клиента из АС ВР'
	, client_exp_mod_flg            COMMENT 'Признак экспертного рейтинга'
	, client_irbf_nm_up_wgr_kik		COMMENT 'IRBF сегмент КиК'
	, client_ind_nm_up_wgr_kik		COMMENT 'Отрасль КиК'
	, client_lrg_ind_nm_bucket		COMMENT 'NN | Корзина вхождение укрупнённой отрасли контрагента с учетом группы'
	, client_public_flg				COMMENT 'NN | Флаг публичности контрагента'
	, deal_core_id					COMMENT 'PK | Идентификатор сделки из core'
	, deal_abs_id					COMMENT 'NN | Идентификатор сделки из АБС'
	, deal_num						COMMENT 'NN | Номер сделки'
	, deal_ebg_flg                  COMMENT 'Признак электронной банковской гарантии'
	, ead							COMMENT 'NN | Прогнозируемая сумма убытков, в случае неисполнение должником ссуды'
	, ead_with_grp					COMMENT 'Сумма долга по группе/клиенту'
	, deal_cover_part      			COMMENT 'Доля покрытия сделки категорийными поручителями, депозитом и ценными бумагами'
	, imush_nedv_pai_to_ead_corr    COMMENT 'Доля обеспечения недвижимости, имущества и паев в EAD'
	, pai_all_flg					COMMENT 'NN | Флаг наличия на сделки паев и ЦБ'
	, osnov_srva_ead				COMMENT 'Основные средства/EAD'
	, cur_assets_ead				COMMENT 'Оборотные активы/EAD'
	, cur_assets_with_grp_ead		COMMENT 'Оборотные активы с учетом группы/EAD'
	, osnov_srva_td_grp				COMMENT 'Основные средства с учетом группы/Total Debt с учетом группы'
	, gross_prof_margin_grp			COMMENT 'Валовая прибыль с учетом группы/Выручка с учетом группы'
	, cash_inv_cur_liab_mean_ann	COMMENT 'Среднее значение денеж. средств и кратк. инвестиции к кратк. обязательствам с учетом группы'
	, ebitda_prc					COMMENT 'Ebitda/Проценты к уплате'
	, ql_1							COMMENT 'Поддержка и контроль со стороны акционеров/участников'
	, default_first_reason			COMMENT 'Причина дефолта'
	, default_second_reason			COMMENT 'Причина дефолта'
	, day_after_report				COMMENT 'NN | Кол-во дней в дефолте (Кол-во дней после присвоения рейтинга D)'
	, client_liq_flg				COMMENT 'NN | Факт наличия признака/отсутствия ликвидации заемщика в Watch List'
	, var_1							COMMENT 'NN | Корзина распределения клиента по IRBF сегмент'
	, type_of_model					COMMENT 'NN | Тип расчета в модели'
/* Технические атрибуты */
	, t_source_system_id        	COMMENT 'NN | Идентификатор системы-источника'
    , t_changed_dttm            	COMMENT 'NN | Дата и время изменения записи'
    , t_process_task_id         	COMMENT 'NN | Идентификатор процесса загрузки'
)
AS SELECT
	  report_dt
	, client_core_id
	, client_asvr_id
	, client_exp_mod_flg
	, client_irbf_nm_up_wgr_kik
	, client_ind_nm_up_wgr_kik
	, client_lrg_ind_nm_bucket
	, client_public_flg
	, deal_core_id
	, deal_abs_id
	, deal_num
	, deal_ebg_flg
	, ead
	, ead_with_grp
	, deal_cover_part
	, imush_nedv_pai_to_ead_corr
	, pai_all_flg
	, osnov_srva_ead
	, cur_assets_ead
	, cur_assets_with_grp_ead
	, osnov_srva_td_grp
	, gross_prof_margin_grp
	, cash_inv_cur_liab_mean_ann
	, ebitda_prc
	, ql_1
	, default_first_reason
	, default_second_reason
	, day_after_report
	, client_liq_flg
	, var_1
	, type_of_model
	, t_source_system_id
	, t_changed_dttm
	, t_process_task_id			
FROM sbx.lgd_input_vector_tab
WHERE t_deleted_flg = 0
	AND	t_active_flg = 1
;
DROP TABLE IF EXISTS sbx.lgd_collateral_portfolio_unity  
;
CREATE TABLE sbx.lgd_collateral_portfolio_unity AS
WITH cls_excl AS (
    /* Ручное исключение сделок из расчета */
	SELECT
		  dp.report_dt
		, cl.classifier_id
		, cl.rdm_tableobject_id AS obj_id
	FROM sbx.ref_params AS dp
	JOIN dm_rdm.object_classification AS cl
		ON	cl.classifier_id = 214
		AND dp.report_dt BETWEEN cl.valid_from AND cl.valid_to)
, pre_cf AS (
	SELECT
		  f.report_dt
		/* Клиент */
		, f.client_core_id
		/* Сделка */
		, f.deal_core_id
		/* Аллокированное обеспечение */
		, f.pledger_id 
		, f.coll_core_id 
		, f.coll_kind_cd
		, f.coll_kind_cost
		, f.coll_full_amt_rur
		, f.coll_market_amt_rur
		, f.coll_fair_amt_rur
		, f.coll_quality_catg
		/* Залоги */
		, DECODE(f.coll_kind_cost, 'full', pled_all_kk_full_amt_rur, 'market', pled_all_kk_market_amt_rur, 'fair', pled_all_kk_fair_amt_rur) AS pled_all_kk_amt_rur
		, DECODE(f.coll_kind_cost, 'full', pled_prop_all_kk_full_amt_rur, 'market', pled_prop_all_kk_market_amt_rur, 'fair', pled_prop_all_kk_fair_amt_rur) AS pled_prop_all_kk_amt_rur
		, DECODE(f.coll_kind_cost, 'full', pled_real_all_kk_full_amt_rur, 'market', pled_real_all_kk_market_amt_rur, 'fair', pled_real_all_kk_fair_amt_rur) AS pled_real_all_kk_amt_rur
		, DECODE(f.coll_kind_cost, 'full', pled_prop_1_2_kk_full_amt_rur, 'market', pled_prop_1_2_kk_market_amt_rur, 'fair', pled_prop_1_2_kk_fair_amt_rur) AS pled_prop_1_2_kk_amt_rur
		, DECODE(f.coll_kind_cost, 'full', pled_real_1_2_kk_full_amt_rur, 'market', pled_real_1_2_kk_market_amt_rur, 'fair', pled_real_1_2_kk_fair_amt_rur) AS pled_real_1_2_kk_amt_rur
		, DECODE(f.coll_kind_cost, 'full', pled_cb_all_kk_full_amt_rur, 'market', pled_cb_all_kk_market_amt_rur, 'fair', pled_cb_all_kk_fair_amt_rur) AS pled_cb_all_kk_amt_rur
		, DECODE(f.coll_kind_cost, 'full', pled_cb_1_kk_full_amt_rur, 'market', pled_cb_1_kk_market_amt_rur, 'fair', pled_cb_1_kk_fair_amt_rur) AS pled_cb_1_kk_amt_rur
		, DECODE(f.coll_kind_cost, 'full', pled_cb_2_kk_full_amt_rur, 'market', pled_cb_2_kk_market_amt_rur, 'fair', pled_cb_2_kk_fair_amt_rur) AS pled_cb_2_kk_amt_rur
		, num_prop_all_kk_amt_rur
		, num_real_all_kk_amt_rur
		, num_cb_all_kk_amt_rur
		/* Поручительство */
		, DECODE(f.coll_kind_cost, 'full', surety_1_kk_full_amt_rur, 'fair', surety_1_kk_fair_amt_rur) AS surety_1_kk_amt_rur	
		, DECODE(f.coll_kind_cost, 'full', surety_2_kk_full_amt_rur, 'fair', surety_2_kk_fair_amt_rur) AS surety_2_kk_amt_rur	
		, DECODE(f.coll_kind_cost, 'full', surety_bb_plus_kk_full_amt_rur, 'fair', surety_bb_plus_kk_fair_amt_rur) AS surety_bb_plus_kk_amt_rur	
		/* Гарантийные депозиты */
		, DECODE(f.coll_kind_cost, 'full', guar_dep_1_kk_full_amt_rur, 'fair', guar_dep_1_kk_fair_amt_rur) AS guar_dep_1_kk_amt_rur
		, DECODE(f.coll_kind_cost, 'full', guar_dep_2_kk_full_amt_rur, 'fair', guar_dep_2_kk_fair_amt_rur) AS guar_dep_2_kk_amt_rur
		/* Залогодатель */
		, GREATEST((p.assets - p.st_liab - p.lt_liab), 0) AS pledger_net_assets	/* Чистые активы поручителя */
		, p.ql_1 AS pledger_ql1
	FROM sbx.coverage_factors AS f	
	JOIN sbx.ref_params AS dp
		ON	dp.report_dt = f.report_dt
	LEFT JOIN sbx.portfolio_client_asvr AS p
		ON	p.report_dt = f.report_dt 
		AND p.client_core_id  = f.pledger_id
)
, cf as (
	SELECT
		  f.report_dt
		/* Клиент */
		, f.client_core_id
		/* Сделка */
		, f.deal_core_id
		/* Аллокированное обеспечение */
		, f.pledger_id 
		, f.coll_core_id 
		, f.coll_kind_cd
		, f.coll_kind_cost
		, f.coll_full_amt_rur
		, f.coll_market_amt_rur
		, f.coll_fair_amt_rur
		/* Залоги */
		, f.pled_all_kk_amt_rur
		, f.pled_prop_all_kk_amt_rur
		, f.pled_real_all_kk_amt_rur
		, f.pled_prop_1_2_kk_amt_rur
		, f.pled_real_1_2_kk_amt_rur
		, f.pled_cb_all_kk_amt_rur
		, f.pled_cb_1_kk_amt_rur
		, f.pled_cb_2_kk_amt_rur
		, f.num_prop_all_kk_amt_rur
		, f.num_real_all_kk_amt_rur
		, f.num_cb_all_kk_amt_rur
		, CASE
			WHEN f.coll_kind_cd = 'pled_cb'
				AND f.coll_quality_catg IN ('1','2')
				THEN f.coll_core_id
		  END AS num_cb_1_2_kk_amt_rur
		/* Поручительство */
		, f.surety_1_kk_amt_rur	
		, (CASE	WHEN f.pledger_net_assets IS NOT NULL
				THEN LEAST(f.surety_2_kk_amt_rur, CAST(0.5 * f.pledger_net_assets AS DECIMAL(38,17)))
				ELSE f.surety_2_kk_amt_rur
			END)	AS surety_2_kk_amt_rur
		, f.surety_bb_plus_kk_amt_rur	
		/* Гарантийные депозиты */
		, f.guar_dep_1_kk_amt_rur
		, f.guar_dep_2_kk_amt_rur
		/* Залогодатель */
		, f.pledger_net_assets	/* Чистые активы поручителя */
		, CASE
			WHEN f.coll_kind_cd = 'surety'
				AND f.coll_quality_catg IN ('1', '2')
				AND f.pledger_ql1 in ('Аффилирован','Контроль государства') /* Поручитель */
				THEN f.pledger_ql1
		  END AS pledger_ql1
	FROM pre_cf AS f
)
, pai_val AS (
	SELECT
		  rp.report_dt
		, cc.contractor_id AS client_asvr_id
		, cc.val AS pled_of_share_asvr
		, ROW_NUMBER() OVER (PARTITION BY rp.report_dt, cc.contractor_id ORDER BY cc.date_saving DESC) AS RN
	FROM sbx.ref_params AS rp
	JOIN dm_asvr_ultra_gpb_d.v_ext_history_calc_clear AS cc
		ON CAST(cc.date_saving AS DATE) <= rp.report_dt
	WHERE name_index ilike 'Наличие залога контролирующих (50% +) долей в капитале'
		AND name_method = 'GPB-CA-3.2 Оценка вероятности дефолта корпоративных клиентов'
)
, cb_excl AS (
	SELECT 
		  pcd.report_dt
		, pcd.client_core_id
		, pcd.deal_core_id
		, pcd.def_client_tp
		, NVL(c.pled_of_share, pv.pled_of_share_asvr) AS pled_of_share /* Для переопределения флага нацичия ЦБ NULL определяем как Да */
	FROM sbx.portfolio_deal AS pcd
	JOIN sbx.ref_params AS rp
		ON	pcd.report_dt = rp.report_dt
	LEFT JOIN sbx.portfolio_client_asvr AS c
		ON	c.report_dt = pcd.report_dt 
		AND c.client_core_id = pcd.def_client_core_id
	LEFT JOIN pai_val AS pv
		ON	pv.report_dt = c.report_dt
		AND	pv.client_asvr_id = c.client_asvr_id
		AND pv.rn = 1
)
, coverage_factors AS (
	SELECT
		  f.report_dt
		/* Клиент */
		, f.client_core_id
		/* Сделка */
		, f.deal_core_id
		/* Залоги */
		, SUM(f.pled_all_kk_amt_rur) AS pled_all_kk_amt_rur
		, SUM(f.pled_prop_all_kk_amt_rur) AS pled_prop_all_kk_amt_rur
		, SUM(f.pled_real_all_kk_amt_rur) AS pled_real_all_kk_amt_rur
		, SUM(f.pled_prop_1_2_kk_amt_rur) AS pled_prop_1_2_kk_amt_rur
		, SUM(f.pled_real_1_2_kk_amt_rur) AS pled_real_1_2_kk_amt_rur
		, SUM(f.pled_cb_all_kk_amt_rur) AS pled_cb_all_kk_amt_rur
		, SUM(f.pled_cb_1_kk_amt_rur) AS pled_cb_1_kk_amt_rur
		, SUM(f.pled_cb_2_kk_amt_rur) AS pled_cb_2_kk_amt_rur
		, COUNT(DISTINCT f.num_prop_all_kk_amt_rur) AS num_prop_all_kk_amt_rur
		, COUNT(DISTINCT f.num_real_all_kk_amt_rur) AS num_real_all_kk_amt_rur
		, COUNT(DISTINCT f.num_cb_all_kk_amt_rur) AS num_cb_all_kk_amt_rur
		, COUNT(DISTINCT f.num_cb_1_2_kk_amt_rur) AS num_cb_1_2_kk_amt_rur
		/* Поручительство */
		, SUM(f.surety_1_kk_amt_rur) AS surety_1_kk_amt_rur	
		, SUM(f.surety_2_kk_amt_rur) AS surety_2_kk_amt_rur	
		, SUM(f.surety_bb_plus_kk_amt_rur) AS surety_bb_plus_kk_amt_rur	
		/* Гарантийные депозиты */
		, SUM(f.guar_dep_1_kk_amt_rur) AS guar_dep_1_kk_amt_rur
		, SUM(f.guar_dep_2_kk_amt_rur) AS guar_dep_2_kk_amt_rur
		/* Залогодатель */
		, MAX(f.pledger_ql1) AS pledger_ql1 /* скорректированный кач показатель залогодателя */
		, MAX(NVL(pcd.pled_of_share, 'Да')) AS pled_of_share
	FROM cf AS f
	LEFT JOIN cb_excl AS pcd
		ON	pcd.report_dt = f.report_dt
		AND pcd.client_core_id = f.client_core_id 
		AND pcd.deal_core_id = f.deal_core_id 
		AND f.coll_kind_cd =  'pled_cb' /* Залоги ПАИ и ЦБ */
	WHERE (pcd.client_core_id IS NULL	/* Исключаем залоги, ПАИ и ЦБ у Тек Фин, где риск на поручителе и на группе */
		OR NVL(pcd.pled_of_share, 'Нет') = 'Да'
		OR pcd.def_client_tp NOT IN ('Текущее финансирование - риск на поручителя', 'Текущее финансирование - риск на группу'))	/* Исключаем залоги, ПАИ и ЦБ у Тек Фин, где риск на поручителе и на группе */  /*Для текущего финансирования NULL определяем как Нет*/
	GROUP BY
		  f.report_dt
		, f.client_core_id
		, f.deal_core_id	
)
, unity_core as (
	SELECT
		  d.report_dt
		, d.client_core_id
		, d.def_client_core_id
		, d.def_client_tp
		, d.proj_asvr_id 
		, d.deal_core_id
		, d.deal_abs_id
		, d.deal_num
		, d.deal_ebg_flg
		, d.deal_covering_flg
		/* EAD */
		, d.debt_sum 
		, d.ead
		/* Залоги */
		, NVL(cc.pled_all_kk_amt_rur, 0) 								AS pled_all_kk_amt_rur    
		, NVL(cc.pled_prop_all_kk_amt_rur, 0)							AS pled_prop_all_kk_amt_rur
		, NVL(cc.pled_real_all_kk_amt_rur, 0)							AS pled_real_all_kk_amt_rur
		, NVL(cc.pled_prop_1_2_kk_amt_rur, 0)							AS pled_prop_1_2_kk_amt_rur
		, NVL(cc.pled_real_1_2_kk_amt_rur, 0)							AS pled_real_1_2_kk_amt_rur
		, NVL(cc.pled_cb_all_kk_amt_rur, 0)								AS pled_cb_all_kk_amt_rur
		, NVL(cc.pled_cb_1_kk_amt_rur, 0)								AS pled_cb_1_kk_amt_rur
		, NVL(cc.pled_cb_2_kk_amt_rur, 0) 								AS pled_cb_2_kk_amt_rur
		, NVL(num_prop_all_kk_amt_rur, 0)								AS num_prop_all_kk_amt_rur
		, NVL(num_real_all_kk_amt_rur, 0)								AS num_real_all_kk_amt_rur
		, NVL(num_cb_all_kk_amt_rur, 0)									AS num_cb_all_kk_amt_rur
		, NVL(num_cb_1_2_kk_amt_rur, 0)									AS num_cb_1_2_kk_amt_rur
		/* Поручительство */
		, NVL(cc.surety_1_kk_amt_rur, 0) 								AS surety_1_kk_amt_rur
		, NVL(cc.surety_2_kk_amt_rur, 0) 								AS surety_2_kk_amt_rur
		, NVL(cc.surety_bb_plus_kk_amt_rur, 0)							AS surety_bb_plus_kk_amt_rur 
		/* Гарантийные депозиты*/
		, NVL(cc.guar_dep_1_kk_amt_rur, 0)								AS guar_dep_1_kk_amt_rur
		, NVL(cc.guar_dep_2_kk_amt_rur, 0)								AS guar_dep_2_kk_amt_rur
		/* Залогодатель */
		, cc.pledger_ql1
		, cc.pled_of_share
		, d.t_source_system_id 
	FROM sbx.ref_params AS dp 
	JOIN sbx.portfolio_deal AS d
		ON	d.report_dt = dp.report_dt
	LEFT JOIN coverage_factors AS cc
		ON	cc.report_dt = d.report_dt
		AND cc.client_core_id = d.client_core_id
		AND cc.deal_core_id = d.deal_core_id 
	/* Ручное исключение сделок из расчета */
	LEFT ANTI JOIN cls_excl AS cl214
		ON	cl214.classifier_id = 214
		AND cl214.report_dt = d.report_dt 
		AND cl214.obj_id = d.deal_abs_id
	WHERE d.model_flg = 1
)
, unity_kk_core AS (
	SELECT
		  d.report_dt
		, d.client_core_id
		, d.def_client_core_id
		, d.def_client_tp
		, d.proj_asvr_id
		, d.deal_core_id
		, d.deal_abs_id
		, d.deal_num
		, d.deal_ebg_flg
		/* EAD */
		, d.debt_sum
	    , d.ead 
		, SUM(d.ead) OVER (PARTITION BY d.report_dt, d.def_client_core_id) AS client_ead
		/* Залоги */
		, d.pled_all_kk_amt_rur
		, d.pled_prop_all_kk_amt_rur
		, d.pled_real_all_kk_amt_rur
		, d.pled_prop_1_2_kk_amt_rur
		, d.pled_real_1_2_kk_amt_rur
		, d.pled_cb_all_kk_amt_rur
		, d.pled_cb_1_kk_amt_rur + d.pled_cb_2_kk_amt_rur AS pled_cb_1_2_kk_amt_rur
		, d.num_prop_all_kk_amt_rur
		, d.num_real_all_kk_amt_rur
		, d.num_cb_all_kk_amt_rur
		, d.num_cb_1_2_kk_amt_rur
		/* Поручительсто */
		, d.surety_1_kk_amt_rur + d.surety_2_kk_amt_rur AS surety_1_2_kk_amt_rur
		, d.surety_bb_plus_kk_amt_rur
		/* Гарантийные депозиты*/
		, d.guar_dep_1_kk_amt_rur + d.guar_dep_2_kk_amt_rur AS guar_dep_1_2_kk_amt_rur
		/* Залогодатель */
		, d.pledger_ql1
		/* Доп атрибуты */
		, d.pled_of_share
		, d.deal_covering_flg
		, d.t_source_system_id 
	FROM unity_core AS d
)
SELECT
	  d.report_dt
	, d.client_core_id
	, d.def_client_core_id
	, d.def_client_tp
	, d.proj_asvr_id 
	, d.deal_core_id
	, d.deal_abs_id
	, d.deal_num
	, d.deal_ebg_flg
	/* EAD */
	, d.debt_sum 
	, d.ead
	, d.client_ead
	/* Залоги */
	, d.pled_all_kk_amt_rur
	, d.pled_prop_all_kk_amt_rur
	, d.pled_real_all_kk_amt_rur
	, d.pled_prop_1_2_kk_amt_rur
	, d.pled_real_1_2_kk_amt_rur
	, d.pled_cb_all_kk_amt_rur
	, d.pled_cb_1_2_kk_amt_rur
	, d.pled_cb_all_kk_amt_rur - d.pled_cb_1_2_kk_amt_rur as pled_cb_not_1_2_kk_amt_rur 
	, d.num_prop_all_kk_amt_rur
	, d.num_real_all_kk_amt_rur
	, d.num_cb_all_kk_amt_rur - d.num_cb_1_2_kk_amt_rur as num_cb_not_1_2_kk_amt_rur
	/* Поручительсто */
	, d.surety_1_2_kk_amt_rur
	, d.surety_bb_plus_kk_amt_rur
	/* Гарантийные депозиты*/
	, d.guar_dep_1_2_kk_amt_rur
	/* Залогодатель */
	, d.pledger_ql1
	/* Доп атрибуты */
	, d.pled_of_share
	, d.deal_covering_flg
	, d.t_source_system_id
FROM unity_kk_core AS d
;
INSERT INTO sbx.lgd_input_vector_tab
(
	  report_dt
	, client_core_id
	, client_asvr_id
	, client_exp_mod_flg
	, client_irbf_nm_up_wgr_kik
	, client_ind_nm_up_wgr_kik
	, client_lrg_ind_nm_bucket
	, client_public_flg
	, deal_core_id
	, deal_abs_id
	, deal_num
	, deal_ebg_flg
	, ead
	, ead_with_grp
	, deal_cover_part
	, imush_nedv_pai_to_ead_corr
	, pai_all_flg
	, osnov_srva_ead
	, cur_assets_ead
	, cur_assets_with_grp_ead
	, osnov_srva_td_grp
	, gross_prof_margin_grp
	, cash_inv_cur_liab_mean_ann
	, ebitda_prc
	, ql_1
	, default_first_reason
	, default_second_reason
	, day_after_report
	, client_liq_flg
	, var_1
	, type_of_model
	, valid_from_dttm
	, valid_to_dttm
	, t_source_system_id
	, t_changed_dttm
	, t_deleted_flg
	, t_active_flg
	, t_author
	, t_process_task_id			
)
WITH unity_core AS (
	SELECT
		  dp.report_dt
		, d.client_core_id
		, d.def_client_core_id
		, d.def_client_tp
		, d.proj_asvr_id
		, d.deal_core_id
		, d.deal_abs_id
		, d.deal_num
		, d.deal_ebg_flg
		/* EAD */
		, d.debt_sum
		, d.ead
		, d.client_ead
		/* Залоги */
		, d.pled_all_kk_amt_rur
		, d.pled_prop_all_kk_amt_rur
		, d.pled_real_all_kk_amt_rur
		, d.pled_prop_1_2_kk_amt_rur
		, d.pled_real_1_2_kk_amt_rur
		, d.pled_cb_all_kk_amt_rur
		, d.pled_cb_1_2_kk_amt_rur
		, d.pled_cb_not_1_2_kk_amt_rur
		, d.num_prop_all_kk_amt_rur
		, d.num_real_all_kk_amt_rur
		, d.num_cb_not_1_2_kk_amt_rur
		/* Поручительство */
		, d.surety_1_2_kk_amt_rur
		, d.surety_bb_plus_kk_amt_rur
		/* Гарантийные депозиты*/
		, d.guar_dep_1_2_kk_amt_rur
		/* Залогодатель */
		, d.pledger_ql1
		, d.pled_of_share
		/* Доп атрибуты */
		, d.deal_covering_flg
		, IFNULL(d.ead/NULLIF(d.pled_all_kk_amt_rur - d.pled_cb_not_1_2_kk_amt_rur , 0), CAST('inf' AS DOUBLE)) AS ltv_all
		, cl210.value_n AS ltv_porog
		, cl209.value_n AS materiality
		, d.t_source_system_id 
	FROM sbx.ref_params AS dp 
	JOIN sbx.lgd_collateral_portfolio_unity AS d
		ON	d.report_dt  = dp.report_dt 
	LEFT JOIN dm_rdm.object_classification AS cl210
		ON  cl210.classifier_id = 210 	/* Классификатор порогового значения соотношения суммы кредита к стоимости залогового имущества */
		AND dp.report_dt BETWEEN cl210.valid_from AND cl210.valid_to 
   	LEFT JOIN dm_rdm.object_classification AS cl209 
   		ON	cl209.classifier_id = 209 	/* Классификатор материальности */
		AND d.report_dt BETWEEN cl209.valid_from AND cl209.valid_to		
)
, unity_client AS (
	SELECT
		  d.report_dt
		, d.client_core_id
		, d.def_client_core_id
		, d.def_client_tp
		, a.client_asvr_id AS def_client_asvr_id
		, p.client_asvr_id
		, CASE WHEN a.client_rating_method = 'Рейтинг и фин. положение по компаниям с закрытой отчетностью'
		       THEN 1
		       ELSE 0
		  END client_exp_mod_flg 		/* Признак экспертного рейтинга на клиенте */
		, gc.client_irbf_nm_up_wgr_kik
		, gc.client_ind_nm_up_wgr_kik
		, gc.client_lrg_ind_nm_bucket	/* Распределиние отрасли */
		, a.client_public_flg			/* Флаг публичного контрагента */
		, a.client_irbf_nm
		, d.deal_core_id
		, d.deal_abs_id
		, d.deal_num
		, d.deal_ebg_flg
		, d.ead
		, gc.grp_stage_id
		, CASE
			WHEN gc.grp_irbf_nm = 'Коммерческие банки' /* Если Банк берет задолженность с клиента, а не с группы */
				OR NVL(gc.client_wgr,0) < 0.5
				THEN d.client_ead
			ELSE SUM(d.ead) OVER (PARTITION BY d.report_dt, NVL(gc.grp_stage_id, a.client_stage_id))
		  END AS ead_with_grp
		/* Залоги */
		, d.pled_cb_1_2_kk_amt_rur
		/* Поручительства */
		, d.surety_1_2_kk_amt_rur
		/* Гарантийный депозит*/
		, d.guar_dep_1_2_kk_amt_rur
		, d.pled_prop_1_2_kk_amt_rur
		, d.pled_real_1_2_kk_amt_rur
		, LEAST(
	       (d.pled_prop_all_kk_amt_rur + d.pled_real_all_kk_amt_rur + d.pled_cb_not_1_2_kk_amt_rur)/d.ead
	      , d.num_prop_all_kk_amt_rur + d.num_real_all_kk_amt_rur + d.num_cb_not_1_2_kk_amt_rur
       	  )	AS imush_nedv_pai_to_ead_corr
		, CASE
			WHEN d.pled_cb_all_kk_amt_rur / NULLIF(CAST(d.ead AS DECIMAL(38,2)), 0) > 0
				THEN 1
			ELSE 0
		  END AS pai_all_flg	/* Флаг наличия паев и ЦБ */
		, a.client_type_cd
		, d.client_ead
		, a.osnov_srva 
		, a.cur_assets
		, gc.grp_cur_assets
	    , gc.client_osnov_srva_td_with_grp    AS osnov_srva_td_grp
	    , gc.client_gross_prof_marg_with_grp  AS gross_prof_margin_grp
		, gc.client_csh_inv_cur_liab_with_grp AS cash_inv_cur_liab_mean_ann		/* Среднее значение денеж.средств + инвестиции к кратк. обязательствам, стало с учетом группы */
		, a.ebitda_prc	/* Ebitda/Проценты к уплате */
		, CASE
			WHEN a.ql_1 NOT IN ('Аффилирован','Контроль государства')		/* Заемщик */
				AND d.pledger_ql1 IN ('Аффилирован','Контроль государства')	/* Поручитель */
				THEN d.pledger_ql1
			WHEN a.client_resident_flg = 0
				AND a.ql_1 = 'Контроль государства'
				THEN 'Нерезидент'
			ELSE a.ql_1
		  END ql_1
		, NVL(a.pled_of_share, d.pled_of_share) AS pled_of_share
		, d.deal_covering_flg
		, a.default_first_reason
		, a.default_second_reason
		, a.day_after_report	/* Кол-во дней в дефолте (Кол-во дней после присвоения рейтинга D) */
		, CASE
			WHEN NVL(a.client_wl, '') ILIKE '%ликвидация%'
				THEN 1
			ELSE 0
		  END AS client_liq_flg /* Факт наличия признака/отсутствия ликвидации заемщика в Watch List */
		, CASE
			WHEN a.client_contractor_flg = 1 AND NVL(a.client_wl, '') NOT ILIKE '%ликвидация%' /* irbf segmentation контрактники */
				THEN 1
			WHEN NVL(a.client_wl, '') ILIKE '%ликвидация%'
				THEN 4
			WHEN NVL(a.client_wl, '') NOT ILIKE '%ликвидация%'
				AND gc.client_irbf_nm_up_wgr_kik_flg = 0
				THEN 1
			WHEN (NVL(a.client_wl, '') NOT ILIKE '%ликвидация%'
				AND gc.client_irbf_nm_up_wgr_kik_flg = 1)
				AND (surety_bb_plus_kk_amt_rur / NULLIF(ead,0) >= materiality
					OR ltv_all <= ltv_porog)
				THEN 2
			WHEN NVL(a.client_wl, '') NOT ILIKE '%ликвидация%'
				AND gc.client_irbf_nm_up_wgr_kik_flg = 1
				AND surety_bb_plus_kk_amt_rur / NULLIF(ead,0) < materiality
				AND (ltv_all > ltv_porog)
				THEN 3
			ELSE 5
		  END AS var_1
		, a.type_of_model /* тип расчета модели */
		, a.client_resident_flg
		, d.t_source_system_id
	FROM unity_core AS d
	LEFT JOIN sbx.portfolio_client_asvr AS a	
		AND a.client_core_id = d.def_client_core_id
	/* Получаем ключ заемщика */
	LEFT JOIN sbx.portfolio_client_asvr AS p	
		ON	p.report_dt = d.report_dt 
		AND p.client_core_id = d.client_core_id
	/* Начитываем групповую атрибутику */
	LEFT JOIN sbx.portfolio_client_asvr_grp AS gc	
		ON	gc.report_dt = d.report_dt 
		AND gc.client_core_id = d.def_client_core_id
)
, pre_lgd_input AS (
	SELECT 
		  t.report_dt
		, t.client_core_id
		, t.def_client_core_id
		, t.def_client_tp
		, t.client_asvr_id
		, t.client_exp_mod_flg
		, t.client_irbf_nm_up_wgr_kik
		, t.client_ind_nm_up_wgr_kik
		, t.client_lrg_ind_nm_bucket		/* Распределиние отрасли */
		, t.client_public_flg				/* Флаг публичного контрагента */
		, t.client_irbf_nm
		, t.deal_core_id
		, CAST(t.deal_abs_id AS BIGINT)	AS deal_abs_id
		, t.deal_num
		, t.deal_ebg_flg
		, t.ead
		, t.grp_stage_id
		, t.ead_with_grp
		, t.pled_prop_1_2_kk_amt_rur
		, t.pled_real_1_2_kk_amt_rur
		, t.pled_cb_1_2_kk_amt_rur 			/* ПАИ и ЦБ 1,2 кк*/
		, t.surety_1_2_kk_amt_rur			/* Поручительства 1,2 кк */
		, t.guar_dep_1_2_kk_amt_rur 		/* Гарантийный депозит 1,2 кк*/
		, CAST(t.imush_nedv_pai_to_ead_corr AS DECIMAL(38,17)) AS imush_nedv_pai_to_ead_corr
		, CASE
			WHEN COALESCE(t.pled_of_share, 'Да') = 'Да'
				AND COALESCE(t.client_resident_flg, 0) = 1
		       THEN t.pai_all_flg 			/* Флаг наличия паев и ЦБ*/
			ELSE 0
		  END pai_all_flg  					/* Флаг наличия паев и ЦБ */
		, t.client_type_cd
		, t.client_ead
		, t.osnov_srva 
		, t.cur_assets
		, t.grp_cur_assets
	    , t.osnov_srva_td_grp
	    , t.gross_prof_margin_grp
		, t.cash_inv_cur_liab_mean_ann		/* Среднее значение денеж.средств + инвестиции к кратк. обязательствам, стало с учетом группы */
		, t.ebitda_prc						/* Ebitda/Проценты к уплате */
		, t.ql_1
		, t.pled_of_share
		, t.deal_covering_flg
		, t.default_first_reason
		, t.default_second_reason
		, t.day_after_report				/* Кол-во дней в дефолте (Кол-во дней после присвоения рейтинга D) */
		, t.client_liq_flg 					/* Факт наличия признака/отсутствия ликвидации заемщика в Watch List */
		, t.var_1
		, t.type_of_model 					/* тип расчета модели */
		, t.client_resident_flg
		, t.t_source_system_id
		, t.osnov_srva / NULLIF(CASE WHEN t.client_type_cd = 'GROUP_OF_COMPANIES' THEN t.ead_with_grp ELSE t.client_ead END, 0) AS osnov_srva_ead	/* Основные средства/EAD в разрезе клиента */
		, t.cur_assets / NULLIF(CASE WHEN t.client_type_cd = 'GROUP_OF_COMPANIES' THEN t.ead_with_grp ELSE t.client_ead END, 0) AS cur_assets_ead	/* Оборотные активы/EAD в разрезе клиента */
		, CAST(t.grp_cur_assets / nullif(t.ead_with_grp, 0)  AS DECIMAL(38,17)) AS cur_assets_with_grp_ead	/* Оборотные активы с учетом группы/EAD */
	FROM unity_client AS t
)
, lgd_input AS (
	SELECT
		  d.report_dt
		, d.client_core_id
		, d.client_asvr_id
		, d.def_client_core_id
		, d.def_client_tp
		, d.client_exp_mod_flg
--		, d.client_irbf_nm_up_wgr_kik
		, NVL(rs.risk_segment_for_model
			, d.client_irbf_nm_up_wgr_kik
			)	AS client_irbf_nm_up_wgr_kik	/* SPMPLN-23739: 1) Добавление справочных значений риск-сегментации */
		, d.client_ind_nm_up_wgr_kik
		, d.client_lrg_ind_nm_bucket	/* Распределиние отрасли по корзинам */
		, d.client_public_flg			/* Флаг публичного контрагента */
		, d.deal_core_id
		, d.deal_abs_id
		, d.deal_num
		, d.deal_ebg_flg
		, d.ead
		, d.ead_with_grp
		, d.imush_nedv_pai_to_ead_corr
		/* Флаги наличия на сделки (Имущество, Недвижимость, ПАИ и ЦБ) */
		, d.pled_prop_1_2_kk_amt_rur
		, d.pled_real_1_2_kk_amt_rur
		, d.pled_cb_1_2_kk_amt_rur
		, d.surety_1_2_kk_amt_rur
		, d.guar_dep_1_2_kk_amt_rur
		, d.pai_all_flg
		, CAST(d.osnov_srva_ead AS DECIMAL(38,17)) AS osnov_srva_ead	/* Основные средства/EAD */
		, CAST(d.cur_assets_ead AS DECIMAL(38,17)) AS cur_assets_ead	/* Оборотные активы/EAD */
		, d.cur_assets_with_grp_ead	/* Оборотные активы с учетом группы/EAD */
		, d.osnov_srva_td_grp
		, d.gross_prof_margin_grp
		, d.cash_inv_cur_liab_mean_ann	/* Среднее значение денеж.средств + инвестиции к кратк. обязательствам, стало с учетом группы */
		, d.ebitda_prc	/* Ebitda/Проценты к уплате */
		, d.ql_1
		, d.deal_covering_flg
		, d.default_first_reason 
		, d.default_second_reason 
		, d.day_after_report	/* Кол-во дней в дефолте (Кол-во дней после присвоения рейтинга D) */
		, d.client_liq_flg		/* Факт наличия признака/отсутствия ликвидации заемщика в Watch List */
		, d.var_1
		, d.type_of_model		/* Тип расчета модели */
		, d.t_source_system_id
	FROM pre_lgd_input AS d 
	LEFT JOIN [BROADCAST] in_manual_corp_models.risk_segment_replacement_dict	AS rs
		ON	rs.risk_target_segment = d.client_irbf_nm_up_wgr_kik
)
SELECT
	  d.report_dt
	, d.client_core_id
	, d.client_asvr_id
	, d.client_exp_mod_flg
	, d.client_irbf_nm_up_wgr_kik
	, d.client_ind_nm_up_wgr_kik
	, d.client_lrg_ind_nm_bucket	/* Распределиние отрасли по корзинам */
	, d.client_public_flg			/* Флаг публичного контрагента */
	, d.deal_core_id
	, d.deal_abs_id
	, d.deal_num
	, d.deal_ebg_flg
	, d.ead
	, d.ead_with_grp
	, CASE
		WHEN d.deal_covering_flg = 1 
			THEN 1
		ELSE CAST(LEAST(GREATEST((d.pled_cb_1_2_kk_amt_rur + d.guar_dep_1_2_kk_amt_rur + d.surety_1_2_kk_amt_rur + d.pled_prop_1_2_kk_amt_rur + d.pled_real_1_2_kk_amt_rur) / d.ead,0), 1) AS DECIMAL(38,17))
	END AS deal_cover_part
	, d.imush_nedv_pai_to_ead_corr
	/* Флаги наличия на сделки (Имущество, Недвижимость, ПАИ и ЦБ) */
	, d.pai_all_flg
	, d.osnov_srva_ead	/* Основные средства/EAD */
	, d.cur_assets_ead	/* Оборотные активы/EAD */
	, d.cur_assets_with_grp_ead	/* Оборотные активы с учетом группы/EAD */
	, d.osnov_srva_td_grp
	, d.gross_prof_margin_grp
	, d.cash_inv_cur_liab_mean_ann	/* Среднее значение денеж.средств + инвестиции к кратк. обязательствам, стало с учетом группы */
	, d.ebitda_prc	/* Ebitda/Проценты к уплате */
	, d.ql_1       
	, d.default_first_reason 
	, d.default_second_reason 
	, d.day_after_report	/* Кол-во дней в дефолте (Кол-во дней после присвоения рейтинга D) */
	, d.client_liq_flg		/* Факт наличия признака/отсутствия ликвидации заемщика в Watch List */
	, d.var_1
	, d.type_of_model		/* тип расчета модели */
	, CAST(now() AS TIMESTAMP)					AS valid_from_dttm
	, CAST('2100-01-01 00:00:00' AS TIMESTAMP)	AS valid_to_dttm
	, d.t_source_system_id
	, CAST(now() AS timestamp) AS t_changed_dttm
	, CAST(0 AS TINYINT) AS t_deleted_flg
	, CAST(1 AS TINYINT) AS t_active_flg
	, CAST('LGD_INPUT_VECTOR' AS STRING) AS t_author
	, CAST(NULL AS INTEGER) AS t_process_task_id
FROM lgd_input AS d
;
/* технические проверки прототипа */
/* Дубли по PK */
SELECT report_dt, client_core_id, deal_core_id, COUNT(*)
FROM sbx.lgd_input_vector
GROUP BY report_dt, client_core_id, deal_core_id
HAVING COUNT(*) > 1
LIMIT 100
;
/* NULL в PK */
SELECT *
FROM sbx.lgd_input_vector
WHERE report_dt IS NULL 
OR client_core_id IS NULL
OR deal_core_id IS NULL
LIMIT 100


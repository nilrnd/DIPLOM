/*
Название:	Витрина 6 - Факторы покрытия
Описание:	Основной массив данных в представляет собой аллокацию по отобранным Сделкам стоимости отнесенного к ним Обеспечения (пересечение Витрины 5 - Сделка и Витрины 4 - Обеспечение).
Прототип на выходе формирует витрины:
	1) coverage_factors_TAB - техническая таблица с типом хранения данных SCD-2.
	2) coverage_factors – итоговая пользовательская вью.
--------------------
*/
DROP TABLE IF EXISTS sbx.coverage_factors_tab 
;
CREATE TABLE sbx.coverage_factors_tab
(
	  report_dt							DATE     			COMMENT 'Отчетная дата'					/* PK */
	, client_core_id					BIGINT		     	COMMENT 'Ид клиент из core'				/* PK */
	, deal_core_id						BIGINT     			COMMENT 'Ид сделки из core'				/* PK */
	, ead								DECIMAL(38,17)     	COMMENT 'Величина кредитных требований по сделке'
	, pledger_id						BIGINT     			COMMENT 'Ид залогодателя из core'
	, coll_core_id						BIGINT     			COMMENT 'Ид обеспечения из core'		/* PK */
	, coll_kind_cd                      STRING       		COMMENT 'Укрупенный код обеспечения'
	, coll_kind_cost					STRING				COMMENT 'Укрупенный код стоимости'
	, coll_fin_oper_code				STRING     			COMMENT 'Код финансовой операции'
	, coll_quality_catg					STRING     			COMMENT 'Категория качества'
	, coll_weight						DECIMAL(38,17)     	COMMENT 'Вес аллоцированного обеспечения, распределение обеспечения по сделке'
	, coll_full_amt_rur					DECIMAL(38,17)     	COMMENT 'Аллоцированная сумма полной стоимости обеспечения'
	, coll_market_amt_rur				DECIMAL(38,17)     	COMMENT 'Аллоцированная сумма рыночной стоимости обеспечения'
	, coll_fair_amt_rur					DECIMAL(38,17)     	COMMENT 'Аллоцированная сумма справедливой стоимости обеспечения'
	, flag_vn_gr_poruch					TINYINT    			COMMENT 'Флаг внутригруппового поручительства'
	, pledger_rating_ttc				STRING     			COMMENT 'Рейтинг залогодателя TTC'
	, pled_prop_all_kk_full_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги имущества, все категории качества, залоговая стоимость'
    , pled_real_all_kk_full_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги недвижимости, все категории качества, залоговая стоимость'
    , pled_prop_1_2_kk_full_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги имущества, все категории качества, залоговая стоимость'
    , pled_real_1_2_kk_full_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги недвижимости, все категории качества, залоговая стоимость'
    , pled_cb_all_kk_full_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги ПАИ и ЦБ, все категории качества, залоговая стоимость'
    , pled_cb_1_kk_full_amt_rur			DECIMAL(38,17)		COMMENT 'Залоги ПАИ и ЦБ, 1 категории качества, залоговая стоимость'
    , pled_cb_2_kk_full_amt_rur			DECIMAL(38,17)		COMMENT 'Залоги ПАИ и ЦБ, 2 категории качества, залоговая стоимость'
    , pled_all_kk_full_amt_rur			DECIMAL(38,17)		COMMENT 'Залоги, Все категории качества, залоговая стоимость'
    , surety_all_kk_full_amt_rur		DECIMAL(38,17)		COMMENT 'Поручительства, все категории качества с материальностью к EAD 50%'
    , surety_1_kk_full_amt_rur			DECIMAL(38,17)		COMMENT 'Поручительства 1, категории качества c учетом материальности и без внутригруппового флага'
    , surety_2_kk_full_amt_rur			DECIMAL(38,17)		COMMENT 'Поручительства 2, категории качества c учетом материальности и без внутригруппового флага'	
    , surety_bb_plus_kk_full_amt_rur	DECIMAL(38,17)		COMMENT 'Поручительства c рейтингом BB+ и выше, категории качества с материальностью к EAD 50%'
    , guar_dep_all_kk_full_amt_rur    	DECIMAL(38,17)		COMMENT 'Залоговая стоимость гарантийного депозита с материальностью к EAD 50%' 
    , guar_dep_1_kk_full_amt_rur		DECIMAL(38,17)		COMMENT 'Залоговая стоимость гарантийного депозита 1 категории с материальностью к EAD 50%' 
    , guar_dep_2_kk_full_amt_rur		DECIMAL(38,17)		COMMENT 'Залоговая стоимость гарантийного депозита 2 категории с материальностью к EAD 50%' 
    , pled_prop_all_kk_market_amt_rur	DECIMAL(38,17)		COMMENT 'Залоги имущества, все категории качества, рыночная стоимость'       
    , pled_real_all_kk_market_amt_rur	DECIMAL(38,17)		COMMENT 'Залоги недвижимости, все категории качества, рыночная стоимость'
	, pled_prop_1_2_kk_market_amt_rur	DECIMAL(38,17)		COMMENT 'Залоги имущества, 1 и 2 категории качества, рыночная стоимость'
	, pled_real_1_2_kk_market_amt_rur	DECIMAL(38,17)		COMMENT 'Залоги недвижимости, 1 и 2 категории качества, рыночная стоимость'
    , pled_cb_all_kk_market_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги ПАИ и ЦБ, все категории качества, рыночная стоимость'
    , pled_cb_1_kk_market_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги ПАИ и ЦБ, 1 категории качества, рыночная стоимость'
    , pled_cb_2_kk_market_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги ПАИ и ЦБ, 2 категории качества, рыночная стоимость'
   	, pled_all_kk_market_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги, все категории качества, рыночная стоимость'
    , pled_prop_all_kk_fair_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги имущества, все категории качества, залоговая стоимость'
    , pled_real_all_kk_fair_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги недвижимости, все категории качества, залоговая стоимость'
	, pled_prop_1_2_kk_fair_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги имущества, 1 и 2 категории качества, залоговая стоимость'
	, pled_real_1_2_kk_fair_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги недвижимости, 1 и 2 категории качества, залоговая стоимость'
    , pled_cb_all_kk_fair_amt_rur		DECIMAL(38,17)		COMMENT 'Залоги ПАИ и ЦБ, все категории качества, залоговая стоимость'
    , pled_cb_1_kk_fair_amt_rur			DECIMAL(38,17)		COMMENT 'Залоги ПАИ и ЦБ, 1 категории качества, залоговая стоимость'
    , pled_cb_2_kk_fair_amt_rur			DECIMAL(38,17)		COMMENT 'Залоги ПАИ и ЦБ, 2 категории качества, залоговая стоимость'
    , pled_all_kk_fair_amt_rur			DECIMAL(38,17)		COMMENT 'Залоги, все категории качества, залоговая стоимость'
    , surety_all_kk_fair_amt_rur		DECIMAL(38,17)		COMMENT 'Поручительства, все категории качества с материальностью к EAD 50%'
    , surety_1_kk_fair_amt_rur			DECIMAL(38,17)		COMMENT 'Поручительства 1 категории качества c учетом материальности и без внутригруппового флага'
    , surety_2_kk_fair_amt_rur			DECIMAL(38,17)		COMMENT 'Поручительства 2 категории качества c учетом материальности и без внутригруппового флага'	
    , surety_bb_plus_kk_fair_amt_rur	DECIMAL(38,17)		COMMENT 'Поручительства c рейтингом BB+ и выше, категории качества с материальностью к EAD 50%'
    , guar_dep_all_kk_fair_amt_rur    	DECIMAL(38,17)		COMMENT 'Залоговая стоимость гарантийного депозита с материальностью к EAD 50%' 
    , guar_dep_1_kk_fair_amt_rur		DECIMAL(38,17)		COMMENT 'Залоговая стоимость гарантийного депозита 1 категории с материальностью к EAD 50%' 
    , guar_dep_2_kk_fair_amt_rur		DECIMAL(38,17)		COMMENT 'Залоговая стоимость гарантийного депозита 2 категории с материальностью к EAD 50%' 
	, num_surety_all_kk_amt_rur			INT					COMMENT 'Количество поручительств, все категории качества с материальностью к EAD 50%'
    , num_prop_all_kk_amt_rur			DECIMAL(38,17)		COMMENT 'Количество залогов имущества, все категории качества'
    , num_real_all_kk_amt_rur			DECIMAL(38,17)		COMMENT 'Количество залогов недвижимости, все категории качества'
    , num_cb_all_kk_amt_rur				DECIMAL(38,17)		COMMENT 'Количество ЦБ, все категории качества'
	/* Технические атрибуты */
	, valid_from_dttm					TIMESTAMP			COMMENT 'Дата и время начала действия технической версии записи'
	, valid_to_dttm						TIMESTAMP			COMMENT 'Дата и время окончания действия технической версии записи'
    , t_source_system_id				SMALLINT       		COMMENT 'Идентификатор системы-источника'
    , t_changed_dttm					TIMESTAMP      		COMMENT 'Дата и время изменения записи'
    , t_deleted_flg						TINYINT        		COMMENT 'Признак удаления записи'
	, t_active_flg						TINYINT				COMMENT 'Признак активной записи'
    , t_author							STRING         		COMMENT 'Имя джоба'
    , t_process_task_id					INTEGER            	COMMENT 'Идентификатор процесса загрузки'
)
COMMENT 'Витрина 6 - Факторы покрытия'
;
DROP VIEW IF EXISTS sbx.coverage_factors
;
CREATE VIEW sbx.coverage_factors
(
	  report_dt							COMMENT 'PK | Отчетная дата'
	, client_core_id					COMMENT 'PK | Идентификатор клиента из core'
	, deal_core_id						COMMENT 'PK | Идентификатор сделки из core'
	, ead								COMMENT 'NN | Величина кредитных требований по сделке'
	, pledger_id						COMMENT 'Идентификатор залогодателя из core'
	, coll_core_id						COMMENT 'PK | Идентификатор обеспечения из core'
	, coll_kind_cd                      COMMENT 'Укрупненный код обеспечения'
	, coll_kind_cost					COMMENT 'Укрупненный код стоимости'
	, coll_fin_oper_code				COMMENT 'Код финансовой операции'
	, coll_quality_catg					COMMENT 'Категория качества'
	, coll_weight						COMMENT 'Вес аллоцированного обеспечения, распределение обеспечения по сделке'
	, coll_full_amt_rur					COMMENT 'Аллоцированная сумма полной стоимости обеспечения'
	, coll_market_amt_rur				COMMENT 'Аллоцированная сумма рыночной стоимости обеспечения'
	, coll_fair_amt_rur					COMMENT 'Аллоцированная сумма справедливой стоимости обеспечения'
	, flag_vn_gr_poruch					COMMENT 'NN | Флаг внутригруппового поручительства'
	, pledger_rating_ttc				COMMENT 'Рейтинг залогодателя TTC'
	, pled_prop_all_kk_full_amt_rur		COMMENT 'Залоги имущества, все категории качества, залоговая стоимость'
    , pled_real_all_kk_full_amt_rur		COMMENT 'Залоги недвижимости, все категории качества, залоговая стоимость'
	, pled_prop_1_2_kk_full_amt_rur		COMMENT 'Залоги имущества, все категории качества, залоговая стоимость'
	, pled_real_1_2_kk_full_amt_rur		COMMENT 'Залоги недвижимости, все категории качества, залоговая стоимость'
    , pled_cb_all_kk_full_amt_rur		COMMENT 'Залоги ПАИ и ЦБ, все категории качества, залоговая стоимость'
    , pled_cb_1_kk_full_amt_rur			COMMENT 'Залоги ПАИ и ЦБ, 1 категории качества, залоговая стоимость'
    , pled_cb_2_kk_full_amt_rur			COMMENT 'Залоги ПАИ и ЦБ, 2 категории качества, залоговая стоимость'
    , pled_all_kk_full_amt_rur			COMMENT 'Залоги, все категории качества, залоговая стоимость'
    , surety_all_kk_full_amt_rur		COMMENT 'Поручительства, все категории качества с материальностью к EAD 50%'
    , surety_1_kk_full_amt_rur			COMMENT 'Поручительства 1, категории качества c учетом материальности и без внутригруппового флага'
    , surety_2_kk_full_amt_rur			COMMENT 'Поручительства 2, категории качества c учетом материальности и без внутригруппового флага'	
    , surety_bb_plus_kk_full_amt_rur	COMMENT 'Поручительства c рейтингом BB+ и выше, категории качества с материальностью к EAD 50%'
    , guar_dep_all_kk_full_amt_rur    	COMMENT 'Залоговая стоимость гарантийного депозита с материальностью к EAD 50%' 
    , guar_dep_1_kk_full_amt_rur		COMMENT 'Залоговая стоимость гарантийного депозита 1 категории с материальностью к EAD 50%' 
    , guar_dep_2_kk_full_amt_rur		COMMENT 'Залоговая стоимость гарантийного депозита 2 категории с материальностью к EAD 50%' 
    , pled_prop_all_kk_market_amt_rur	COMMENT 'Залоги имущества, все категории качества, рыночная стоимость'       
    , pled_real_all_kk_market_amt_rur	COMMENT 'Залоги недвижимости, все категории качества, рыночная стоимость'
	, pled_prop_1_2_kk_market_amt_rur	COMMENT 'Залоги имущества, 1 и 2 категории качества, рыночная стоимость'
	, pled_real_1_2_kk_market_amt_rur	COMMENT 'Залоги недвижимости, 1 и 2 категории качества, рыночная стоимость'
    , pled_cb_all_kk_market_amt_rur		COMMENT 'Залоги ПАИ и ЦБ, все категории качества, рыночная стоимость'
    , pled_cb_1_kk_market_amt_rur		COMMENT 'Залоги ПАИ и ЦБ, 1 категории качества, рыночная стоимость'
    , pled_cb_2_kk_market_amt_rur		COMMENT 'Залоги ПАИ и ЦБ, 2 категории качества, рыночная стоимость'
   	, pled_all_kk_market_amt_rur		COMMENT 'Залоги, все категории качества, рыночная стоимость'
    , pled_prop_all_kk_fair_amt_rur		COMMENT 'Залоги имущества, все категории качества, залоговая стоимость'
    , pled_real_all_kk_fair_amt_rur		COMMENT 'Залоги недвижимости, все категории качества, залоговая стоимость'
	, pled_prop_1_2_kk_fair_amt_rur		COMMENT 'Залоги имущества, 1 и 2 категории качества, залоговая стоимость'
	, pled_real_1_2_kk_fair_amt_rur		COMMENT 'Залоги недвижимости, 1 и 2 категории качества, залоговая стоимость'
    , pled_cb_all_kk_fair_amt_rur		COMMENT 'Залоги ПАИ и ЦБ, все категории качества, залоговая стоимость'
    , pled_cb_1_kk_fair_amt_rur			COMMENT 'Залоги ПАИ и ЦБ, 1 категории качества, залоговая стоимость'
    , pled_cb_2_kk_fair_amt_rur			COMMENT 'Залоги ПАИ и ЦБ, 2 категории качества, залоговая стоимость'
    , pled_all_kk_fair_amt_rur			COMMENT 'Залоги, все категории качества, залоговая стоимость'
    , surety_all_kk_fair_amt_rur		COMMENT 'Поручительства, все категории качества с материальностью к EAD 50%'
    , surety_1_kk_fair_amt_rur			COMMENT 'Поручительства 1 категории качества c учетом материальности и без внутригруппового флага'
    , surety_2_kk_fair_amt_rur			COMMENT 'Поручительства 2 категории качества c учетом материальности и без внутригруппового флага'	
    , surety_bb_plus_kk_fair_amt_rur	COMMENT 'Поручительства c рейтингом BB+ и выше, категории качества с материальностью к EAD 50%'
    , guar_dep_all_kk_fair_amt_rur    	COMMENT 'Залоговая стоимость гарантийного депозита с материальностью к EAD 50%' 
    , guar_dep_1_kk_fair_amt_rur		COMMENT 'Залоговая стоимость гарантийного депозита 1 категории с материальностью к EAD 50%' 
    , guar_dep_2_kk_fair_amt_rur		COMMENT 'Залоговая стоимость гарантийного депозита 2 категории с материальностью к EAD 50%' 
	, num_surety_all_kk_amt_rur			COMMENT 'Количество поручительств, все категории качества с материальностью к EAD 50%'
    , num_prop_all_kk_amt_rur			COMMENT 'Количество залогов имущества, все категории качества'
    , num_real_all_kk_amt_rur			COMMENT 'Количество залогов недвижимости, все категории качества'
    , num_cb_all_kk_amt_rur				COMMENT 'Количество ЦБ, все категории качества'
	/* Технические атрибуты */
    , t_source_system_id				COMMENT 'NN | Идентификатор системы-источника'
    , t_changed_dttm					COMMENT 'NN | Дата и время изменения записи'
    , t_process_task_id					COMMENT 'NN | Идентификатор процесса загрузки'
)
AS SELECT
	  report_dt
	, client_core_id
	, deal_core_id
	, ead
	, pledger_id
	, coll_core_id
	, coll_kind_cd
	, coll_kind_cost
	, coll_fin_oper_code
	, coll_quality_catg
	, coll_weight
	, coll_full_amt_rur
	, coll_market_amt_rur
	, coll_fair_amt_rur
	, flag_vn_gr_poruch
	, pledger_rating_ttc
	, pled_prop_all_kk_full_amt_rur
    , pled_real_all_kk_full_amt_rur
	, pled_prop_1_2_kk_full_amt_rur
	, pled_real_1_2_kk_full_amt_rur
    , pled_cb_all_kk_full_amt_rur
    , pled_cb_1_kk_full_amt_rur
    , pled_cb_2_kk_full_amt_rur
    , pled_all_kk_full_amt_rur
    , surety_all_kk_full_amt_rur
    , surety_1_kk_full_amt_rur
    , surety_2_kk_full_amt_rur	
    , surety_bb_plus_kk_full_amt_rur
    , guar_dep_all_kk_full_amt_rur 
    , guar_dep_1_kk_full_amt_rur 
    , guar_dep_2_kk_full_amt_rur 
    , pled_prop_all_kk_market_amt_rur       
    , pled_real_all_kk_market_amt_rur
	, pled_prop_1_2_kk_market_amt_rur
	, pled_real_1_2_kk_market_amt_rur
    , pled_cb_all_kk_market_amt_rur
    , pled_cb_1_kk_market_amt_rur
    , pled_cb_2_kk_market_amt_rur
   	, pled_all_kk_market_amt_rur
    , pled_prop_all_kk_fair_amt_rur
    , pled_real_all_kk_fair_amt_rur
	, pled_prop_1_2_kk_fair_amt_rur
	, pled_real_1_2_kk_fair_amt_rur
    , pled_cb_all_kk_fair_amt_rur
    , pled_cb_1_kk_fair_amt_rur
    , pled_cb_2_kk_fair_amt_rur
    , pled_all_kk_fair_amt_rur
    , surety_all_kk_fair_amt_rur
    , surety_1_kk_fair_amt_rur
    , surety_2_kk_fair_amt_rur	
    , surety_bb_plus_kk_fair_amt_rur
    , guar_dep_all_kk_fair_amt_rur 
    , guar_dep_1_kk_fair_amt_rur 
    , guar_dep_2_kk_fair_amt_rur 
	, num_surety_all_kk_amt_rur
    , num_prop_all_kk_amt_rur
    , num_real_all_kk_amt_rur
    , num_cb_all_kk_amt_rur
	/* Технические атрибуты */
	, t_source_system_id
	, t_changed_dttm
	, t_process_task_id			
FROM sbx.coverage_factors_tab
WHERE t_deleted_flg = 0
	AND	t_active_flg = 1
;
DROP TABLE IF EXISTS sbx.lgd_portfolio_collateral_split 
;
/* Связь сделок и портфеля + аллоцирование */
/* Описание аллоцирования:
 * Пусть договор обеспечения относится к N договорам. 
 * Тогда мы аллоцируем так: умножаем сумму договора обеспечения на его вес. 
 * Вес равен отношению объёма договора к сумме всех объемов договоров, соответствующих этому договору обеспечения..
 */
CREATE TABLE sbx.lgd_portfolio_collateral_split AS 
WITH lnk AS (
    /* Линк сделка <--> обеспечение */
	SELECT
		  dp.report_dt
		, a_asn.agmt_asn_id
		, a_asn.agreement_1_id AS deal_core_id
		, a_asn.agreement_2_id AS coll_core_id
	FROM dm_core.f_agmt_asn AS a_asn
	JOIN sbx.ref_params AS dp
	WHERE 1=1
		AND a_asn.t_raw_status IN ('A','N','K','L','M','F')
		AND a_asn.t_srs_id IN (9,201)
		AND a_asn.agmt_asn_rsn_cd = 'credit_contract->collateral'
		AND dp.report_dt BETWEEN a_asn.begin_date AND NVL(a_asn.end_date, CAST('2100-01-01' AS date))
)
, lnkcol AS (
	SELECT 			
		  l.report_dt
		, l.deal_core_id
		, c.pledger_id
	   	, c.coll_core_main_id
	   	, c.coll_core_id   
	   	, c.coll_nbr
	   	, c.coll_pr_nm
		, c.coll_amt_rur
	   	, c.coll_fin_oper_code
	   	, c.coll_surety_flg 
		, CASE 
			WHEN c.coll_cs_accept_flg = 1
				THEN '1' /* Если согласован залоговой службой - меняем КК для учета в покрытии */
			ELSE c.coll_quality_catg
		  END AS coll_quality_catg
	   	, c.coll_full_cost_rur
	   	, c.coll_market_cost_rur
		, c.coll_fair_cost_rur
		, c.coll_kind_cd
		, c.coll_fair_prior_flg
	FROM lnk AS l
	JOIN sbx.portfolio_collateral AS c	
		ON c.report_dt = l.report_dt 
		AND c.coll_core_id = l.coll_core_id
)
, split AS (
	SELECT
		  d.report_dt
		/* Клиент */
	    , d.client_core_id
		/* Сделка */
	    , d.deal_core_id
	    , d.ead
		/* Залогодатель */
	    , c.pledger_id
		/* Обеспечение */
	    , c.coll_core_main_id
	    , NVL(c.coll_core_id, -1) AS coll_core_id  
	    , c.coll_nbr
	    , c.coll_pr_nm
		, c.coll_amt_rur
	    , c.coll_fin_oper_code
		, c.coll_quality_catg
		, c.coll_full_cost_rur
		, c.coll_market_cost_rur
		, c.coll_fair_cost_rur
		, c.coll_kind_cd
		, c.coll_fair_prior_flg
		, d.ead/SUM(d.ead) OVER(PARTITION BY d.report_dt, c.coll_core_id) AS coll_weight
		, d.t_source_system_id
	FROM sbx.ref_params AS dp 
	JOIN sbx.portfolio_deal AS d
		ON d.report_dt = dp.report_dt
	JOIN lnkcol AS c
		ON	c.report_dt = d.report_dt
		AND c.deal_core_id = d.deal_core_id           
)
, coll_weight AS (
	SELECT
		  d.report_dt
		/* Клиент */
	    , d.client_core_id
		/* Сделка */
	    , d.deal_core_id
	    , d.ead
		/* Залогодатель */
	    , d.pledger_id
		/* Обеспечение */
	    , d.coll_core_main_iD
	    , d.coll_core_id   
	    , d.coll_nbr
	    , d.coll_pr_nm
		, d.coll_amt_rur
	    , d.coll_fin_oper_code
		, d.coll_quality_catg
		, d.coll_full_cost_rur
		, d.coll_market_cost_rur
		, d.coll_fair_cost_rur
		, d.coll_kind_cd
		, d.coll_weight
		, d.coll_fair_prior_flg
		/* Залоговая стоимость */
		, CAST(NVL(d.coll_full_cost_rur, d.coll_amt_rur) * d.coll_weight AS DECIMAL(38,17))  AS coll_full_amt_rur		/* Аллоцированная сумма полной стоимости обеспечения */
		/* Рыночная стоимость */
		, CAST(d.coll_market_cost_rur * d.coll_weight AS DECIMAL(38,17)) AS coll_market_amt_rur	/* Аллоцированная сумма рыночной стоимости обеспечения */
		/* Справедливая стоимость */
		, CAST(d.coll_fair_cost_rur * d.coll_weight AS DECIMAL(38,17)) AS coll_fair_amt_rur	/* Аллоцированная сумма справделивой стоимости обеспечения */
		, d.t_source_system_id
	FROM split AS d	
)
SELECT
	  d.report_dt
	/* Клиент */
    , d.client_core_id
	/* Сделка */
    , d.deal_core_id
    , d.ead
	/* Залогодатель */
    , d.pledger_id
	/* Обеспечение */
    , d.coll_core_main_id
    , d.coll_core_id  
    , d.coll_nbr
    , d.coll_pr_nm
	, d.coll_amt_rur
    , d.coll_fin_oper_code
	, d.coll_quality_catg
	, d.coll_full_cost_rur
	, d.coll_market_cost_rur
	, d.coll_fair_cost_rur
	, d.coll_kind_cd
	, d.coll_fair_prior_flg
	, d.coll_weight
	/* Залоговая стоимость */
	, CASE
		WHEN d.coll_weight >= 1 and nvl(d.coll_full_amt_rur, 0) > d.ead 
			THEN d.ead 
		ELSE d.coll_full_amt_rur
	  END AS coll_full_amt_rur /* Аллоцированная сумма полной стоимости обеспечения */
	/* Рыночная стоимость */
	, CASE
		WHEN d.coll_weight >= 1 and nvl(d.coll_market_amt_rur, 0) > d.ead 
			THEN d.ead
		ELSE d.coll_market_amt_rur
	  END AS coll_market_amt_rur/* Аллоцированная сумма рыночной стоимости обеспечения */
	/* Справедливая стоимость */
	, CASE
		WHEN d.coll_weight >= 1 and nvl(d.coll_fair_amt_rur, 0) > d.ead 
			THEN d.ead 
		ELSE d.coll_fair_amt_rur 
	  END AS coll_fair_amt_rur /* Аллоцированная сумма справделивой стоимости обеспечения */
	, d.t_source_system_id
FROM coll_weight AS d
;
DROP TABLE IF EXISTS sbx.lgd_portfolio_collateral_vg_gr 
;
CREATE TABLE sbx.lgd_portfolio_collateral_vg_gr AS 
WITH split_group AS (
	SELECT
		  s.report_dt      
	    , s.client_core_id	/* Контрагент */
	    , s.deal_core_id	/* Сделка */
	    , s.pledger_id		/* Залогодатель */
	    , s.coll_core_id	/* Обеспечение */ 
	    /* Доп атрибуты */
	    /* Группы клиента */
	    , gc.client_wgr_kik
	    , gc.client_wgr_kik_upper
		, gc.grp_stage_id as client_grp_stage_id
	    , gc.tp_grp_stage_id as client_tp_grp_stage_id
	    /* Группы залогодателя */
	    , gp.client_wgr_kik AS pledger_wgr_kik
	    , gp.client_wgr_kik_upper AS pledger_wgr_kik_upper
		, gp.grp_stage_id AS pledger_grp_stage_id
		, gp.tp_grp_stage_id AS pledger_tp_grp_stage_id
	FROM sbx.ref_params AS dp 
	JOIN sbx.lgd_portfolio_collateral_split AS s
		ON s.report_dt = dp.report_dt
	/* Группы контрагента */
	LEFT JOIN sbx.portfolio_client_asvr_grp AS gc	
		ON	gc.report_dt = s.report_dt 
		AND gc.client_core_id = s.client_core_id
	/* Группа залогодатель */
	LEFT JOIN sbx.portfolio_client_asvr_grp AS gp	
		ON	gp.report_dt = s.report_dt 
		AND gp.client_core_id = s.pledger_id
)
SELECT
	  s.report_dt
	/* Контрагент */	  
    , s.client_core_id
	/* Сделка */
    , s.deal_core_id
	/* Залогодатель */
    , s.pledger_id
	/* Обеспечение */
    , s.coll_core_id
    /* Доп атрибуты */
    /* Группы клиента */
    , client_wgr_kik
    , client_wgr_kik_upper
	, client_grp_stage_id
    , client_tp_grp_stage_id
    /* Группы залогодателя */
    , pledger_wgr_kik
    , pledger_wgr_kik_upper
	, pledger_grp_stage_id
    , pledger_tp_grp_stage_id
	, CASE
		WHEN s.client_core_id = s.pledger_id 
			THEN 1
		WHEN s.client_grp_stage_id = s.pledger_grp_stage_id
			AND s.client_wgr_kik = 1
			AND s.pledger_wgr_kik = 1
			THEN 1
		WHEN s.client_grp_stage_id = s.pledger_tp_grp_stage_id
			AND s.client_wgr_kik = 1
			AND s.pledger_wgr_kik = 1
			AND s.pledger_wgr_kik_upper = 1
			THEN 1
		WHEN s.client_tp_grp_stage_id = s.pledger_grp_stage_id
			AND s.client_wgr_kik = 1
			AND s.client_wgr_kik_upper = 1 
			AND s.pledger_wgr_kik = 1
			THEN 1
		WHEN s.client_tp_grp_stage_id = s.pledger_tp_grp_stage_id
			AND s.client_wgr_kik = 1
			AND s.client_wgr_kik_upper = 1
			AND s.pledger_wgr_kik = 1
			AND s.pledger_wgr_kik_upper = 1
			THEN 1
		ELSE 0
	  END AS flag_vn_gr_poruch
FROM split_group AS s	
;
INSERT INTO sbx.coverage_factors_tab
(
	  report_dt
	, client_core_id
	, deal_core_id
	, ead
	, pledger_id
	, coll_core_id
	, coll_kind_cd
	, coll_kind_cost
	, coll_fin_oper_code
	, coll_quality_catg
	, coll_weight
	, coll_full_amt_rur
	, coll_market_amt_rur
	, coll_fair_amt_rur
	, flag_vn_gr_poruch
	, pledger_rating_ttc
	, pled_prop_all_kk_full_amt_rur
    , pled_real_all_kk_full_amt_rur
	, pled_prop_1_2_kk_full_amt_rur
	, pled_real_1_2_kk_full_amt_rur
    , pled_cb_all_kk_full_amt_rur
    , pled_cb_1_kk_full_amt_rur
    , pled_cb_2_kk_full_amt_rur
    , pled_all_kk_full_amt_rur
    , surety_all_kk_full_amt_rur
    , surety_1_kk_full_amt_rur
    , surety_2_kk_full_amt_rur	
    , surety_bb_plus_kk_full_amt_rur
    , guar_dep_all_kk_full_amt_rur 
    , guar_dep_1_kk_full_amt_rur 
    , guar_dep_2_kk_full_amt_rur 
    , pled_prop_all_kk_market_amt_rur       
    , pled_real_all_kk_market_amt_rur
	, pled_prop_1_2_kk_market_amt_rur
    , pled_real_1_2_kk_market_amt_rur
    , pled_cb_all_kk_market_amt_rur
    , pled_cb_1_kk_market_amt_rur
    , pled_cb_2_kk_market_amt_rur
   	, pled_all_kk_market_amt_rur
    , pled_prop_all_kk_fair_amt_rur
    , pled_real_all_kk_fair_amt_rur
	, pled_prop_1_2_kk_fair_amt_rur
    , pled_real_1_2_kk_fair_amt_rur
    , pled_cb_all_kk_fair_amt_rur
    , pled_cb_1_kk_fair_amt_rur
    , pled_cb_2_kk_fair_amt_rur
    , pled_all_kk_fair_amt_rur
    , surety_all_kk_fair_amt_rur
    , surety_1_kk_fair_amt_rur
    , surety_2_kk_fair_amt_rur	
    , surety_bb_plus_kk_fair_amt_rur
    , guar_dep_all_kk_fair_amt_rur 
    , guar_dep_1_kk_fair_amt_rur 
    , guar_dep_2_kk_fair_amt_rur 
	, num_surety_all_kk_amt_rur
    , num_prop_all_kk_amt_rur
    , num_real_all_kk_amt_rur
    , num_cb_all_kk_amt_rur
	/* Технические атрибуты */
	, valid_from_dttm
	, valid_to_dttm
	, t_source_system_id
	, t_changed_dttm
	, t_deleted_flg
	, t_active_flg
	, t_author
	, t_process_task_id	
)
with split1 AS (
	SELECT
		  s.report_dt
	    /* Контрагент */
	    , s.client_core_id		
	    /* Сделка */
	    , s.deal_core_id 
	    , s.ead
	    /* Залогодатель */
	    , s.pledger_id
	    , cp.client_rating_ttc AS pledger_rating_ttc
	    /* Обеспечение */
	    , s.coll_core_id  
	    , s.coll_fin_oper_code
	    , s.coll_quality_catg
		, s.coll_weight
	    , s.coll_full_amt_rur
	    , s.coll_market_amt_rur
		, s.coll_fair_amt_rur
		, s.coll_kind_cd
		, s.coll_fair_prior_flg
	    /* Доп атрибуты */
	    , vg.flag_vn_gr_poruch
		, s.t_source_system_id
	FROM sbx.ref_params AS dp 
	JOIN sbx.lgd_portfolio_collateral_split AS s
		ON s.report_dt = dp.report_dt
	LEFT JOIN sbx.lgd_portfolio_collateral_vg_gr AS vg
		ON	vg.report_dt = s.report_dt
		AND vg.client_core_id = s.client_core_id
		AND vg.deal_core_id = s.deal_core_id
		AND vg.coll_core_id = s.coll_core_id
	     /* Залогодатель*/
	LEFT JOIN sbx.portfolio_client_asvr AS cp	
		ON	cp.report_dt = s.report_dt
		AND cp.client_core_id = s.pledger_id
)
, coverage_factor AS (
	/* Факторы покрытия портфеля */
	SELECT
		  sp.report_dt
		/* Контрагент */
		, client_core_id
		/* Сделка */
		, deal_core_id
		, ead
		/* Залогодатель */
		, pledger_id
		/* Обеспечение */
		, coll_core_id 
		, coll_fin_oper_code
		, coll_quality_catg
		, coll_weight
		, coll_full_amt_rur
		, coll_market_amt_rur
		, coll_fair_amt_rur
		, coll_kind_cd	
		, CASE
			WHEN coll_fair_prior_flg = 1
				THEN 'fair'
			WHEN coll_kind_cd IN ('guar_dep', 'pled_prop', 'pled_real', 'pled_cb') 
				AND coll_quality_catg IN ('1', '2')
				THEN 'fair'
			WHEN coll_kind_cd IN ('surety') 
				AND coll_quality_catg IN ('1', '2')
				AND NVL(coll_fair_amt_rur, 0) > 0
				THEN 'fair'
			ELSE 'full'
		  END AS coll_kind_cost
		/* Доп атрибуты */
		, flag_vn_gr_poruch
		, pledger_rating_ttc
		/* Полная стоимость ==================================================== */
		/* Залоги имущества все категории качества залоговая стоимость */
		, CASE
			WHEN coll_kind_cd = 'pled_prop'
				THEN coll_full_amt_rur
		  END AS pled_prop_all_kk_full_amt_rur
		/* Залоги недвижимости все категории качества залоговая стоимость */
		, CASE
			WHEN coll_kind_cd = 'pled_real'
				THEN coll_full_amt_rur
		  END AS pled_real_all_kk_full_amt_rur
		/* Залоги имущества 1 и 2 категории качества залоговая стоимость */
		, CASE
			WHEN coll_kind_cd = 'pled_prop' 
				AND (coll_quality_catg = '1' OR coll_quality_catg = '2')
				THEN coll_full_amt_rur
		  END AS pled_prop_1_2_kk_full_amt_rur
		/* Залоги недвижимости 1 и 2 категории качества залоговая стоимость */
		, CASE
			WHEN coll_kind_cd = 'pled_real'
				AND (coll_quality_catg = '1' OR coll_quality_catg = '2')
				THEN coll_full_amt_rur
		  END AS pled_real_1_2_kk_full_amt_rur
		/* Залоги ПАИ и ЦБ все категории качества залоговая стоимость*/
		, CASE
			WHEN coll_kind_cd = 'pled_cb'
				THEN coll_full_amt_rur
		  END AS pled_cb_all_kk_full_amt_rur 
		/* Залоги ПАИ и ЦБ 1 категории качества залоговая стоимость*/
		, CASE
			WHEN coll_kind_cd = 'pled_cb'
				AND coll_quality_catg = '1'
				THEN coll_full_amt_rur
	      END AS pled_cb_1_kk_full_amt_rur 
	    /* Залоги ПАИ и ЦБ 2 категории качества залоговая стоимость*/
	    , CASE
			WHEN coll_kind_cd = 'pled_cb'
				AND coll_quality_catg = '2'
				THEN coll_full_amt_rur
	      END AS pled_cb_2_kk_full_amt_rur 
	    /* Залоги Все категории качества залоговая стоимость*/
	    , CASE
			WHEN NVL(coll_kind_cd, 'not_define') NOT IN ('surety', 'not_define')
			THEN coll_full_amt_rur
		  END AS pled_all_kk_full_amt_rur
		/* Поручительства Все категории качества с материальностью к EAD 50%*/
		, CASE
			WHEN coll_kind_cd = 'surety'
			    AND flag_vn_gr_poruch = 0
				THEN coll_full_amt_rur 
		  END AS surety_all_kk_full_amt_rur
		/* Поручительства 1 категории  качества c учетом материальности и без внутригруппового флага*/
		, CASE
			WHEN coll_kind_cd = 'surety'
				AND flag_vn_gr_poruch = 0
				AND coll_quality_catg = '1'
				THEN coll_full_amt_rur 
		  END AS surety_1_kk_full_amt_rur
		/* Поручительства 2 категории качества c учетом материальности и без внутригруппового флага*/
		, CASE
			WHEN coll_kind_cd = 'surety'
				AND flag_vn_gr_poruch = 0
				AND coll_quality_catg = '2'
				THEN coll_full_amt_rur 
		  END AS surety_2_kk_full_amt_rur
		/* Поручительства c рейтингом bb + и выше категории качества с материальностью к EAD 50%*/
		, CASE
			WHEN coll_kind_cd = 'surety'
				AND flag_vn_gr_poruch = 0
				AND pledger_rating_ttc IN ('AAA' , 'AA+' , 'AA' , 'AA-' , 'A+' , 'A' , 'A-' , 'BBB+', 'BBB', 'BBB-', 'BB+')
				THEN coll_full_amt_rur 
		  END AS surety_bb_plus_kk_full_amt_rur
		/* Залоговая стоимость гарантийного дипозита с материальность к EAD 50%*/
		, CASE
			WHEN coll_kind_cd = 'guar_dep'
				THEN coll_full_amt_rur
		  END AS guar_dep_all_kk_full_amt_rur
		/* Залоговая стоимость гарантийного дипозита 1 категории с материальность к EAD 50%*/
		, CASE
			WHEN coll_kind_cd = 'guar_dep'
				AND coll_quality_catg = '1'
				THEN coll_full_amt_rur
		  END AS guar_dep_1_kk_full_amt_rur
		/* Залоговая стоимость гарантийного дипозита 2 категории с материальность к EAD 50%*/
		, CASE
			WHEN coll_kind_cd = 'guar_dep'
				AND coll_quality_catg = '2'
				THEN coll_full_amt_rur
		  END AS guar_dep_2_kk_full_amt_rur
		/* Рынок ===================================================*/
		/* Залоги имущества все категории качества рыночная стоимость*/
		, CASE
			WHEN coll_kind_cd = 'pled_prop'
				THEN coll_market_amt_rur
		  END AS pled_prop_all_kk_market_amt_rur
		/* Залоги недвижимости все категории качества рыночная стоимость*/
		, CASE
			WHEN coll_kind_cd = 'pled_real'
				THEN coll_market_amt_rur
		  END AS pled_real_all_kk_market_amt_rur
		/* Залоги имущества 1 и 2 категории качества рыночная стоимость*/  
		, CASE
			WHEN coll_kind_cd = 'pled_prop' 
				AND (coll_quality_catg = '1' OR coll_quality_catg = '2')
				THEN coll_market_amt_rur
		  END AS pled_prop_1_2_kk_market_amt_rur
		/* Залоги недвижимости 1 и 2 категории качества рыночная стоимость */
		, CASE
			WHEN coll_kind_cd = 'pled_real'
				AND (coll_quality_catg = '1' OR coll_quality_catg = '2')
				THEN coll_market_amt_rur
		  END AS pled_real_1_2_kk_market_amt_rur
		/* Залоги ПАИ и ЦБ все категории качества рыночная стоимость*/
		, CASE
			WHEN coll_kind_cd = 'pled_cb'
				THEN coll_market_amt_rur
		  END AS pled_cb_all_kk_market_amt_rur
		/* Залоги ПАИ и ЦБ все категории качества рыночная стоимость*/
		, CASE
			WHEN coll_kind_cd = 'pled_cb'
				AND coll_quality_catg = '1'   
				THEN coll_market_amt_rur
		  END AS pled_cb_1_kk_market_amt_rur
		/* Залоги ПАИ и ЦБ все категории качества рыночная стоимость*/
		, CASE
			WHEN coll_kind_cd = 'pled_cb'
				AND coll_quality_catg = '2'
				THEN coll_market_amt_rur
		  END AS pled_cb_2_kk_market_amt_rur
		/* Залоги Все категории качества рыночная стоимость*/
		, CASE
			WHEN NVL(coll_kind_cd, 'not_define') NOT IN ('surety', 'not_define')
				THEN coll_market_amt_rur 
		  END AS pled_all_kk_market_amt_rur
		/* Справедливая стоимость ==================================================== */
		/* Залоги имущества все категории качества */
		, CASE
			WHEN coll_kind_cd = 'pled_prop'
				THEN coll_fair_amt_rur
		  END AS pled_prop_all_kk_fair_amt_rur
		/* Залоги недвижимости все категории качества */
		, CASE
			WHEN coll_kind_cd = 'pled_real'
				THEN coll_fair_amt_rur
		  END AS pled_real_all_kk_fair_amt_rur
		/* Залоги имущества 1 и 2 категории качества справедливая стоимость*/  
		, CASE
			WHEN coll_kind_cd = 'pled_prop' 
				AND (coll_quality_catg = '1' OR coll_quality_catg = '2')
				THEN coll_fair_amt_rur
		  END AS pled_prop_1_2_kk_fair_amt_rur
		/* Залоги недвижимости 1 и 2 категории качества справедливая стоимость */
		, CASE
			WHEN coll_kind_cd = 'pled_real'
				AND (coll_quality_catg = '1' OR coll_quality_catg = '2')
				THEN coll_fair_amt_rur
		  END AS pled_real_1_2_kk_fair_amt_rur
		, CASE
			WHEN coll_kind_cd = 'pled_cb'
				THEN coll_fair_amt_rur
		  END AS pled_cb_all_kk_fair_amt_rur 
		/* Залоги ПАИ и ЦБ 1 категории качества */
		, CASE
			WHEN coll_kind_cd = 'pled_cb'
				AND coll_quality_catg = '1'
				THEN coll_fair_amt_rur
		  END AS pled_cb_1_kk_fair_amt_rur 
		/* Залоги ПАИ и ЦБ 2 категории качества */
		, CASE
			WHEN coll_kind_cd = 'pled_cb'
				AND coll_quality_catg = '2'
				THEN coll_fair_amt_rur
		  END AS pled_cb_2_kk_fair_amt_rur 
		/* Залоги Все категории качества залоговая стоимость*/
		, CASE
			WHEN NVL(coll_kind_cd, 'not_define') NOT IN ('surety', 'not_define')
				THEN coll_fair_amt_rur 
		  END AS pled_all_kk_fair_amt_rur
		/* Поручительства Все категории качества с материальностью к EAD 50%*/
		, CASE
			WHEN coll_kind_cd = 'surety'
				AND flag_vn_gr_poruch = 0
				THEN coll_fair_amt_rur 
		  END AS surety_all_kk_fair_amt_rur
		/* Поручительства 1 категории  качества c учетом материальности и без внутригруппового флага*/
		, CASE
			WHEN coll_kind_cd = 'surety'
				AND flag_vn_gr_poruch = 0
				AND coll_quality_catg = '1'
				THEN coll_fair_amt_rur 
		  END AS surety_1_kk_fair_amt_rur
		/* Поручительства 2 категории качества c учетом материальности и без внутригруппового флага*/
		, CASE
			WHEN coll_kind_cd = 'surety'
				AND flag_vn_gr_poruch = 0
				AND coll_quality_catg = '2'
				THEN coll_fair_amt_rur 
		  END AS surety_2_kk_fair_amt_rur
		/* Поручительства c рейтингом bb + и выше категории качества с материальностью к EAD 50%*/
		, CASE
			WHEN coll_kind_cd = 'surety'
				AND flag_vn_gr_poruch = 0
				AND pledger_rating_ttc IN ('AAA' , 'AA+' , 'AA' , 'AA-' , 'A+' , 'A' , 'A-' , 'BBB+', 'BBB', 'BBB-', 'BB+')
				THEN coll_fair_amt_rur 
		  END AS surety_bb_plus_kk_fair_amt_rur
		/* Залоговая стоимость гарантийного дипозита с материальность к EAD 50%*/
		, CASE
			WHEN coll_kind_cd = 'guar_dep'
				THEN coll_fair_amt_rur
		  END AS guar_dep_all_kk_fair_amt_rur
		/* Залоговая стоимость гарантийного дипозита 1 категории с материальность к EAD 50%*/
		, CASE
			WHEN coll_kind_cd = 'guar_dep'
				AND coll_quality_catg = '1'
				THEN coll_fair_amt_rur
		  END AS guar_dep_1_kk_fair_amt_rur
		/* Залоговая стоимость гарантийного дипозита 2 категории с материальность к EAD 50%*/
		, CASE
			WHEN coll_kind_cd = 'guar_dep'
				AND coll_quality_catg = '2'
				THEN coll_fair_amt_rur
		  END AS guar_dep_2_kk_fair_amt_rur
		/* Счетчики  ==================================================== */
		/* Кол-во поручительств Все категории качества с материальностью к EAD 50%*/
		, CASE
			WHEN coll_kind_cd = 'surety'  
				AND flag_vn_gr_poruch = 0
				THEN coll_core_id
		  END AS num_surety_all_kk_amt_rur
		/* Кол-во залогов имущества все категории качества*/
		, CASE
			WHEN coll_kind_cd = 'pled_prop'
				THEN coll_core_id
		  END AS num_prop_all_kk_amt_rur
		/* Кол-во залогов недвижимости все категории качества*/
		, CASE
			WHEN coll_kind_cd = 'pled_real'
				THEN coll_core_id
		  END num_real_all_kk_amt_rur
		/* Кол-во залогов ПАИ и ЦБ все категории качества*/
		, CASE
			WHEN coll_kind_cd = 'pled_cb'
				THEN coll_core_id
		  END num_cb_all_kk_amt_rur
	, t_source_system_id
FROM split1 AS sp
)
SELECT
	report_dt
    /* Контрагент */
    , client_core_id 
    /* Сделка */
    , deal_core_id
	, ead   
    /* Залогодатель */
    , pledger_id
    /* Обеспечение */
    , coll_core_id 
	, coll_kind_cd
    , coll_kind_cost
    , coll_fin_oper_code
    , coll_quality_catg
	, CAST(coll_weight as DECIMAL(38,17)) as coll_weight
    , CAST(coll_full_amt_rur	AS DECIMAL(38,17))  AS coll_full_amt_rur
    , CAST(coll_market_amt_rur	AS DECIMAL(38,17))  AS coll_market_amt_rur
    , CAST(coll_fair_amt_rur	AS DECIMAL(38,17)) 	AS coll_fair_amt_rur
    /* Доп атрибуты */
    , flag_vn_gr_poruch
    , pledger_rating_ttc
    /* Полная стоимость =================================================== */
    , CAST(pled_prop_all_kk_full_amt_rur	AS DECIMAL(38,17)) 	AS pled_prop_all_kk_full_amt_rur
    , CAST(pled_real_all_kk_full_amt_rur	AS DECIMAL(38,17)) 	AS pled_real_all_kk_full_amt_rur
	, CAST(pled_prop_1_2_kk_full_amt_rur	AS DECIMAL(38,17)) 	AS pled_prop_1_2_kk_full_amt_rur
	, CAST(pled_real_1_2_kk_full_amt_rur	AS DECIMAL(38,17)) 	AS pled_real_1_2_kk_full_amt_rur
    , CAST(pled_cb_all_kk_full_amt_rur		AS DECIMAL(38,17)) 	AS pled_cb_all_kk_full_amt_rur
    , CAST(pled_cb_1_kk_full_amt_rur		AS DECIMAL(38,17)) 	AS pled_cb_1_kk_full_amt_rur
    , CAST(pled_cb_2_kk_full_amt_rur		AS DECIMAL(38,17)) 	AS pled_cb_2_kk_full_amt_rur
    , CAST(pled_all_kk_full_amt_rur			AS DECIMAL(38,17))	AS pled_all_kk_full_amt_rur
    , CAST(surety_all_kk_full_amt_rur		AS DECIMAL(38,17)) 	AS surety_all_kk_full_amt_rur
    , CAST(surety_1_kk_full_amt_rur			AS DECIMAL(38,17)) 	AS surety_1_kk_full_amt_rur
    , CAST(surety_2_kk_full_amt_rur			AS DECIMAL(38,17)) 	AS surety_2_kk_full_amt_rur	
    , CAST(surety_bb_plus_kk_full_amt_rur	AS DECIMAL(38,17)) 	AS surety_bb_plus_kk_full_amt_rur
    , CAST(guar_dep_all_kk_full_amt_rur    	AS DECIMAL(38,17)) 	AS guar_dep_all_kk_full_amt_rur
    , CAST(guar_dep_1_kk_full_amt_rur		AS DECIMAL(38,17))	AS guar_dep_1_kk_full_amt_rur
    , CAST(guar_dep_2_kk_full_amt_rur		AS DECIMAL(38,17))	AS guar_dep_2_kk_full_amt_rur
    /* Рыночаня стоимость =================================================== */
    , CAST(pled_prop_all_kk_market_amt_rur	AS DECIMAL(38,17)) 	AS pled_prop_all_kk_market_amt_rur      
    , CAST(pled_real_all_kk_market_amt_rur	AS DECIMAL(38,17)) 	AS pled_real_all_kk_market_amt_rur
	, CAST(pled_prop_1_2_kk_market_amt_rur	AS DECIMAL(38,17)) 	AS pled_prop_1_2_kk_market_amt_rur
	, CAST(pled_real_1_2_kk_market_amt_rur	AS DECIMAL(38,17)) 	AS pled_real_1_2_kk_market_amt_rur
    , CAST(pled_cb_all_kk_market_amt_rur	AS DECIMAL(38,17))	AS pled_cb_all_kk_market_amt_rur
    , CAST(pled_cb_1_kk_market_amt_rur		AS DECIMAL(38,17))	AS pled_cb_1_kk_market_amt_rur
    , CAST(pled_cb_2_kk_market_amt_rur		AS DECIMAL(38,17))	AS pled_cb_2_kk_market_amt_rur
   	, CAST(pled_all_kk_market_amt_rur		AS DECIMAL(38,17))	AS pled_all_kk_market_amt_rur
    /* Справедливая стоимость =================================================== */
    , CAST(pled_prop_all_kk_fair_amt_rur	AS DECIMAL(38,17)) 	AS pled_prop_all_kk_fair_amt_rur
    , CAST(pled_real_all_kk_fair_amt_rur	AS DECIMAL(38,17)) 	AS pled_real_all_kk_fair_amt_rur
	, CAST(pled_prop_1_2_kk_fair_amt_rur	AS DECIMAL(38,17)) 	AS pled_prop_1_2_kk_fair_amt_rur
	, CAST(pled_real_1_2_kk_fair_amt_rur	AS DECIMAL(38,17)) 	AS pled_real_1_2_kk_fair_amt_rur
    , CAST(pled_cb_all_kk_fair_amt_rur		AS DECIMAL(38,17)) 	AS pled_cb_all_kk_fair_amt_rur
    , CAST(pled_cb_1_kk_fair_amt_rur		AS DECIMAL(38,17)) 	AS pled_cb_1_kk_fair_amt_rur
    , CAST(pled_cb_2_kk_fair_amt_rur		AS DECIMAL(38,17)) 	AS pled_cb_2_kk_fair_amt_rur
    , CAST(pled_all_kk_fair_amt_rur			AS DECIMAL(38,17))	AS pled_all_kk_fair_amt_rur
    , CAST(surety_all_kk_fair_amt_rur		AS DECIMAL(38,17)) 	AS surety_all_kk_fair_amt_rur
    , CAST(surety_1_kk_fair_amt_rur			AS DECIMAL(38,17)) 	AS surety_1_kk_fair_amt_rur
    , CAST(surety_2_kk_fair_amt_rur			AS DECIMAL(38,17)) 	AS surety_2_kk_fair_amt_rur
    , CAST(surety_bb_plus_kk_fair_amt_rur	AS DECIMAL(38,17)) 	AS surety_bb_plus_kk_fair_amt_rur
    , CAST(guar_dep_all_kk_fair_amt_rur    	AS DECIMAL(38,17)) 	AS guar_dep_all_kk_fair_amt_rur
    , CAST(guar_dep_1_kk_fair_amt_rur		AS DECIMAL(38,17))	AS guar_dep_1_kk_fair_amt_rur 
    , CAST(guar_dep_2_kk_fair_amt_rur		AS DECIMAL(38,17))	AS guar_dep_2_kk_fair_amt_rur 
    /* Кол-во типов обеспечений =================================================== */
	, CAST(num_surety_all_kk_amt_rur		AS INT)				AS num_surety_all_kk_amt_rur
    , CAST(num_prop_all_kk_amt_rur  		AS DECIMAL(38,17))  AS num_prop_all_kk_amt_rur
    , CAST(num_real_all_kk_amt_rur   		AS DECIMAL(38,17))  AS num_real_all_kk_amt_rur
    , CAST(num_cb_all_kk_amt_rur   			AS DECIMAL(38,17))  AS num_cb_all_kk_amt_rur
	, CAST(now() AS TIMESTAMP)				AS valid_from_dttm
	, CAST('2100-01-01 00:00:00' AS TIMESTAMP) AS valid_to_dttm
	, t_source_system_id
	, CAST(now() AS timestamp) 	AS T_CHANGED_DTTM
	, CAST(0 AS TINYINT)		AS T_DELETED_FLG
	, CAST(1 AS TINYINT)		AS T_ACTIVE_FLG
	, CAST(NULL AS STRING) 		AS T_AUTHOR
	, CAST(NULL AS INTEGER)		AS T_PROCESS_TASK_ID
FROM coverage_factor 
;
/* технические проверки прототипа */
/* Дубли по PK */
SELECT report_dt, client_core_id, deal_core_id, coll_core_id, COUNT(*)
FROM sbx.coverage_factors
GROUP BY report_dt, client_core_id, deal_core_id, coll_core_id
HAVING COUNT(*) > 1
LIMIT 100
;
/* NULL в PK */
SELECT *
FROM sbx.coverage_factors
WHERE report_dt IS NULL 
	OR client_core_id IS NULL
	OR deal_core_id IS NULL
	OR coll_core_id IS NULL
LIMIT 100


/*
Название:	Витрина 3 - Группы клиента
Описание:	Основной массив данных в представляет собой связь Группы (Рег, Топ) с клиентом АС ВР, производится расчет дополнительных атрибутов с учетом веса связи между группой и клиентом
Прототип на выходе формирует витрины:
	1) portfolio_client_asvr_grp_tab - техническая таблица.
	2) portfolio_client_asvr_grp – итоговая пользовательская вью.
---------------
*/
DROP TABLE IF EXISTS sbxc_006_053.portfolio_client_asvr_grp_tab 
;
CREATE TABLE sbxc_006_053.portfolio_client_asvr_grp_tab 
(
	  report_dt							DATE 		  	COMMENT 'Отчетная дата'			/*PK*/
	, client_core_id					BIGINT		 	COMMENT 'Ид клиента из core'	/*PK*/
	, client_asvr_id                    BIGINT          COMMENT 'Идентификатор клиента из АС ВР'
	, client_stage_id					BIGINT 			COMMENT 'Ид клиента из stage'
	, client_ind_nm						STRING			COMMENT 'Отрасль клиента'
	, client_lrg_ind_nm					STRING 			COMMENT 'Укрупнённая отрасль клиента'
	, client_irbf_nm					STRING 			COMMENT 'IRBF сегмент клиента'
	, client_wgr						DECIMAL(38,17) 	COMMENT 'Веса групповой поддержки'
	, client_wgr_kik					DECIMAL(38,17) 	COMMENT 'Веса групповой поддержки c учетом КиК на клиенте'
	, client_wgr_kik_upper				DECIMAL(38,17) 	COMMENT 'Веса групповой поддержки c учетом КиК на рег. группы'
	, client_cur_assets					DECIMAL(38,17) 	COMMENT 'Оборотные Активы клиента'
	, grp_stage_id						BIGINT 			COMMENT 'Ид рег. группы'
	, grp_ind_nm 						STRING 			COMMENT 'Отрасль рег. группы'
	, grp_lrg_ind_nm 					STRING 			COMMENT 'Укрупнённая отрасль рег. группы'
	, grp_irbf_nm						STRING 			COMMENT 'IRBF сегмент рег. группы'
	, grp_assets						DECIMAL(38,17) 	COMMENT 'Совокупные Активы рег. группы'
	, grp_cur_assets					DECIMAL(38,17) 	COMMENT 'Оборотные Активы рег. группы'
	, tp_grp_stage_id					BIGINT 			COMMENT 'Ид топ группы'
	, client_ind_nm_up_wgr_kik 			STRING 			COMMENT 'Отрасль с учетом связи wgr_kik'
	, client_lrg_ind_nm_up_wgr_kik 		STRING 			COMMENT 'Укрупнённая отрасль с учетом связи wgr_kik'
	, client_irbf_nm_up_wgr_kik			STRING 			COMMENT 'IRBF сегмент с учетом связи wgr_kik'
	, client_irbf_nm_up_wgr_kik_flg		TINYINT 		COMMENT 'Флаг МСБ укрупнённая отрасль с учетом связи wgr_kik'
	, client_csh_inv_cur_liab_with_grp 	DECIMAL(38,17) 	COMMENT 'Среднее значение денеж. средства к кратк. обязательствам c учетом группы'
	, client_osnov_srva_td_with_grp		DECIMAL(38,17) 	COMMENT 'Основные средства с учетом группы / Общую задолженность с учетом группы'
    , client_gross_prof_marg_with_grp	DECIMAL(38,17) 	COMMENT 'Валовая прибыль с учетом группы / Выручка с учетом группы'
	, client_lrg_ind_nm_bucket			STRING 			COMMENT 'Распределение контрагентов на группы с учетом укрупненной отрасли, связи wgr_kik и Флага МСБ'
	, t_source_system_id              	SMALLINT       	COMMENT 'Идентификатор системы-источника'
    , t_changed_dttm                  	TIMESTAMP      	COMMENT 'Дата и время изменения записи'
    , t_deleted_flg                   	TINYINT        	COMMENT 'Признак удаления записи'
    , t_author                        	STRING         	COMMENT 'Имя джоба'
    , T_PROCESS_TASK_ID               	INT         	COMMENT 'Идентификатор процесса загрузки'

)
COMMENT 'Витрина 3 - Группы клиента'
;
DROP VIEW IF EXISTS sbxc_006_053.portfolio_client_asvr_grp
;
CREATE VIEW sbxc_006_053.portfolio_client_asvr_grp
/* SPMPLN-20181: Проставление комментариев к атрибутам пользовательской вью */
(
	  report_dt							COMMENT 'PK | Отчетная дата'
	, client_core_id					COMMENT 'PK | Идентификатор клиента из core'
	, client_asvr_id                    COMMENT 'Идентификатор клиента из АС ВР'
	, client_stage_id					COMMENT 'NN | Идентификатор клиента из stage'
	, client_ind_nm						COMMENT 'Отрасль клиента'
	, client_lrg_ind_nm					COMMENT 'Укрупнённая отрасль клиента'
	, client_irbf_nm					COMMENT 'IRBF сегмент клиента'
	, client_wgr						COMMENT 'Веса групповой поддержки'
	, client_wgr_kik					COMMENT 'Веса групповой поддержки c учетом КиК на клиенте'
	, client_wgr_kik_upper				COMMENT 'Веса групповой поддержки c учетом КиК на рег. группы'
	, client_cur_assets					COMMENT 'Оборотные активы клиента'
	, grp_stage_id						COMMENT 'Идентификатор рег. группы'
	, grp_ind_nm 						COMMENT 'Отрасль рег. группы'
	, grp_lrg_ind_nm 					COMMENT 'Укрупнённая отрасль рег. группы'
	, grp_irbf_nm						COMMENT 'IRBF сегмент рег. группы'
	, grp_assets						COMMENT 'Совокупные активы рег. группы'
	, grp_cur_assets					COMMENT 'Оборотные активы рег. группы'
	, tp_grp_stage_id					COMMENT 'Идентификатор топ-группы'
	, client_ind_nm_up_wgr_kik 			COMMENT 'Отрасль с учетом связи wgr_kik'
	, client_lrg_ind_nm_up_wgr_kik 		COMMENT 'Укрупнённая отрасль с учетом связи wgr_kik'
	, client_irbf_nm_up_wgr_kik			COMMENT 'IRBF сегмент с учетом связи wgr_kik'
	, client_irbf_nm_up_wgr_kik_flg		COMMENT 'NN | Флаг МСБ укрупнённая отрасль с учетом связи wgr_kik'
	, client_csh_inv_cur_liab_with_grp 	COMMENT 'Среднее значение денеж. средств к кратк. обязательствам c учетом группы'
	, client_osnov_srva_td_with_grp		COMMENT 'Основные средства с учетом группы / Общую задолженность с учетом группы'
    , client_gross_prof_marg_with_grp	COMMENT 'Валовая прибыль с учетом группы / Выручка с учетом группы'
	, client_lrg_ind_nm_bucket			COMMENT 'NN | Распределение контрагентов на группы с учетом укрупненной отрасли, связи wgr_kik и флага МСБ'
	, t_source_system_id              	COMMENT 'NN | Идентификатор системы-источника'
    , t_changed_dttm                  	COMMENT 'NN | Дата и время изменения записи'
    , t_process_task_id               	COMMENT 'NN | Идентификатор процесса загрузки'
)
AS SELECT
	  report_dt
	, client_core_id
	, client_asvr_id
	, client_stage_id
	, client_ind_nm
	, client_lrg_ind_nm
	, client_irbf_nm
	, client_wgr
	, client_wgr_kik
	, client_wgr_kik_upper
	, client_cur_assets
	, grp_stage_id
	, grp_ind_nm
	, grp_lrg_ind_nm
	, grp_irbf_nm
	, grp_assets
	, grp_cur_assets
	, tp_grp_stage_id
	, client_ind_nm_up_wgr_kik
	, client_lrg_ind_nm_up_wgr_kik
	, client_irbf_nm_up_wgr_kik
	, client_irbf_nm_up_wgr_kik_flg
	, client_csh_inv_cur_liab_with_grp
	, client_osnov_srva_td_with_grp
    , client_gross_prof_marg_with_grp
	, client_lrg_ind_nm_bucket
	, t_source_system_id
	, t_changed_dttm
--	, t_author	/* SPMPLN-20181: удаление атрибута */
	, t_process_task_id
FROM sbxc_006_053.portfolio_client_asvr_grp_tab
WHERE t_deleted_flg = 0	
;
INSERT INTO sbxc_006_053.portfolio_client_asvr_grp_tab
(
	  report_dt
	, client_core_id
	, client_asvr_id
	, client_stage_id
	, client_ind_nm
	, client_lrg_ind_nm
	, client_irbf_nm
	, client_wgr
	, client_wgr_kik
	, client_wgr_kik_upper
	, client_cur_assets
	, grp_stage_id
	, grp_ind_nm
	, grp_lrg_ind_nm
	, grp_irbf_nm
	, grp_assets
	, grp_cur_assets
	, tp_grp_stage_id
	, client_ind_nm_up_wgr_kik
	, client_lrg_ind_nm_up_wgr_kik
	, client_irbf_nm_up_wgr_kik
	, client_irbf_nm_up_wgr_kik_flg
	, client_csh_inv_cur_liab_with_grp
	, client_osnov_srva_td_with_grp
    , client_gross_prof_marg_with_grp
	, client_lrg_ind_nm_bucket
	, t_source_system_id
	, t_changed_dttm
	, t_deleted_flg
	, t_author
	, t_process_task_id
)
WITH grp AS (
	SELECT
		  p.report_dt
		/* Контрагент */
		, c.client_core_id
		, c.client_asvr_id
		, c.client_stage_id
		, c.client_industry_nm           AS client_ind_nm
		, c.client_large_industry_nm     AS client_lrg_ind_nm
		, c.client_irbf_nm
		, c.client_wgr
		, c.client_wgr_kik
		, c.assets                       AS client_assets		/* Совокупные активы клиента */
		, c.cur_assets                   AS client_cur_assets	/* Оборотные активы клиента */
		, c.cash_inv_cur_liab_mean_ann   AS client_csh_inv_cur_liab
		, c.osnov_srva_td                AS client_osnov_srva_td
        , c.gross_profit_margin          AS client_gross_profit_margin
		, c.t_source_system_id
		/* Рег группа клиента */
		, g.client_stage_id              AS grp_stage_id
		, g.client_industry_nm           AS grp_ind_nm
		, g.client_large_industry_nm     AS grp_lrg_ind_nm
		, g.client_wgr_kik               AS grp_wgr_kik
		, g.client_irbf_nm               AS grp_irbf_nm
		, g.assets                       AS grp_assets		/* Совокупные активы группы */
		, g.cur_assets                   AS grp_cur_assets	/* Оборотные активы группы */
		, g.cash_inv_cur_liab_mean_ann   AS grp_csh_inv_cur_liab
		, g.osnov_srva_td                AS grp_osnov_srva_td
        , g.gross_profit_margin          AS grp_gross_profit_margin
        , CASE WHEN (g.client_stage_id IS NOT NULL
					AND c.client_wgr >= 0.5) 
			   THEN 1 
		  	   ELSE 0
	 	  END 							 AS grp_wgr_flg
		, CASE WHEN (g.client_stage_id IS NOT NULL
					 AND c.client_wgr_kik >= 0.5) 
			   THEN 1
			   ELSE 0
		   END 							 AS grp_wgr_kik_flg
		/* Топ группа клиента */
		, tg.client_stage_id             AS tp_grp_stage_id
	FROM sbxc_006_053.ref_params AS p
	JOIN sbxc_006_053.portfolio_client_asvr AS c
		ON c.report_dt = p.report_dt
	LEFT JOIN sbxc_006_053.portfolio_client_asvr AS g	
		ON	g.report_dt = c.report_dt
		AND g.client_stage_id = c.grp_stage_id
		AND c.client_grp_lnk = 'reg_grp'
	LEFT JOIN sbxc_006_053.portfolio_client_asvr AS tg	
		ON	tg.report_dt = g.report_dt
		AND tg.client_stage_id = g.grp_stage_id
		AND g.client_grp_lnk = 'top_grp'
)
, grp_assets AS (
	SELECT
		  s.report_dt
		/* Контрагент */
		, s.client_core_id
		, s.client_asvr_id
		, s.client_stage_id
		, s.client_ind_nm
		, s.client_lrg_ind_nm
		, s.client_irbf_nm
		, s.client_wgr
		, CASE
			WHEN s.grp_stage_id IS NOT NULL	/* Только если есть связь с группой */
				THEN s.client_wgr_kik
		  END AS client_wgr_kik
		, s.client_cur_assets				/* Оборотные активы клиента */
		/* Рег группа клиента */
		, s.grp_stage_id
		, s.grp_ind_nm
		, s.grp_lrg_ind_nm
		, s.grp_irbf_nm
		, CASE
			WHEN s.grp_stage_id IS NOT NULL  /* Только если есть связь c группой и топ группой */
				AND s.tp_grp_stage_id IS NOT NULL
	            THEN s.grp_wgr_kik
	       END AS client_wgr_kik_upper
		, s.grp_assets						/* Совокупные активы группы */
		/* Тут понижаем обортные активы если связь плохая */ 
		, CASE
			WHEN (NVL(s.client_wgr,0) >= 0.5
				AND grp_assets IS NOT NULL)	/* Совокупные активы группы */
			    THEN s.grp_cur_assets		/* Оборотные активы группы */
			WHEN (NVL(s.client_wgr,0) < 0.5
				OR grp_assets IS NULL)		/* Совокупные активы группы */
			    THEN s.client_cur_assets	/* Оборотные активы клиента */
		   END AS grp_cur_assets			/* Оборотные активы группы */
		/* Топ группа клиента */
		, s.tp_grp_stage_id
		/* Расчетные атрибуты */
		, s.grp_wgr_flg
		, s.grp_wgr_kik_flg
		, NVL(DECODE(s.grp_wgr_kik_flg, 1, s.grp_ind_nm), s.client_ind_nm) AS client_ind_nm_up_wgr_kik
		, NVL(DECODE(s.grp_wgr_kik_flg, 1, s.grp_lrg_ind_nm), s.client_lrg_ind_nm)	AS client_lrg_ind_nm_up_wgr_kik
		/* Укрупняем Риск-сегмент с учетом риск-сегмента группы */
		, NVL(DECODE(s.grp_wgr_kik_flg, 1, s.grp_irbf_nm), s.client_irbf_nm)	AS client_irbf_nm_up_wgr_kik
		, NVL(DECODE(s.grp_wgr_flg, 1, grp_csh_inv_cur_liab), client_csh_inv_cur_liab)	AS client_csh_inv_cur_liab_with_grp
	    , NVL(DECODE(s.grp_wgr_flg, 1, grp_osnov_srva_td), client_osnov_srva_td) 				AS client_osnov_srva_td_with_grp
		, NVL(DECODE(s.grp_wgr_flg, 1, grp_gross_profit_margin), client_gross_profit_margin) 	AS client_gross_prof_marg_with_grp
		, s.t_source_system_id
	FROM grp AS s
)
, grp_assets_liab AS (
	SELECT
		  s.report_dt
		/* Контрагент */
		, s.client_core_id
		, s.client_asvr_id
	    , s.client_stage_id
		, s.client_ind_nm
	    , s.client_lrg_ind_nm
	    , s.client_irbf_nm
	    , s.client_wgr
	    , s.client_wgr_kik
		, s.client_wgr_kik_upper
	    , s.client_cur_assets                   /* Оборотные активы клиента */
	    /* Рег группа клиента */
	    , s.grp_stage_id
		, s.grp_ind_nm
	    , s.grp_lrg_ind_nm
	    , s.grp_irbf_nm
	    , s.grp_assets                   /* Совокупные активы группы */
	    , s.grp_cur_assets               /* Оборотные активы группы */
	    /* Топ группа клиента */
	    , s.tp_grp_stage_id
	    /* Расчетыне атрибуты */
		, s.client_ind_nm_up_wgr_kik
	    , s.client_lrg_ind_nm_up_wgr_kik
	    , s.client_irbf_nm_up_wgr_kik
	   	, IF(s.client_irbf_nm_up_wgr_kik IN ('Средние корпоративные активы' 
	   	                                    , 'Прочие корпоративные активы (физические лица)'
				                            , 'Прочие корпоративные активы (юридические лица)'
				                            , 'Малые корпоративные активы'
				                            , 'Микро корпоративные активы' )
			, 1, 0) AS client_irbf_nm_up_wgr_kik_flg
		, s.client_csh_inv_cur_liab_with_grp
	    , s.client_osnov_srva_td_with_grp
        , s.client_gross_prof_marg_with_grp
		, s.t_source_system_id
	FROM grp_assets AS s
)
SELECT
	  s.report_dt
	/* Контрагент */
	, s.client_core_id
	, s.client_asvr_id
	, s.client_stage_id
	, s.client_ind_nm
	, s.client_lrg_ind_nm
	, s.client_irbf_nm
	, s.client_wgr
	, s.client_wgr_kik 
	, s.client_wgr_kik_upper
	, s.client_cur_assets		/* Оборотные активы клиента */
	/* Рег группа клиента */
	, s.grp_stage_id
	, s.grp_ind_nm
	, s.grp_lrg_ind_nm
	, s.grp_irbf_nm
	, s.grp_assets		/* Совокупные активы группы */
	, s.grp_cur_assets	/* Оборотные активы группы */
	/* Топ группа клиента */
	, s.tp_grp_stage_id
	/* Расчетыне атрибуты */
	, s.client_ind_nm_up_wgr_kik
	, s.client_lrg_ind_nm_up_wgr_kik
	, s.client_irbf_nm_up_wgr_kik
	, s.client_irbf_nm_up_wgr_kik_flg
	, s.client_csh_inv_cur_liab_with_grp
	, s.client_osnov_srva_td_with_grp
    , s.client_gross_prof_marg_with_grp
	/* Распределяем на корзины */
	, CASE 
		WHEN s.client_lrg_ind_nm_up_wgr_kik IN ('Кредитные организации', 'Угольная', 'Энергетика', 'Газовая', 'ОПК и Роскосмос','Финансовые и Страховые компании','Инвестиции в недвижимость', 'Химия и нефтехимия', 'Нефтяная', 'Атомная')
			THEN CONCAT_WS('.', '1', s.client_lrg_ind_nm_up_wgr_kik)
		WHEN s.client_lrg_ind_nm_up_wgr_kik IN ('Медиа бизнес', 'Связь', 'Лесная промышленность','Строительство','Металлургия','Инфраструктурное строительство')
		    THEN CONCAT_WS('.', '2', s.client_lrg_ind_nm_up_wgr_kik)
		WHEN s.client_lrg_ind_nm_up_wgr_kik IN ('Торговля') AND client_irbf_nm_up_wgr_kik_flg = 0 
		    THEN CONCAT_WS('.', '2', s.client_lrg_ind_nm_up_wgr_kik)
		WHEN s.client_lrg_ind_nm_up_wgr_kik IN ('Транспорт','Машиностроение', 'Пищевая промышленность и АПК', 'Драгоценные металлы', 'Прочая промышленность', 'Прочие')
		    THEN CONCAT_WS('.', '3', s.client_lrg_ind_nm_up_wgr_kik)
		WHEN s.client_lrg_ind_nm_up_wgr_kik IN ('Торговля') AND client_irbf_nm_up_wgr_kik_flg = 1
		    THEN CONCAT_WS('.', '3', s.client_lrg_ind_nm_up_wgr_kik)
		ELSE '5' /* если нет укрепненной отрасли */
	  END AS client_lrg_ind_nm_bucket
	, s.t_source_system_id
	, cast(now() AS timestamp) AS t_changed_dttm
	, cast(0 AS TINYINT) AS t_deleted_flg
	, cast(NULL AS STRING) AS t_author
	, cast(NULL AS INTEGER) AS t_process_task_id
FROM grp_assets_liab AS s
;
/* технические проверки прототипа */
/* Дубли по PK */
SELECT report_dt, client_core_id, COUNT(*)
FROM sbxc_006_053.portfolio_client_asvr_grp
GROUP BY report_dt, client_core_id
HAVING COUNT(*) > 1
LIMIT 100
;
/* NULL в PK */
SELECT *
FROM sbxc_006_053.portfolio_client_asvr_grp
WHERE report_dt IS NULL 
OR client_core_id IS NULL
LIMIT 100


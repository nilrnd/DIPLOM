/*
Название:	Расчеты качественных и групповых показателей по контрагенту
Описание:	Основной массив данных представляет собой расчет качественных и групповых факторов по контрагенту АС ВР.
Прототип на выходе формирует витрины:
	1) RATING_CALC_INDICATORS_TAB	- техническая таблица с SCD-2.
	2) RATING_CALC_INDICATORS		– итоговая пользовательская вью.
*/
DROP TABLE IF EXISTS sbx.rating_calc_indicators_tab 
;
CREATE TABLE IF NOT EXISTS sbx.rating_calc_indicators_tab
(	
      client_asvr_id			BIGINT				COMMENT 'PK | Идентификатор контрагента АС ВР'
    , calculation_asvr_id		BIGINT				COMMENT 'PK | Идентификатор расчета АС ВР'
    , calculation_korpro_guid	STRING				COMMENT 'Идентификатор расчета KORPRO'
/* Качественные факторы */
	, ql_1						STRING				COMMENT 'Поддержка и контроль со стороны акционеров/участников'
	, ql_2						STRING				COMMENT 'Конкуренция и спрос'
	, ql_3						STRING				COMMENT 'Источники финансирования'
	, ql_4						STRING				COMMENT 'Рыночное позиционирование'
	, ql_5						STRING				COMMENT 'Источники погашения'
	, ql_6						STRING				COMMENT 'Рыночная конъюнктура'
	, ql_7						STRING				COMMENT 'Интенсивность конкуренции'
	, ql_8						STRING				COMMENT 'Зависимость от поставщиков/подрядчиков и покупателей/заказчиков'
	, ql_9						STRING				COMMENT 'Кредитная история'
	, ql_10						STRING				COMMENT 'Деловая этика'
	, ql_11						STRING				COMMENT 'Барьеры для доступа в отрасль/Выход на рынки'
/* Групповые факторы */
	, gs_1						STRING				COMMENT 'Юридическая взаимосвязь'
	, gs_2						STRING				COMMENT 'Финансовая взаимосвязь'
	, gs_3						STRING				COMMENT 'Товарно-денежная взаимосвязь'
	, gs_4						STRING				COMMENT 'Стратегическая взаимосвязь'
	, gs_5						STRING				COMMENT 'Репутационная взаимосвязь'
	, gs_6						STRING				COMMENT 'Бизнес-интеграция'
	, gs_9						STRING				COMMENT 'Кредитная репутация'
	, ws_10						STRING				COMMENT 'Стихийные бедствия/техногенные катастрофы'
	, ws_17						STRING				COMMENT 'Непрерывный срок неисполнения платежных обязательств Контрагента перед Банком 30-59 календарных дней'
	, ws_18						STRING				COMMENT 'Непрерывный срок неисполнения платежных обязательств Контрагента перед Банком 60-79 календарных дней'
	, ws_19						STRING				COMMENT 'Непрерывный срок неисполнения платежных обязательств Контрагента перед Банком 80–89 календарных дней'
	, ws_6						STRING				COMMENT 'Отрицательная кредитная история'
	, ws_1						STRING				COMMENT 'Проблемы управления / существенные изменения состава руководства'
	, ws_11						STRING				COMMENT 'Угроза недружественного поглощения'
	, ws_12						STRING				COMMENT 'Представление недостоверных сведений, отчетности'
	, ws_13						STRING				COMMENT 'Нестабильная социальная или политическая ситуация'
	, ws_2						STRING				COMMENT 'Существенные спады на основных рынках'
	, ws_3						STRING				COMMENT 'Существенные судебные разбирательства или налоговые претензии'
	, ws_4						STRING				COMMENT 'Существенные проблемы с дебиторской задолженностью'
	, ws_5						STRING				COMMENT 'Со стороны Контрагента / Группы имеются запросы на вынужденную (с точки зрения Банка) пролонгацию или рефинансирование платежей'
	, ws_7						STRING				COMMENT 'Нарушение дополнительных условий договора'
	, ws_8						STRING				COMMENT 'Разрыв или нарушение сроков основного контракта'
	, ws_9						STRING				COMMENT 'Конфликт акционеров'
	, ws_14						STRING				COMMENT 'Наличие ошибок в финансовой отчетности Контрагента за последние 60 месяцев­ некорректное отображение Процентов к уплате'
	, ws_15						STRING				COMMENT 'Наличие ошибок в актуальной финансовой отчетности Контрагента­ некорректное отображение Процентов к уплате'
	, ws_16_PA					STRING				COMMENT 'Заемщик в реестре Watch List относится к категории «Проблемные Активы (ПА)»'
	, ws_16_PPA					STRING				COMMENT 'Заемщик в реестре Watch List относится к категории «Потенциально Проблемные Активы (ППА)»'
	, is_correct_guar_rating	STRING				COMMENT 'Корректировка рейтинга на рейтинг поручителя'
	, correct_expert			INT					COMMENT 'Экспертная корректировка'
	, guar_rating_pit			STRING				COMMENT 'Рейтинг поручителя PIT'
	, grp_rating_pit			INT					COMMENT 'Рейтинг группы PIT'
	, rating_with_add_cond		STRING				COMMENT 'Рейтинг с учетом дополнительных факторов риска'
	, score_gs_1				INT					COMMENT 'Скорбалл для фактора Юридическая взаимосвязь'
	, score_gs_2				INT					COMMENT 'Скорбалл для фактора Финансовая взаимосвязь'
	, score_gs_3				INT					COMMENT 'Скорбалл для фактора Товарно-денежная взаимосвязь'
	, score_gs_4				INT					COMMENT 'Скорбалл для фактора Стратегическая взаимосвязь'
	, score_gs_5				INT					COMMENT 'Скорбалл для фактора Репутационная взаимосвязь'
	, score_gs_6				INT					COMMENT 'Скорбалл для фактора Бизнес-интеграция'
	, score_gs_9				INT					COMMENT 'Скорбалл для фактора Кредитная репутация'
	, gov_1						STRING				COMMENT 'Государственная поддержка'
	, pled_of_share				STRING				COMMENT 'Наличие залога контролирующих (50% +) долей в капитале'
	, gr_score					DECIMAL(38,17)		COMMENT 'Групповой скоррбалл'
	, wgr0						DECIMAL(38,17)		COMMENT 'Рассчитанный вес групповой поддержки'
	, wgr						DECIMAL(38,17)		COMMENT 'Вес групповой поддержки'
	, wgr_kik					DECIMAL(38,17)		COMMENT 'Веса групповой поддержки c учетом КиК'
	, uplift					INT					COMMENT 'Групповой фактор поддержки'
/* Технические поля */
	, valid_from_dttm			TIMESTAMP			COMMENT 'Дата и время начала действия технической версии записи'
	, valid_to_dttm				TIMESTAMP			COMMENT 'Дата и время окончания действия технической версии записи'
	, t_source_system_id		SMALLINT			COMMENT 'Идентификатор системы-источника'
    , t_changed_dttm			TIMESTAMP			COMMENT 'Дата и время изменения записи'
    , t_active_flg				TINYINT				COMMENT 'Признак активной записи'
    , t_deleted_flg				TINYINT				COMMENT 'Признак удаления записи'
    , t_author					STRING				COMMENT 'Имя джоба'
    , t_process_task_id			INTEGER				COMMENT 'Идентификатор процесса загрузки'
)
COMMENT 'Витрина 1 - Качественные факторы'
;
DROP VIEW IF EXISTS sbx.rating_calc_indicators
;
CREATE VIEW sbx.rating_calc_indicators
(
      client_asvr_id			COMMENT 'PK | Идентификатор контрагента АС ВР'
    , calculation_asvr_id		COMMENT 'PK | Идентификатор расчета АС ВР'
    , calculation_korpro_guid	COMMENT 'Идентификатор расчета KORPRO'
/* Качественные факторы */
	, ql_1						COMMENT 'Поддержка и контроль со стороны акционеров/участников'
	, ql_2						COMMENT 'Конкуренция и спрос'
	, ql_3						COMMENT 'Источники финансирования'
	, ql_4						COMMENT 'Рыночное позиционирование'
	, ql_5						COMMENT 'Источники погашения'
	, ql_6						COMMENT 'Рыночная конъюнктура'
	, ql_7						COMMENT 'Интенсивность конкуренции'
	, ql_8						COMMENT 'Зависимость от поставщиков/подрядчиков и покупателей/заказчиков'
	, ql_9						COMMENT 'Кредитная история'
	, ql_10						COMMENT 'Деловая этика'
	, ql_11						COMMENT 'Барьеры для доступа в отрасль/Выход на рынки'
/* Групповые факторы */
	, gs_1						COMMENT 'Юридическая взаимосвязь'
	, gs_2						COMMENT 'Финансовая взаимосвязь'
	, gs_3						COMMENT 'Товарно-денежная взаимосвязь'
	, gs_4						COMMENT 'Стратегическая взаимосвязь'
	, gs_5						COMMENT 'Репутационная взаимосвязь'
	, gs_6						COMMENT 'Бизнес-интеграция'
	, gs_9						COMMENT 'Кредитная репутация'
	, ws_10						COMMENT 'Стихийные бедствия/техногенные катастрофы'
	, ws_17						COMMENT 'Непрерывный срок неисполнения платежных обязательств Контрагента перед Банком 30-59 календарных дней'
	, ws_18						COMMENT 'Непрерывный срок неисполнения платежных обязательств Контрагента перед Банком 60-79 календарных дней'
	, ws_19						COMMENT 'Непрерывный срок неисполнения платежных обязательств Контрагента перед Банком 80–89 календарных дней'
	, ws_6						COMMENT 'Отрицательная кредитная история'
	, ws_1						COMMENT 'Проблемы управления / существенные изменения состава руководства'
	, ws_11						COMMENT 'Угроза недружественного поглощения'
	, ws_12						COMMENT 'Представление недостоверных сведений, отчетности'
	, ws_13						COMMENT 'Нестабильная социальная или политическая ситуация'
	, ws_2						COMMENT 'Существенные спады на основных рынках'
	, ws_3						COMMENT 'Существенные судебные разбирательства или налоговые претензии'
	, ws_4						COMMENT 'Существенные проблемы с дебиторской задолженностью'
	, ws_5						COMMENT 'Со стороны Контрагента / Группы имеются запросы на вынужденную (с точки зрения Банка) пролонгацию или рефинансирование платежей'
	, ws_7						COMMENT 'Нарушение дополнительных условий договора'
	, ws_8						COMMENT 'Разрыв или нарушение сроков основного контракта'
	, ws_9						COMMENT 'Конфликт акционеров'
	, ws_14						COMMENT 'Наличие ошибок в финансовой отчетности Контрагента за последние 60 месяцев­ некорректное отображение Процентов к уплате'
	, ws_15						COMMENT 'Наличие ошибок в актуальной финансовой отчетности Контрагента­ некорректное отображение Процентов к уплате'
	, ws_16_PA					COMMENT 'Заемщик в реестре Watch List относится к категории «Проблемные Активы (ПА)»'
	, ws_16_PPA					COMMENT 'Заемщик в реестре Watch List относится к категории «Потенциально Проблемные Активы (ППА)»'
	, is_correct_guar_rating	COMMENT 'Корректировка рейтинга на рейтинг поручителя'
	, correct_expert			COMMENT 'Экспертная корректировка'
	, guar_rating_pit			COMMENT 'Рейтинг поручителя PIT'
	, grp_rating_pit			COMMENT 'Рейтинг группы PIT'
	, rating_with_add_cond		COMMENT 'Рейтинг с учетом дополнительных факторов риска'
	, score_gs_1				COMMENT 'Скорбалл для фактора Юридическая взаимосвязь'
	, score_gs_2				COMMENT 'Скорбалл для фактора Финансовая взаимосвязь'
	, score_gs_3				COMMENT 'Скорбалл для фактора Товарно-денежная взаимосвязь'
	, score_gs_4				COMMENT 'Скорбалл для фактора Стратегическая взаимосвязь'
	, score_gs_5				COMMENT 'Скорбалл для фактора Репутационная взаимосвязь'
	, score_gs_6				COMMENT 'Скорбалл для фактора Бизнес-интеграция'
	, score_gs_9				COMMENT 'Скорбалл для фактора Кредитная репутация'
	, gov_1						COMMENT 'Государственная поддержка'
	, pled_of_share				COMMENT 'Наличие залога контролирующих (50% +) долей в капитале'
	, gr_score					COMMENT 'Групповой скоррбалл'
	, wgr0						COMMENT 'Рассчитанный вес групповой поддержки'
	, wgr						COMMENT 'Вес групповой поддержки'
	, wgr_kik					COMMENT 'Веса групповой поддержки c учетом КиК'
	, uplift					COMMENT 'Групповой фактор поддержки'
/* Технические поля */
	, t_source_system_id		COMMENT 'Идентификатор системы-источника'
    , t_changed_dttm			COMMENT 'Дата и время изменения записи'
    , t_process_task_id			COMMENT 'Идентификатор процесса загрузки'
)
AS SELECT
	  client_asvr_id
    , calculation_asvr_id
    , calculation_korpro_guid
/* Качественные показатели */
    , ql_1
    , ql_2
    , ql_3
    , ql_4
    , ql_5
    , ql_6
    , ql_7
    , ql_8
    , ql_9
	, ql_10
	, ql_11
/* Групповые показатели */
    , gs_1
    , gs_2
    , gs_3
    , gs_4
    , gs_5
    , gs_6
    , gs_9
	, ws_10
	, ws_17
	, ws_18
	, ws_19
	, ws_6
	, ws_1
	, ws_11
	, ws_12
	, ws_13
	, ws_2
	, ws_3
	, ws_4
	, ws_5
	, ws_7
	, ws_8
	, ws_9
	, ws_14
	, ws_15
	, ws_16_PA
	, ws_16_PPA
	, is_correct_guar_rating
	, correct_expert
	, guar_rating_pit
	, grp_rating_pit
	, rating_with_add_cond
    , score_gs_1
    , score_gs_2
    , score_gs_3
    , score_gs_4
    , score_gs_5
    , score_gs_6
    , score_gs_9
    , gov_1
    , pled_of_share
    , gr_score
    , wgr0
    , wgr
    , wgr_kik
    , uplift
/* Технические поля */
	, t_source_system_id
	, t_changed_dttm
	, t_process_task_id
FROM sbx.rating_calc_indicators_tab
WHERE t_deleted_flg = 0
	AND	t_active_flg = 1
;
DROP TABLE IF EXISTS sbx.rating_calc_indicators_full 
;
CREATE TABLE sbx.rating_calc_indicators_full STORED AS PARQUET AS
WITH asvr_rating AS (
	SELECT
		  contractor_id AS client_asvr_id
		, CAST(date_report AS DATE) AS report_date
		, date_saving AS calc_dttm
		, NVL(LEAD(date_saving) OVER (PARTITION BY contractor_id ORDER BY calc_id), '4000-01-01') AS calc_next_dttm
		, calc_id AS calculation_asvr_id
		, val AS rating
	FROM dm_asvr_ultra_gpb_d.v_ext_history_calc_clear
	WHERE is_main = '1'
		AND is_rating = '1'
		AND '2022-01-01' <= date_saving	/* Дата с которой у нас уже есть маппинг */
)
, korpro_rating AS ( 
/* Рейтинги Корпро */
	SELECT
		  CAST(cc.asvr_id AS BIGINT) AS client_asvr_id
		, CAST(r.rating_date AS TIMESTAMP) AS rating_dttm
		, CAST(CAST(r.report_date AS TIMESTAMP) AS DATE) AS report_dt
		, CAST(r.confirmation_date AS TIMESTAMP) AS last_dttm
		, r.rating_ttc_code
		, r.rating_pit_code
		, r.id
		, r.status
	FROM dm_korpro.rating AS r
	JOIN dm_korpro.contractor_link AS cl
		ON	r.id = cl.rating_id
	JOIN dm_korpro.contractor_card AS cc
		ON	r.id = cc.rating_id
		AND cl.asvr_id = cc.asvr_id
	WHERE r.status IN ('APPROVED', 'VERIFY', 'NOT_ACTUAL')
		AND r.confirmation_date IS NOT NULL
)
, rating_agr AS (
	SELECT
		  v.report_date
		, v.calculation_asvr_id
		, v.calc_dttm
		, v.calc_next_dttm
		, kr.id AS rating_rk
		, kr.rating_dttm
		, kr.last_dttm
		, ROW_NUMBER() OVER (PARTITION BY v.calculation_asvr_id ORDER BY kr.rating_dttm) AS asvr_rn
		, kr.status
	FROM asvr_rating AS v
	JOIN korpro_rating AS kr
		ON	v.client_asvr_id = kr.client_asvr_id
		AND v.report_date = kr.report_dt
		AND (v.rating = kr.rating_ttc_code
			OR v.rating = kr.rating_pit_code)
		AND kr.last_dttm BETWEEN v.calc_dttm AND v.calc_next_dttm
)
, new_mapping AS ( 
	SELECT
		  report_date
		, calc_dttm
		, calculation_asvr_id
		, rating_rk
	FROM rating_agr
	WHERE asvr_rn = 1
)
, indicators_asvr AS (
SELECT 
	  client_asvr_id
	, calculation_asvr_id
	, indicator_number
	, factor_value_name
	, factor_value_number
	, ROW_NUMBER() OVER(PARTITION BY client_asvr_id, calculation_asvr_id, indicator_number ORDER BY index_asvr_id) AS actual_rn
FROM sbx.indicators_asvr
)
, sort_prior AS (
SELECT 
	  client_asvr_id
	, calculation_asvr_id
	, NULL AS calculation_korpro_guid
	, indicator_number
	, factor_value_name
	, factor_value_number
	, NULL AS fin_indicator
	, 2 AS prior_num
FROM indicators_asvr
WHERE actual_rn = 1
UNION ALL
SELECT
	  v.asvr_id AS client_asvr_id
	, NVL(m.calculation_id, nm.calculation_asvr_id) AS calculation_asvr_id
	, v.rating_rk AS calculation_korpro_guid
	, CASE
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'поддержка и контроль со стороны акционеров/участников' THEN 'QL_1'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'конкуренция и спрос' THEN  'QL_2'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'источники финансирования' THEN 'QL_3'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'рыночное позиционирование' THEN 'QL_4'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'источники погашения' THEN 'QL_5'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'рыночная конъюнктура' THEN 'QL_6'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'интенсивность конкуренции' THEN 'QL_7'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'зависимость от поставщиков/подрядчиков и покупателей/заказчиков' THEN 'QL_8'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'кредитная история' THEN 'QL_9'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'юридическая взаимосвязь' THEN 'GS_1'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'финансовая взаимосвязь' THEN 'GS_2'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'товарно-денежная взаимосвязь' THEN 'GS_3'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'стратегическая взаимосвязь' THEN 'GS_4'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'репутационная взаимосвязь' THEN 'GS_5'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'бизнес-интеграция' THEN 'GS_6'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'тип рейтинговой связи между контрагентом и группой' THEN 'GS_9'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'юридическая взаимосвязь' THEN 'score_GS_1'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'финансовая взаимосвязь' THEN 'score_GS_2'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'товарно-денежная взаимосвязь' THEN 'score_GS_3'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'стратегическая взаимосвязь' THEN 'score_GS_4'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'репутационная взаимосвязь' THEN 'score_GS_5'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'бизнес-интеграция' THEN 'score_GS_6'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'наличие государственной поддержки' THEN 'gov_1'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'наличие залога контролирующих (50% +) долей в капитале' THEN 'pled_of_share'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'стихийные бедствия/техногенные катастрофы' THEN 'WS_10'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'непрерывный срок неисполнения платежных обязательств контрагента перед банком 30-59 календарных дней' THEN 'WS_17'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'непрерывный срок неисполнения платежных обязательств контрагента перед банком 60-79 календарных дней' THEN 'WS_18'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'непрерывный срок неисполнения платежных обязательств контрагента перед банком 80–89 календарных дней' THEN 'WS_19'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'отрицательная кредитная история' THEN 'WS_6'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'проблемы управления / существенные изменения состава руководства' THEN 'WS_1'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'угроза недружественного поглощения' THEN 'WS_11'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'представление недостоверных сведений, отчетности' THEN 'WS_12'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'нестабильная социальная или политическая ситуация' THEN 'WS_13'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'существенные спады на основных рынках' THEN 'WS_2'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'существенные судебные разбирательства или налоговые претензии' THEN 'WS_3'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'существенные проблемы с дебиторской задолженностью' THEN 'WS_4'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'нарушение дополнительных условий договора' THEN 'WS_7'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'разрыв или нарушение сроков основного контракта' THEN 'WS_8'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'конфликт акционеров' THEN 'WS_9'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'наличие ошибок в финансовой отчетности контрагента за последние 60 месяцев - некорректное отображение процентов к уплате' THEN 'WS_14'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'наличие ошибок в актуальной финансовой отчетности контрагента - некорректное отображение процентов к уплате' THEN 'WS_15'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'контрагент в системе срп относится к категориям проблемные активы (па) или потенциально проблемные активы (ппа)' THEN 'WS_16_PA'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'со стороны контрагента имеются запросы на вынужденную (с точки зрения банка) пролонгацию или рефинансирование платежей, при этом контрагент в системе срп относится к категориям проблемные активы (па), потенциально проблемные активы (ппа) или рабочий – выход из клиента' THEN 'WS_5'
		WHEN syslib.utf8_lower(v.attr_ru_nm) = 'со стороны контрагента / группы имеются запросы на пролонгацию или рефинансирование платежей, имеющие признаки вынужденных' THEN 'WS_5'	
		ELSE v.attr_cd
	  END AS indicator_number
	, v.attr_desc AS factor_value_name
	, CASE
		WHEN v.attr_desc = 'Безусловная' THEN 5
		WHEN v.attr_desc = 'Высокая' THEN 4
		WHEN v.attr_desc = 'Средняя' THEN 3
		WHEN v.attr_desc = 'Низкая' THEN 1
		WHEN v.attr_desc = 'Отсутствует или не может быть оценена' THEN 0
	  END AS factor_value_number
	, v.attr_val AS fin_indicator
	, 1 AS prior_num
FROM dm_corp_models.korpro_vector_main AS v
LEFT JOIN dm_corp_models.EXT_CALC_MAPPING_ASVR AS m
	ON	v.rating_rk = m.external_rating_id
LEFT JOIN new_mapping AS nm
	ON	v.rating_rk = nm.rating_rk
WHERE 1=1
	AND (m.calculation_id IS NOT NULL OR nm.calculation_asvr_id IS NOT NULL)
	AND syslib.utf8_lower(v.attr_ru_nm) IN (
		  'поддержка и контроль со стороны акционеров/участников'
		, 'конкуренция и спрос'
		, 'источники финансирования'
		, 'рыночное позиционирование'
		, 'источники погашения'
		, 'рыночная конъюнктура'
		, 'интенсивность конкуренции'
		, 'зависимость от поставщиков/подрядчиков и покупателей/заказчиков'
		, 'кредитная история'
		, 'юридическая взаимосвязь'
		, 'наличие залога контролирующих (50% +) долей в капитале'
		, 'финансовая взаимосвязь'
		, 'товарно-денежная взаимосвязь'
		, 'стратегическая взаимосвязь'
		, 'репутационная взаимосвязь'
		, 'бизнес-интеграция'
		, 'тип рейтинговой связи между контрагентом и группой'
		, 'юридическая взаимосвязь'
		, 'финансовая взаимосвязь'
		, 'товарно-денежная взаимосвязь'
		, 'стратегическая взаимосвязь'
		, 'репутационная взаимосвязь'
		, 'бизнес-интеграция'
		, 'наличие государственной поддержки'
		/* WS */
		, 'стихийные бедствия/техногенные катастрофы'
		, 'непрерывный срок неисполнения платежных обязательств контрагента перед банком 30-59 календарных дней'
		, 'непрерывный срок неисполнения платежных обязательств контрагента перед банком 60-79 календарных дней'
		, 'непрерывный срок неисполнения платежных обязательств контрагента перед банком 80–89 календарных дней'
		, 'отрицательная кредитная история'
		, 'проблемы управления / существенные изменения состава руководства'
		, 'угроза недружественного поглощения'
		, 'представление недостоверных сведений, отчетности'
		, 'нестабильная социальная или политическая ситуация'
		, 'существенные спады на основных рынках'
		, 'существенные судебные разбирательства или налоговые претензии'
		, 'существенные проблемы с дебиторской задолженностью'
		, 'нарушение дополнительных условий договора'
		, 'разрыв или нарушение сроков основного контракта'
		, 'конфликт акционеров'
		, 'наличие ошибок в финансовой отчетности контрагента за последние 60 месяцев - некорректное отображение процентов к уплате'
		, 'наличие ошибок в актуальной финансовой отчетности контрагента - некорректное отображение процентов к уплате'
		, 'контрагент в системе срп относится к категориям проблемные активы (па) или потенциально проблемные активы (ппа)'
		, 'со стороны контрагента имеются запросы на вынужденную (с точки зрения банка) пролонгацию или рефинансирование платежей, при этом контрагент в системе срп относится к категориям проблемные активы (па), потенциально проблемные активы (ппа) или рабочий – выход из клиента'
		, 'со стороны контрагента / группы имеются запросы на пролонгацию или рефинансирование платежей, имеющие признаки вынужденных'
	)
)
SELECT 
	  client_asvr_id
	, calculation_asvr_id
	, calculation_korpro_guid
	, indicator_number
	, factor_value_name
	, factor_value_number
	, DENSE_RANK() OVER(PARTITION BY client_asvr_id, calculation_asvr_id ORDER BY prior_num) AS rn
FROM sort_prior
;
DROP TABLE IF EXISTS sbx.rating_calc_indicators_tr 
;
CREATE TABLE IF NOT EXISTS sbx.rating_calc_indicators_tr STORED AS PARQUET AS
SELECT
	  ei.client_asvr_id
	, ei.calculation_asvr_id
	, ei.calculation_korpro_guid
	, MAX(IF(ei.indicator_number = 'QL_1', ei.factor_value_name, NULL)) 						AS QL_1
	, MAX(IF(ei.indicator_number = 'QL_2', ei.factor_value_name, NULL)) 						AS QL_2
	, MAX(IF(ei.indicator_number = 'QL_3', ei.factor_value_name, NULL)) 						AS QL_3
	, MAX(IF(ei.indicator_number = 'QL_4', ei.factor_value_name, NULL)) 						AS QL_4
	, MAX(IF(ei.indicator_number = 'QL_5', ei.factor_value_name, NULL)) 						AS QL_5
	, MAX(IF(ei.indicator_number = 'QL_6', ei.factor_value_name, NULL)) 						AS QL_6
	, MAX(IF(ei.indicator_number = 'QL_7', ei.factor_value_name, NULL)) 						AS QL_7
	, MAX(IF(ei.indicator_number = 'QL_8', ei.factor_value_name, NULL)) 						AS QL_8
	, MAX(IF(ei.indicator_number = 'QL_9', ei.factor_value_name, NULL)) 						AS QL_9
	, MAX(IF(ei.indicator_number = 'QL_10', ei.factor_value_name, NULL)) 						AS QL_10
	, MAX(IF(ei.indicator_number = 'QL_11', ei.factor_value_name, NULL))						AS QL_11
	, MAX(IF(ei.indicator_number = 'GS_1', ei.factor_value_name, NULL)) 						AS GS_1
	, MAX(IF(ei.indicator_number = 'GS_2', ei.factor_value_name, NULL)) 						AS GS_2
	, MAX(IF(ei.indicator_number = 'GS_3', ei.factor_value_name, NULL)) 						AS GS_3
	, MAX(IF(ei.indicator_number = 'GS_4', ei.factor_value_name, NULL)) 						AS GS_4
	, MAX(IF(ei.indicator_number = 'GS_5', ei.factor_value_name, NULL)) 						AS GS_5
	, MAX(IF(ei.indicator_number = 'GS_6', ei.factor_value_name, NULL)) 						AS GS_6
	, MAX(IF(ei.indicator_number = 'GS_9', ei.factor_value_name, NULL)) 						AS GS_9
	, MAX(IF(ei.indicator_number = 'GS_10', ei.factor_value_name, NULL)) 						AS is_correct_guar_rating
	, MAX(IF(ei.indicator_number = 'GS_11', ei.factor_value_name, NULL)) 						AS correct_expert
	, MAX(IF(ei.indicator_number = 'GS_12', ei.factor_value_name, NULL)) 						AS guar_rating_pit
	, MAX(IF(ei.indicator_number = 'GS_13', ei.factor_value_name, NULL)) 						AS grp_rating_pit
	, MAX(IF(ei.indicator_number = 'GS_14', ei.factor_value_name, NULL)) 						AS rating_with_add_cond
	, MAX(IF(ei.indicator_number = 'GS_1', ei.factor_value_number, 0))							AS score_GS_1
	, MAX(IF(ei.indicator_number = 'GS_2', ei.factor_value_number, 0))							AS score_GS_2
	, MAX(IF(ei.indicator_number = 'GS_3', ei.factor_value_number, 0))							AS score_GS_3
	, MAX(IF(ei.indicator_number = 'GS_4', ei.factor_value_number, 0))  						AS score_GS_4
	, MAX(IF(ei.indicator_number = 'GS_5', ei.factor_value_number, 0))  						AS score_GS_5
	, MAX(IF(ei.indicator_number = 'GS_6', ei.factor_value_number, 0))  						AS score_GS_6
	, MAX(IF(ei.indicator_number = 'GS_9', ei.factor_value_number, 0))  						AS score_GS_9
	, MAX(IF(ei.indicator_number = 'GOV_1', ei.factor_value_name, NULL)) 						AS GOV_1
	, MAX(IF(ei.indicator_number = 'pled_of_share', ei.factor_value_name, NULL)) 				AS pled_of_share
	, MAX(IF(ei.indicator_number = 'WS_1', ei.factor_value_name, NULL)) 						AS WS_1
	, MAX(IF(ei.indicator_number = 'WS_10', ei.factor_value_name, NULL)) 						AS WS_10
	, MAX(IF(ei.indicator_number = 'WS_11', ei.factor_value_name, NULL)) 						AS WS_11
	, MAX(IF(ei.indicator_number = 'WS_12', ei.factor_value_name, NULL)) 						AS WS_12
	, MAX(IF(ei.indicator_number = 'WS_13', ei.factor_value_name, NULL)) 						AS WS_13
	, MAX(IF(ei.indicator_number = 'WS_14', ei.factor_value_name, NULL)) 						AS WS_14
	, MAX(IF(ei.indicator_number = 'WS_15', ei.factor_value_name, NULL)) 						AS WS_15
	, MAX(IF(ei.indicator_number = 'WS_16_PA', ei.factor_value_name, NULL)) 					AS WS_16_PA
	, MAX(IF(ei.indicator_number = 'WS_16_PPA', ei.factor_value_name, NULL)) 					AS WS_16_PPA
	, MAX(IF(ei.indicator_number = 'WS_17', ei.factor_value_name, NULL)) 						AS WS_17
	, MAX(IF(ei.indicator_number = 'WS_18', ei.factor_value_name, NULL)) 						AS WS_18
	, MAX(IF(ei.indicator_number = 'WS_19', ei.factor_value_name, NULL)) 						AS WS_19
	, MAX(IF(ei.indicator_number = 'WS_2', ei.factor_value_name, NULL)) 						AS WS_2
	, MAX(IF(ei.indicator_number = 'WS_3', ei.factor_value_name, NULL)) 						AS WS_3
	, MAX(IF(ei.indicator_number = 'WS_4', ei.factor_value_name, NULL)) 						AS WS_4
	, MAX(IF(ei.indicator_number = 'WS_5', ei.factor_value_name, NULL)) 						AS WS_5
	, MAX(IF(ei.indicator_number = 'WS_6', ei.factor_value_name, NULL)) 						AS WS_6
	, MAX(IF(ei.indicator_number = 'WS_7', ei.factor_value_name, NULL)) 						AS WS_7
	, MAX(IF(ei.indicator_number = 'WS_8', ei.factor_value_name, NULL)) 						AS WS_8
	, MAX(IF(ei.indicator_number = 'WS_9', ei.factor_value_name, NULL)) 						AS WS_9
FROM sbx.rating_calc_indicators_full AS ei
WHERE ei.rn = 1
GROUP BY ei.client_asvr_id, ei.calculation_asvr_id, ei.calculation_korpro_guid
;
INSERT INTO sbx.rating_calc_indicators_tab
(
	  client_asvr_id
    , calculation_asvr_id
    , calculation_korpro_guid
    , ql_1
    , ql_2
    , ql_3
    , ql_4
    , ql_5
    , ql_6
    , ql_7
    , ql_8
    , ql_9
	, ql_10
    , ql_11
    , gs_1
    , gs_2
    , gs_3
    , gs_4
    , gs_5
    , gs_6
    , gs_9
    , ws_10
	, ws_17
	, ws_18
	, ws_19
	, ws_6
	, ws_1
	, ws_11
	, ws_12
	, ws_13
	, ws_2
	, ws_3
	, ws_4
	, ws_5
	, ws_7
	, ws_8
	, ws_9
	, ws_14
	, ws_15
	, ws_16_PA
	, ws_16_PPA
	, is_correct_guar_rating
	, correct_expert
	, guar_rating_pit
	, grp_rating_pit
	, rating_with_add_cond
    , score_gs_1
    , score_gs_2
    , score_gs_3
    , score_gs_4
    , score_gs_5
    , score_gs_6
    , score_gs_9
    , gov_1
    , pled_of_share
    , gr_score
    , wgr0
    , wgr
    , wgr_kik
    , uplift
	, valid_from_dttm
	, valid_to_dttm
	, t_source_system_id
	, t_changed_dttm
	, t_deleted_flg
	, t_active_flg
	, t_author
	, t_process_task_id	
)
WITH wgr0 AS (
	SELECT
		  client_asvr_id
	    , calculation_asvr_id
	    , calculation_korpro_guid
	    , ql_1
	    , ql_2
	    , ql_3
	    , ql_4
	    , ql_5
	    , ql_6
	    , ql_7
	    , ql_8
	    , ql_9
		, ql_10
    	, ql_11
	    , gs_1
	    , gs_2
	    , gs_3
	    , gs_4
	    , gs_5
	    , gs_6
	    , gs_9
	    , ws_10
		, ws_17
		, ws_18
		, ws_19
		, ws_6
		, ws_1
		, ws_11
		, ws_12
		, ws_13
		, ws_2
		, ws_3
		, ws_4
		, ws_5
		, ws_7
		, ws_8
		, ws_9
		, ws_14
		, ws_15
		, ws_16_PA
		, ws_16_PPA
		, is_correct_guar_rating
		, correct_expert
		, guar_rating_pit
		, grp_rating_pit
		, rating_with_add_cond
	    , score_gs_1
	    , score_gs_2
	    , score_gs_3
	    , score_gs_4
	    , score_gs_5
	    , score_gs_6
	    , score_gs_9
	    , gov_1
	    , pled_of_share
		, 0.05*NVL(score_gs_1,0)+0.2*NVL(score_gs_2,0)+0*NVL(score_gs_3,0)+0.05*NVL(score_gs_4,0)+0.4*NVL(score_gs_5,0)+0.3*NVL(score_gs_6,0) AS gr_score
	    , (0.05*NVL(score_gs_1,0)+0.2*NVL(score_gs_2,0)+0*NVL(score_gs_3,0)+0.05*NVL(score_gs_4,0)+0.4*NVL(score_gs_5,0)+0.3*NVL(score_gs_6,0))/5 AS wgr0
	FROM sbx.rating_calc_indicators_tr
)
, wgr AS (
	SELECT
		  client_asvr_id
	    , calculation_asvr_id
	    , calculation_korpro_guid
	    , ql_1
	    , ql_2
	    , ql_3
	    , ql_4
	    , ql_5
	    , ql_6
	    , ql_7
	    , ql_8
	    , ql_9
		, ql_10
    	, ql_11
	    , gs_1
	    , gs_2
	    , gs_3
	    , gs_4
	    , gs_5
	    , gs_6
	    , gs_9
	    , ws_10
		, ws_17
		, ws_18
		, ws_19
		, ws_6
		, ws_1
		, ws_11
		, ws_12
		, ws_13
		, ws_2
		, ws_3
		, ws_4
		, ws_5
		, ws_7
		, ws_8
		, ws_9
		, ws_14
		, ws_15
		, ws_16_PA
		, ws_16_PPA
		, is_correct_guar_rating
		, correct_expert
		, guar_rating_pit
		, grp_rating_pit
		, rating_with_add_cond
	    , score_gs_1
	    , score_gs_2
	    , score_gs_3
	    , score_gs_4
	    , score_gs_5
	    , score_gs_6
	    , score_gs_9
	    , gov_1
	    , pled_of_share
		, CAST(gr_score AS DECIMAL(38,17)) AS gr_score
	    , CAST(wgr0 AS DECIMAL(38,17)) AS wgr0
	    , CASE
			WHEN gs_1 IS NULL
				THEN NULL
			WHEN gs_2 = 'Безусловная' 
				THEN 1
			ELSE 0
		  END AS wgr
	    , CASE
			WHEN gs_1 IS NULL
				THEN NULL
			WHEN (gs_2 = 'Безусловная'
				OR (gs_1 IN ('Безусловная', 'Высокая', 'Средняя') 
					AND gs_4 IN ('Безусловная', 'Высокая','Средняя') 
					AND gs_6 IN ('Безусловная', 'Высокая'))
				OR (gs_5 IN ('Безусловная') 
					AND gs_1 IN ('Безусловная', 'Высокая'))) 
			    THEN 1
			ELSE wgr0
		  END AS wgr_kik
		, CASE
			WHEN (gs_2 IN ('Безусловная')
				OR (gs_1 IN ('Безусловная','Высокая')
					AND gs_5 IN ('Безусловная'))
				OR (gs_1 IN ('Безусловная','Высокая','Средняя')
					AND gs_4 IN ('Безусловная','Высокая','Средняя') 
					AND gs_5 IN ('Безусловная','Высокая','Средняя')
					AND gs_6 IN ('Безусловная','Высокая')))
				THEN 1
			WHEN (gs_2 NOT IN ('Безусловная')
				AND (gs_1 NOT IN ('Безусловная','Высокая')
					OR gs_5 NOT IN ('Безусловная'))
				AND (gs_1 NOT IN ('Безусловная','Высокая','Средняя')
					OR gs_4 NOT IN ('Безусловная','Высокая','Средняя')
					OR gs_5 NOT IN ('Безусловная','Высокая','Средняя') 
					OR gs_6 NOT IN ('Безусловная','Высокая')))
				THEN 0
		  END AS uplift
	FROM wgr0
)
SELECT 
	  client_asvr_id
    , calculation_asvr_id
    , calculation_korpro_guid
/* Качественные показатели */
    , ql_1
    , ql_2
    , ql_3
    , ql_4
    , ql_5
    , ql_6
    , ql_7
    , ql_8
    , ql_9
	, ql_10
    , ql_11
/* Групповые показатели */
    , gs_1
    , gs_2
    , gs_3
    , gs_4
    , gs_5
    , gs_6
    , gs_9
    , ws_10
	, ws_17
	, ws_18
	, ws_19
	, ws_6
	, ws_1
	, ws_11
	, ws_12
	, ws_13
	, ws_2
	, ws_3
	, ws_4
	, ws_5
	, ws_7
	, ws_8
	, ws_9
	, ws_14
	, ws_15
	, ws_16_PA
	, ws_16_PPA
	, is_correct_guar_rating
	, CAST(correct_expert AS INT) AS correct_expert
	, guar_rating_pit
	, CAST(grp_rating_pit AS INT) AS  grp_rating_pit
	, rating_with_add_cond
    , score_gs_1
    , score_gs_2
    , score_gs_3
    , score_gs_4
    , score_gs_5
    , score_gs_6
    , score_gs_9
    , gov_1
    , pled_of_share
    , gr_score
    , wgr0
    , wgr
    , CAST(wgr_kik AS DECIMAL(38,17)) AS wgr_kik
    , uplift
	, CAST(now() AS TIMESTAMP)					AS valid_from_dttm
	, CAST('2100-01-01 00:00:00' AS TIMESTAMP)	AS valid_to_dttm
	, CAST(318 AS SMALLINT)						AS t_source_system_id
	, CAST(now() AS TIMESTAMP) 	AS T_CHANGED_DTTM
	, CAST(0 AS TINYINT)		AS T_DELETED_FLG
	, CAST(1 AS TINYINT)		AS T_ACTIVE_FLG
	, CAST(NULL AS STRING) 		AS T_AUTHOR
	, CAST(NULL AS INTEGER)		AS T_PROCESS_TASK_ID
FROM wgr
;
/* Технические проверки прототипа */
/* Дубли по PK */
SELECT client_asvr_id, calculation_asvr_id, COUNT(*)
FROM sbx.rating_calc_indicators_tab
GROUP BY client_asvr_id, calculation_asvr_id
HAVING COUNT(*) > 1
LIMIT 100
;
/* NULL в PK */
SELECT *
FROM sbx.rating_calc_indicators_tab
WHERE client_asvr_id IS NULL 
	OR calculation_asvr_id IS NULL
LIMIT 100



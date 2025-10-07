use dm_cardiologia;

#FIRST GENERAL QUERIES


#Number of patients and admissions
SELECT 
    COUNT(DISTINCT id_paciente) AS total_patients,
    COUNT(DISTINCT id_admision) AS total_admissions
FROM admisiones;



#Gender distribution
SELECT 
    genero,
   COUNT(*) AS total_pacientes
FROM pacientes
GROUP BY genero;

#Average age of patients
SELECT 
    AVG(edad) AS edad_promedio
FROM pacientes;

#Average length of hospital stay

SELECT 
    AVG(duracion_estancia) AS duracion_promedio_estancia
FROM admisiones;


#Distribution of admission types
SELECT 
    tipo_admision,
    COUNT(*) AS total_admisiones
FROM admisiones
GROUP BY tipo_admision;

#Mortality rate
SELECT 
    fallecidos.total_fallecidos,
    pacientes.total_pacientes,
    (fallecidos.total_fallecidos * 100.0 / pacientes.total_pacientes) AS porcentaje_mortalidad
FROM 
    (SELECT COUNT(*) AS total_fallecidos
     FROM admisiones
     WHERE resultado = 'Defuncion') AS fallecidos,
    (SELECT COUNT(DISTINCT id_paciente) AS total_pacientes
     FROM admisiones) AS pacientes;
     

#READMISSION QUERIES


# How many admissions are there on average per month? |e.subqueries

SELECT 
    AVG(total_admisiones) AS avg_total_admissions
FROM (
    SELECT 
        MONTH(fecha_admision) AS mes,
        COUNT(*) AS total_admissions
    FROM admisiones
    GROUP BY mes
) AS admisiones_por_mes;




# And how many unique patients on average per month? e.subqueries
SELECT 
    AVG(total_pacientes) AS media_total_pacientes
FROM (
    SELECT 
        MONTH(fecha_admision) AS mes,
        COUNT(DISTINCT id_paciente) AS total_pacientes
    FROM admisiones
    GROUP BY mes
) AS pacientes_por_mes;




# What percentage of patients have more than one admission? m.subqueries

SELECT 
    (SUM(CASE WHEN total_reingresos > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(DISTINCT id_paciente)) AS pct_readmissions
FROM (
    SELECT id_paciente, COUNT(*) AS total_readmissions
    FROM admisiones
    GROUP BY id_paciente
) AS patients;



# What is the average time between one admission and the next readmission? a.subqueries | window functions
SELECT 
    AVG(dias_reingreso) AS tiempo_promedio_global_reingreso
FROM (
    SELECT 
        id_paciente,
        DATEDIFF(LEAD(fecha_admission) OVER (PARTITION BY id_paciente ORDER BY fecha_admision), fecha_admision) AS dias_reingreso
    FROM admisiones
) AS diffrences
WHERE dias_reingreso IS NOT NULL;




# How many times do patients get admitted? (how many patients once, twice, etc.) | m.subqueries

SELECT 
    total_readmissions,
    COUNT(*) AS num_patients
FROM (
    SELECT 
        id_paciente,
        COUNT(*) AS total_readmissions
    FROM admisiones
    GROUP BY id_paciente
) AS ingresos_por_paciente
GROUP BY total_readmissions
ORDER BY total_readmissions;


# What is the average number of admissions for all patients? | a.CTEs
WITH admissions_per_patient AS (
    SELECT 
        id_paciente,
        COUNT(*) AS total_admissions
    FROM admisiones
    GROUP BY id_paciente
),
distribution_admissions AS (
    SELECT 
        total_admissions,
        COUNT(*) AS num_patients
    FROM admissions_per_patient
    GROUP BY total_admissions
)
SELECT 
    SUM(total_admissions * num_patients) * 1.0 / SUM(num_patients) AS weighted_avg
FROM distribution_admissions;


# What is the average number of readmissions for patients who have been readmitted? m.subqueries
SELECT 
    AVG(total_readmissions) AS avg_readmissions
FROM (
    SELECT 
        id_paciente,
        COUNT(*) - 1 AS total_readmissions
    FROM admisiones
    GROUP BY id_paciente
    HAVING COUNT(*) > 1
) AS readmissions_per_patient;





# How many hospitalization days did readmissions account for in the last full year we have? | m.subqueries
SELECT 
    SUM(duracion_estancia) AS total_days_readmissions
FROM admisiones
WHERE id_paciente IN (
    SELECT id_paciente 
    FROM admisiones 
    GROUP BY id_paciente 
    HAVING COUNT(*) > 1
)
AND YEAR(fecha_admision) = 2023;


# What is the average length of stay for patients who are readmitted vs. those who are not? | a.CTEs
WITH tipo_ingreso AS (
    SELECT 
        id_paciente,
        duracion_estancia,
        CASE 
            WHEN id_paciente IN (
                SELECT id_paciente 
                FROM admisiones 
                GROUP BY id_paciente 
                HAVING COUNT(*) > 1
            ) THEN 'reingreso'
            ELSE 'no_reingreso'
        END AS tipo_ingreso
    FROM admisiones
)
SELECT 
    tipo_ingreso,
    AVG(duracion_estancia) AS duracion_promedio_estancia
FROM tipo_ingreso
GROUP BY tipo_ingreso;

# What percentage of readmitted patients end up dying? | pro.CTEs
WITH pacientes_con_reingreso AS (
    SELECT id_paciente
    FROM admisiones
    GROUP BY id_paciente
    HAVING COUNT(*) > 1
),
total_pacientes_con_reingreso AS (
    SELECT COUNT(*) AS total_pacientes_reingreso
    FROM pacientes_con_reingreso
),
fallecidos_con_reingreso AS (
    SELECT COUNT(*) AS total_fallecidos_reingresos
    FROM admisiones
    WHERE resultado = 'Defuncion'
      AND id_paciente IN (SELECT id_paciente FROM pacientes_con_reingreso)
)
SELECT 
    (fcr.total_fallecidos_reingresos * 100.0 / tpcr.total_pacientes_reingreso) AS porcentaje_fallecidos_reingresos
FROM fallecidos_con_reingreso fcr, total_pacientes_con_reingreso tpcr;


# What is the average age of patients who die? | e.joins
SELECT 
    AVG(p.edad) AS edad_promedio_fallecidos
FROM pacientes p
JOIN admisiones a ON p.id_admision = a.id_admision
WHERE a.resultado = 'Defuncion';

# Do the same proportion of men and women die? | m.joins
select 
	p.genero,
    sum(case when a.resultado = 'Defuncion' then 1 else 0 end) * 100.0 / count(*) as porcentaje_fallecidos
from pacientes p join admisiones a on p.id_admision = a.id_admision
group by p.genero;

# What percentage of discharges result in a readmission within 30 days after discharge? pro.CTEsjoins
	with altas as(
select
			id_paciente,
			id_admision,
			fecha_alta,
			resultado
		from admisiones
		where resultado != 'Defuncion'),
    total_altas as (
		select count(*) as total_altas
		from altas),
    reingresos_en_30_dias as (
		select
			a1.id_paciente,
            a1.id_admision as alta_id_admision,
            a2.id_admision as reingreso_id_admsion,
            a1.fecha_alta,
            a2.fecha_admision
        from altas a1 join admisiones a2 on a1.id_paciente = a2.id_paciente
			and a2.fecha_admision > a1.fecha_alta
            and datediff(a2.fecha_admision, a1.fecha_alta) <= 30),
	total_reingresos_en_30_dias as (
		select count(alta_id_admision) as total_reingresos_en_30_dias
        from reingresos_en_30_dias)
select
	round((num.total_reingresos_en_30_dias * 100.0 / denom.total_altas),2) as porc_reingresos_30_dias
from total_reingresos_en_30_dias num, total_altas denom;
     

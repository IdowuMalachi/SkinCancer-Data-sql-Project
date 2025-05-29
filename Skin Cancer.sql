-- Join patient and lesion info into a single result set for analysis
SELECT
    p.patient_id, p.age, p.gender, p.smoke,
    p.drink, p.pesticide, p.skin_cancer_history,
    p.cancer_history, p.has_piped_water, p.has_sewage_system,
    P.background_father, p.background_mother, 
	l.lesion_id, l.patient_id, 
	l.fitspatrick, l.region,
    l.diameter_1, l.diameter_2, l.diagnostic,
    l.itch, l.grew, l.hurt, l.changed,
    l.bleed,l.elevation,l.img_id, l.biopsed
FROM TABLE1 p
JOIN TABLE2 l ON p.patient_id = l.patient_id;

-- Distribution of skin lesion types
SELECT diagnostic, 
COUNT(*) AS total_cases
FROM TABLE2
GROUP BY diagnostic
ORDER BY total_cases DESC;


--Count of Biopsy-Confirmed Lesions
SELECT 
COUNT(*) AS biopsied_lesions
FROM TABLE2
WHERE biopsed = TRUE;


--Common Symptoms in Biopsied Lesion
SELECT 
    COUNT(*) FILTER (WHERE itch = TRUE) AS itchy,
    COUNT(*) FILTER (WHERE grew = TRUE) AS grew,
    COUNT(*) FILTER (WHERE hurt = TRUE) AS hurt,
    COUNT(*) FILTER (WHERE changed = TRUE) AS changed,
    COUNT(*) FILTER (WHERE bleed = TRUE) AS bleed,
    COUNT(*) FILTER (WHERE elevation = TRUE) AS elevated
FROM TABLE2
WHERE biopsed = TRUE;


--Demographic Risk Pattern
SELECT 
    p.gender, p.smoke, p.pesticide,
    p.background_father, p.background_mother,
    COUNT(*) AS total_biopsied
FROM TABLE1 p
JOIN TABLE2 l ON p.patient_id = l.patient_id
WHERE l.biopsed = TRUE
GROUP BY p.gender, p.smoke, p.pesticide, p.background_father, p.background_mother
ORDER BY total_biopsied DESC;


--Most affected body regions
SELECT region, 
COUNT(*) AS region_count
FROM TABLE2
GROUP BY region
ORDER BY region_count DESC;


--Avg lesion size by diagnostic category
SELECT 
    diagnostic,
    ROUND(CAST(AVG((diameter_1 + diameter_2) / 2.0) AS NUMERIC), 2) AS avg_size_mm
FROM TABLE2
GROUP BY diagnostic
ORDER BY avg_size_mm DESC;


---Updated Machine learning VIEW
CREATE VIEW skin_cancer_ml_dataset AS
SELECT
    p.patient_id, p.age, p.gender,
    p.smoke, p.drink, p.pesticide,
    p.skin_cancer_history, p.cancer_history,
    p.has_piped_water, p.has_sewage_system,
    p.background_father, p.background_mother,
    l.lesion_id,l.patient_id,l.fitspatrick,
    l.region,(l.diameter_1 + l.diameter_2) / 2.0 AS avg_diameter,
    l.diagnostic, l.itch, l.grew, l.hurt,
    l.changed, l.bleed,  l.elevation, l.biopsed
FROM TABLE1 p
JOIN TABLE2 l ON p.patient_id = l.patient_id;






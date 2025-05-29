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


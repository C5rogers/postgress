






-- select * from basic.cities where name ilike '%addis%';

-- school name,
-- join with partner and select name



-- select full_name, phone_number, parent_name, parent_phone_number, name  from participants t1 join partners t2 on t1.partner_id = t2.id;

-- select count(id) from participants;

-- select 
-- 	p.id,
-- 	p.full_name,
--   p.gender,
--   p.age,
--  	wt.name as woreda_town_name,
--   a.name as area_name,
--   p.house_number,
--   p.phone_number,
--   p.date_of_birth,
--   pa.name as partner_name,
--   p.parent_name,
--   p.parent_phone_number,
--   el.name as education_level,
--   scz.name as sub_city_zone_name
--  from participants p
--  left join basic.woreda_towns wt on p.woreda_town_id=wt.id
--  left join basic.areas a on p.area_id=a.id
--  left join partners pa on p.partner_id=pa.id
--  left join basic.education_levels el on p.education_level_id=el.id
--  left join basic.subcity_zones scz on p.sub_city_zone_id=scz.id;
--  where not exists (select 1 from intervention_participants ip where ip.participant_id=p.id);

 
--  delete from participants p where not exists ( select 1 from intervention_participants ip where ip.participant_id = p.id);

-- select * from participant_supports;


-- select count(id) from participants WHERE created_at >= CURRENT_DATE
--   AND created_at < CURRENT_DATE + INTERVAL '1 day';

-- WITH last_friday AS (
--   SELECT 
--     CURRENT_DATE - INTERVAL '1 day' * ((EXTRACT(DOW FROM CURRENT_DATE)::int + 2) % 7) AS day
-- )
-- SELECT COUNT(id)
-- FROM participants
-- WHERE created_at >= (SELECT day FROM last_friday)
--   AND created_at < (SELECT day FROM last_friday) + INTERVAL '1 day';

-- select * from support;

-- 93c22965-2947-4b79-80b3-7be8dd875f57

-- select * from intervention_participants where intervention_id !='3c2c5caa-da3e-43a8-932e-ffc0bb967044'
-- select * from participant_supports


-- WITH last_friday AS (
--   SELECT CURRENT_DATE - INTERVAL '1 day' * ((EXTRACT(DOW FROM CURRENT_DATE)::int + 2) % 7) AS day
-- )

-- INSERT INTO participant_supports (
--   date,
--   created_by,
--   "support_Id",
--   intervention_participant_id
-- )
-- SELECT 
--   '2025-04-05'::date,                                
--   'f0901ba8-cddf-4b37-9560-52f3e58e4640',      
--   '93c22965-2947-4b79-80b3-7be8dd875f57',      
--   ip.id                                       
-- FROM intervention_participants ip 
-- WHERE ip.created_at < (SELECT day FROM last_friday)
--     OR ip.created_at >= (SELECT day FROM last_friday) + INTERVAL '1 day';

-- select * from participant_supports



-- select * from account.users;
-- insert into account.users (full_name, phone_number ,is_active, email, password) values 
-- 	('Neftalem Binyam', '0913913569' , true,'neftalem.binyam@hahu.jobs','$2y$10$q.DzSlmkhHCxWWzxErreKuUvRP4DeXd4PKvK47PmdoLOFRMPkEHy6');

-- select * from account.users;


-- update account.users set password = '$2y$10$0Fn0nkJxAyjSe58j5pwAGODNzv9zFDFMvzLdwQeWm2VRM77nWP./G' where id = 'ea638590-7eae-45f4-83e3-d0d6fb02feae';


-- insert into account.user_roles (user_id, role) values ('adcb6154-b9ea-411a-9338-592baedcac01','management');

-- select * from account.user_roles;

-- select * from account.user_roles where user_id = '7452533a-eb7a-43f1-843d-e5f397755174';

-- select u.full_name, r.role from account.users u left join account.user_roles r on u.id= r.user_id;


-- select * from partners;

-- kokebe : eca2c5b6-f90d-454f-8ad4-e83bd1f74bf6


-- menilik : 2d2de33c-3b2c-402b-a623-c21f6e3c2bee


-- tesfa birhan : 6bef486a-3536-41c3-98cc-ff2108811f42

-- wondrad : 0fa648fd-c3e9-42a2-9f0d-514e50f98190

-- select * from account.users;

-- SELECT
--   ps.intervention_participant_id,
--   p1.partner_id AS participant_partner_id,
--   p2.partner_id AS inner_participant_partner_id
-- FROM
--   public.participant_supports ps
-- JOIN
--   intervention_participants p1 ON ps.intervention_participant_id = p1.id
-- LEFT JOIN
--   participants p2 ON p1.participant_id = p2.id
-- WHERE
--   ps.intervention_participant_id IS NOT NULL;

-- UPDATE intervention_participants ip
-- SET partner_id = p.partner_id
-- FROM participants p
-- WHERE ip.participant_id = p.id
--   AND ip.partner_id IS NULL;


-- select * from account.users where id = 'f0901ba8-cddf-4b37-9560-52f3e58e4640';


-- generating a query which will select the number of participant in specific support group by partner id

-- select count(id) from participants;

-- select count(id) from participant_supports;

-- select count(ip.id) from intervention_participants ip left join participant_supports ps on ip.id=ps.intervention_participant_id where ps.id is null;

-- select count(ip.participant_id) as total_students, pa.name as school_center  from participant_supports ps left join intervention_participants ip on ps.intervention_participant_id=ip.id left join partners pa on ip.partner_id = pa.id  group by ip.partner_id, pa.name;

-- select count(ip.participant_id) as total_students, pa.name as school_center from intervention_participants ip left join participant_supports ps on ip.id = ps.intervention_participant_id left join partners pa on ip.partner_id=pa.id group by ip.partner_id, pa.name;

-- COUNT(DISTINCT ip.participant_id) AS participants

--================== with out unassigned support ===============--
-- SELECT s.name AS support,
-- pa.name AS school_center,
-- COUNT(*) AS participants
-- FROM participant_supports ps
-- JOIN
-- 	support s ON ps."support_Id" = s.id
-- JOIN
-- 	intervention_participants ip ON ps.intervention_participant_id=ip.id
-- JOIN
-- 	partners pa ON ip.partner_id=pa.id
-- GROUP BY
-- 	s.name,
--   pa.name
-- ORDER BY	 
-- 	s.name,
--   pa.name;
  
  
--================== with unassigned support ===============--
-- SELECT 
--   COALESCE(s.name, 'Unassigned') AS support,
--   pa.name AS school_center,
--   COUNT(*) AS participant_count
-- FROM 
--   intervention_participants ip
-- JOIN 
--   partners pa ON ip.partner_id = pa.id
-- LEFT JOIN 
--   participant_supports ps ON ps.intervention_participant_id = ip.id
-- LEFT JOIN 
--   support s ON ps."support_Id" = s.id
-- GROUP BY 
--   COALESCE(s.name, 'Unassigned'),
--   pa.name
-- ORDER BY
--   support,
--   pa.name;


-- select ps.full_name as participant ,pa.name as school_center, us.full_name as registering_user ,ps.created_at as registered_at from participants ps left join partners pa on ps.partner_id=pa.id left join account.users us on ps.created_by=us.id order by ps.created_at desc;
--  select * from participants ps left join participant_types pt on ps.type=pt.id where pt.name !='teacher';

-- select * from interventions;
  
--   select * from participant_types;

  
--   select count(id) from participant_supports;


-- select phone_number from participants;


-- SELECT phone_number FROM participants WHERE phone_number LIKE '9%' OR phone_number LIKE '7%';

-- SELECT phone_number FROM participants;


-- UPDATE participants SET phone_number = '251' || phone_number
-- WHERE NOT phone_number LIKE '251%' AND (phone_number LIKE '9%' OR phone_number LIKE '7%');

-- select p.full_name, p.phone_number, u.full_name registering_user from participants p join account.users u on p.created_by = u.id where p.phone_number not LIKE '251%' ;

-- select p.id, p.full_name participant, p.phone_number,p.gender ,p.created_at registered_at , u.full_name registering_user from participants p join account.users u on p.created_by = u.id where p.phone_number in ('977035329','251977035329','921026524','251921026524','904331761','251904331761','985859152','251985859152','909275164','251909275164');

-- select * from participants where id = '3da3ed50-e380-483d-8eb9-ab25e57388b7' or id = '8b042e47-6763-4e10-a150-45dcf69feda2';

-- UPDATE participants p
-- SET phone_number = '251' || phone_number
-- WHERE NOT phone_number LIKE '251%' 
--   AND (phone_number LIKE '9%' OR phone_number LIKE '7%')
--   AND NOT EXISTS (
--     SELECT 1
--     FROM participants p2
--     WHERE p2.phone_number = '251' || p.phone_number
-- );

-- select * from intervention_participants where intervention_id = '3c2c5caa-da3e-43a8-932e-ffc0bb967044';


-- select * from account.users;

-- select * from account.users;

-- select * from partners;
-- select * from intervention_partners;

-- insert into intervention_partners (intervention_id,partner_id,created_by) values('3c2c5caa-da3e-43a8-932e-ffc0bb967044','5ef7c13e-c687-4f12-8d04-596e089d6e32','f0901ba8-cddf-4b37-9560-52f3e58e4640');

-- 5ef7c13e-c687-4f12-8d04-596e089d6e32

-- SELECT
--   intervention_participant_id,
--   COUNT(DISTINCT date) AS date_count
-- FROM
--   participant_supports 
-- GROUP BY
--   intervention_participant_id
-- HAVING
--   COUNT(DISTINCT date) > 1;

-- SELECT
--   ps.intervention_participant_id,
--   COUNT(DISTINCT ps.date) AS same_date_frequency,
--   p.full_name AS participant_name,
--   i.title AS intervention
-- FROM
--   participant_supports ps
-- JOIN
--   intervention_participants ip ON ps.intervention_participant_id = ip.id
-- JOIN
--   participants p ON ip.participant_id = p.id
-- JOIN 
-- 	interventions i ON ip.intervention_id = i.id
-- GROUP BY
--   ps.intervention_participant_id,
--   p.full_name,
--   i.title
-- HAVING
--   COUNT(DISTINCT ps.date) > 1;

-- Step 1: Find IDs with more than one distinct date
-- WITH duplicate_dates AS (
--   SELECT
--     intervention_participant_id
--   FROM
--     participant_supports
--   GROUP BY
--     intervention_participant_id
-- )

-- Step 2: Join to get full details, including each date
-- SELECT
--   ps.intervention_participant_id,
--   ps.date,
--   p.full_name AS participant_name,
--   i.title AS intervention,
--   s.name as support
-- FROM
--   participant_supports ps
-- JOIN
--   duplicate_dates dd ON ps.intervention_participant_id = dd.intervention_participant_id
-- JOIN
--   intervention_participants ip ON ps.intervention_participant_id = ip.id
-- JOIN
--   participants p ON ip.participant_id = p.id
-- JOIN 
--   interventions i ON ip.intervention_id = i.id
-- JOIN 
-- 	support s ON ps."support_Id"=s.id
-- ORDER BY
-- 	  participant_name;
--   ps.intervention_participant_id, ps.date,;



-- with prep as (
--     select count(*), intervention_participant_id, "support_Id", date,created_by from participant_supports  group by intervention_participant_id, "support_Id",date,created_by
-- )

-- select p.id participant_id,p.full_name as participant, i.title as intervention, pp.name as partner, s.name as support, prp.date, prp.count,u.full_name registering_user from prep prp
-- join intervention_participants ip on prp.intervention_participant_id = ip.id
-- join participants p on ip.participant_id = p.id
-- join partners pp on ip.partner_id = pp.id
-- join interventions i on ip.intervention_id = i.id
-- join "support" s on prp."support_Id"=s.id
-- join account.users u on prp.created_by=u.id
-- where prp.count > 1;

-- select p.full_name as participant,ps.date as date,s.name as support, ps.created_at,u.full_name as registering_user from participants p 
-- join intervention_participants ip on p.id=ip.participant_id 
-- join participant_supports ps on ip.id=ps.intervention_participant_id 
-- join support s on ps."support_Id"=s.id
-- join account.users u on ps.created_by = u.id where p.id in 
-- ('77ccb604-23b7-4d1e-b474-86d059f55fb1',
-- '6ceff89a-3db1-4397-9ce3-4b14d41cef72',
-- '02f5d9fd-54fe-45af-be11-9572ccab8c0c',
-- '832088b4-caa5-4d8e-a078-8ccf73444f73',
-- '08dcbebf-e219-4f9b-87a2-6d6c8d73fca8',
-- '8b042e47-6763-4e10-a150-45dcf69feda2',
-- 'b28a9e87-9e79-40a7-97b0-ba77a54a9cd1',
-- 'e6df2d88-f159-42ae-948f-5784d82d01c4',
-- 'e6df2d88-f159-42ae-948f-5784d82d01c4',
-- '73ad4abc-db7d-4c16-bfba-229f5d1782d2',
-- 'ff80708b-4771-4643-9aa7-0b5d9629164a',
-- '57762c47-186c-40ff-a056-a676335f8123',
-- '81fcd2a9-cf28-4d1c-ab45-b6e8ee29b285',
-- 'd0a83d7d-e9a4-48e5-9731-5059d73c914f',
-- 'fa0bfba2-37e9-4f52-8e82-2f58894bd75f',
-- 'e32e46b7-73e0-4242-8bf7-9966a1ab4b2d',
-- '5b6f1d26-3f15-4ab5-9d28-52de950f683c',
-- '9063113d-664a-4e15-8a58-cef38f76a0aa',
-- 'c5a1c192-aa2f-4d21-ac0b-cc1580c2f572',
-- '4c811d48-8348-4115-984c-f7535caf2de0',
-- '32867282-5f0d-4d79-862a-c79a92ba0686',
-- '0b04adc2-708b-4890-9357-7b7a15e3586c',
-- '7679bf78-9c2a-4818-a5ae-677e7e4448bd',
-- '8dd630c1-530f-4757-99a3-2c4945e99cdf',
-- 'ebc9c385-4bf6-40da-adb1-e819a72de8c0',
-- 'c147daf3-c18d-459d-bb9a-c0ed6c370fb7',
-- '4a8f9364-ce43-4bf1-912b-310126d80bb9',
-- '860ac74a-b72a-4fa6-bb1a-9ec17d5d3836');

-- select * from participants where created_at >= CURRENT_DATE
--   AND created_at < CURRENT_DATE + INTERVAL '1 day';

-- select * from basic.subcity_zones;

-- delete from basic.subcity_zones where id = '0qvA7li1hpATQpUr';
  
  
  
--   select * from participant_supports ps join intervention_participants ip on ps.intervention_participant_id = ip.id join support s on ps."support_Id"=s.id where ps.intervention_participant_id='6c2293d7-7e44-4ce9-b962-954d55510b71' ; 
  
  

-- select * from participant_supports where interven;

-- select * from participant_supports;

-- select * from partners;

-- insert into partners (name,description,type,created_at)

-- select * from partners;

-- update partners set is_proxy_partner = false ;

-- select * from partners;

-- select count(*) from participants where partner_id = '0fa648fd-c3e9-42a2-9f0d-514e50f98190' AND created_at > '2025-05-21' AND created_at < '2025-05-24';

-- select * from types.partner;

-- delete from types.partner where name = 'test';

-- select * from types.partner;

-- select * from intervention_participants where partner_id is null;

-- update intervention_participants ip set partner_id = p.partner_id from participants p where ip.participant_id=p.id and ip.partner_id is null and p.partner_id is not null;



-- insert into partners (name,description,type,created_by,is_proxy_partner,proxy_partner_id) values ('Karalo High School','Karalo High School','School','f0901ba8-cddf-4b37-9560-52f3e58e4640',true,'0fa648fd-c3e9-42a2-9f0d-514e50f98190'),
-- ('Millenium High School','Millenium High School','School','f0901ba8-cddf-4b37-9560-52f3e58e4640',true,'0fa648fd-c3e9-42a2-9f0d-514e50f98190'),
-- ('Selam Childrens village /Rofam','Selam Childrens village /Rofam','School','f0901ba8-cddf-4b37-9560-52f3e58e4640',true,'0fa648fd-c3e9-42a2-9f0d-514e50f98190'),
-- ('Ergib High School','Ergib High School','School','f0901ba8-cddf-4b37-9560-52f3e58e4640',true,'0fa648fd-c3e9-42a2-9f0d-514e50f98190'),
-- ('Kidus Michael High School','Kidus Michael High School','School','f0901ba8-cddf-4b37-9560-52f3e58e4640',true,'0fa648fd-c3e9-42a2-9f0d-514e50f98190');

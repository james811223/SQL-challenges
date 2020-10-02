SELECT CONCAT(Name,'(',SUBSTR(Occupation,1,1),')') from OCCUPATIONS
order by Name;
select CONCAT('There are a total of ',count(Name),' ',LOWER(Occupation),'s.') from OCCUPATIONS
group by Occupation
order by count(Name),Occupation;

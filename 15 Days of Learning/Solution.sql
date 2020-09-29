with tb as(
select submission_date,s.hacker_id as id,name,count(submission_id) as n,rank() over(partition by s.hacker_id order by submission_date) as sub_check from Submissions s
left join Hackers h on h.hacker_id =s.hacker_id
group by submission_date,s.hacker_id,name 
)

select date_,sub1,id,name from(
select tb.submission_date as date_,s1,id,name,n,rank() over(partition by tb.submission_date order by id) as rank from tb
left join (select submission_date,count(distinct(id)) as s1,max(n) as max_n from tb
group by submission_date
) l on l.submission_date=tb.submission_date
where n=max_n) as tbl
left join (select submission_date,count(id) as sub1 from tb
where sub_check=day(submission_date)
group by submission_date) ll on ll.submission_date=tbl.date_
where rank=1

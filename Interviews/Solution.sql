with vs as (
select challenge_id,sum(total_views) as total_views,sum(total_unique_views) as total_unique_views from View_Stats
group by challenge_id
),

st as(
select challenge_id,sum(total_submissions) as total_submissions,sum(total_accepted_submissions) as total_accepted_submissions from Submission_Stats
group by challenge_id
)

select cl.contest_id, hacker_id, name, sum(total_submissions) as s1, sum(total_accepted_submissions) as s2, sum(total_views) as s3, sum(total_unique_views) as s4 from Challenges clg
left join Colleges cl on clg.college_id=cl.college_id
left join Contests ct on cl.contest_id=ct.contest_id
left join vs on clg.challenge_id=vs.challenge_id
left join st on clg.challenge_id=st.challenge_id
group by cl.contest_id, hacker_id, name
having sum(total_submissions)>0 or sum(total_accepted_submissions)>0 or sum(total_views)>0 or sum(total_unique_views)>0
order by cl.contest_id

WITH a AS (
	SELECT assignments.assignment_id as assignment_id, count(*) as num_total_donations
	FROM public.assignments as assignments
	GROUP BY assignments.assignment_id
	ORDER BY num_total_donations 
),

b AS (
	SELECT assignment_id,
	assignment_name,
	region,
	impact_score,
	ROW_NUMBER () OVER (PARTITION BY region ORDER BY impact_score DESC) as rank_n 
	FROM public.assignments as assignments
	ORDER BY region ASC, rank_n ASC
)

select b.assignment_name, b.region, b.impact_score, a.num_total_donations from a 
INNER JOIN b
	ON a.assignment_id = b.assignment_id
where rank_n = 1
order by b.region asc

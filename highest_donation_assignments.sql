WITH a AS (
	SELECT donations.assignment_id,donors.donor_type,round(sum(donations.amount),2) as rounded_total_donation_amount
	FROM public.donations as donations
	INNER JOIN public.donors as donors
	ON donations.donor_id = donors.donor_id
	GROUP BY donations.assignment_id,donors.donor_type
	ORDER BY rounded_total_donation_amount DESC
)

SELECT assignment_name,
	region,
	a.rounded_total_donation_amount,
	a.donor_type
FROM public.assignments as assignments
INNER JOIN a
ON assignments.assignment_id = a.assignment_id
LIMIT 5

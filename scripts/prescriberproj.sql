--1. 
   --a. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the npi and the total number of claims.
  SELECT SUM(total_claim_count) AS total_claim_count, npi
  FROM prescription AS p
  INNER JOIN prescriber AS pr
  USING(npi)
  GROUP BY npi
  ORDER BY total_claim_count DESC
  LIMIT 1;
  
  --b. Repeat the above, but this time report the nppes_provider_first_name, nppes_provider_last_org_name,  specialty_description, and the total number of claims.
  SELECT SUM(total_claim_count) AS total_claim_count, nppes_provider_first_name, nppes_provider_last_org_name, specialty_description
  FROM prescription
  INNER JOIN prescriber
  USING(npi)
  GROUP BY nppes_provider_first_name, nppes_provider_last_org_name, specialty_description
  ORDER BY total_claim_count DESC
  LIMIT 1;
  
 --2. 
    --a. Which specialty had the most total number of claims (totaled over all drugs)?
	SELECT SUM(total_claim_count) AS total_claim_count, specialty_description
	FROM prescription
	INNER JOIN prescriber
    USING (npi)
	GROUP BY specialty_description
	ORDER BY total_claim_count DESC
	LIMIT 1;
	
	--b. Which specialty had the most total number of claims for opioids	
	SELECT specialty_description, SUM(total_claim_count) AS total_claim_count
	FROM prescriber
	LEFT JOIN prescription
	USING(npi)
	INNER JOIN drug
	USING(drug_name)
	WHERE opioid_drug_flag = 'Y'
	GROUP BY specialty_description
	ORDER BY total_claim_count DESC
	LIMIT 1;
	--c. **Challenge Question:** Are there any specialties that appear in the prescriber table that have no associated prescriptions in the prescription table?
	
	
	
	--d. **Difficult Bonus:** *Do not attempt until you have solved all other problems!* For each specialty, report the percentage of total claims by that specialty which are for opioids. Which specialties have a high percentage of opioids?
	
--3. 
    --a. Which drug (generic_name) had the highest total drug cost?
	SELECT total_drug_cost, generic_name 
	FROM drug
	INNER JOIN prescription
	USING(drug_name)
	ORDER BY total_drug_cost DESC
	LIMIT 1;
	
	--b. Which drug (generic_name) has the hightest total cost per day? **Bonus: Round your cost per day column to 2 decimal places. Google ROUND to see how this works.**
	
	SELECT ROUND((total_drug_cost/total_day_supply),2) AS total_cost_per_day , generic_name
	FROM prescription
	INNER JOIN drug
	USING(drug_name)
	ORDER BY total_cost_per_day DESC
	LIMIT 1;
	
--	4. 
   --a. For each drug in the drug table, return the drug name and then a column named 'drug_type' which says 'opioid' for drugs which have opioid_drug_flag = 'Y', says 'antibiotic' for those drugs which have antibiotic_drug_flag = 'Y', and says 'neither' for all other drugs.
   SELECT drug_name, 
		 CASE WHEN opioid_drug_flag = 'Y' THEN 'Opioid'
		      WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
		      ELSE 'neither' END AS drug_type
	FROM drug;
	

   --b. Building off of the query you wrote for part a, determine whether more was spent (total_drug_cost) on opioids or on antibiotics. Hint: Format the total costs as MONEY for easier comparision.
  
SELECT CAST(SUM(total_drug_cost) AS money) AS total_opioid_cost, 
			(SELECT CAST(SUM(total_drug_cost) AS money) AS total_antibiotic_cost
			FROM drug
			INNER JOIN prescription
			USING(drug_name)
			WHERE antibiotic_drug_flag = 'Y'
			GROUP BY opioid_drug_flag, antibiotic_drug_flag)
FROM drug
INNER JOIN prescription
USING(drug_name)
WHERE opioid_drug_flag = 'Y'
GROUP BY opioid_drug_flag, antibiotic_drug_flag

--5. 
    --a. How many CBSAs are in Tennessee? **Warning:** The cbsa table contains information for all states, not just Tennessee.
	SELECT COUNT(cbsa)
	FROM cbsa
	INNER JOIN fips_county
	USING(fipscounty)
	WHERE state = 'TN';
	
	--b. Which cbsa has the largest combined population? Which has the smallest? Report the CBSA name and total population.
	SELECT cbsa, population
	FROM cbsa
	INNER JOIN population
	USING(fipscounty)
	ORDER BY population ASC
	LIMIT 1;

	SELECT cbsa, population
	FROM cbsa
	INNER JOIN population
	USING(fipscounty)
	ORDER BY population DESC		
	LIMIT 1;		
	-- still working
	--c. What is the largest (in terms of population) county which is not included in a CBSA? Report the county name and population.
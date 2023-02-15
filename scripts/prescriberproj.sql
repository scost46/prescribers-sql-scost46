--1. 
   --a. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the npi and the total number of claims.
  SELECT total_claim_count, npi
  FROM prescription
  INNER JOIN prescriber
  USING(npi)
  ORDER BY total_claim_count DESC
  LIMIT 1;
  
  --b. Repeat the above, but this time report the nppes_provider_first_name, nppes_provider_last_org_name,  specialty_description, and the total number of claims.
  SELECT total_claim_count, nppes_provider_first_name, nppes_provider_last_org_name, specialty_description
  FROM prescription
  INNER JOIN prescriber
  USING(npi)
  ORDER BY total_claim_count DESC
  LIMIT 1;
  
 --2. 
    --a. Which specialty had the most total number of claims (totaled over all drugs)?
	SELECT total_claim_count, specialty_description
	FROM prescription
	INNER JOIN prescriber
    USING (npi)
	ORDER BY total_claim_count DESC
	LIMIT 1;
	
	--b. Which specialty had the most total number of claims for opioids?
	SELECT total_claim_count, specialty_description, opioid_drug_flag
	FROM prescriber
	INNER JOIN prescription
	USING(npi)
	INNER JOIN drug
	USING(drug_name)
	WHERE opioid_drug_flag = 'Y'
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
	
	
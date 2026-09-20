cat > scripts/census_state_comparison.do << 'EOF'
* ============================================================
* Census 2011 Disability Prevalence — 5-State Comparison
* Author: Abhishek Gupta (lucky-464)
* Date: September 2026
* Purpose: Compare disability prevalence across UP, Maharashtra,
*          Bihar, Kerala, Tamil Nadu using Census 2011 C-20 data
* Source:  data.gov.in — Census 2011 Table C-20
* ============================================================

* --- 1. Import and clean ---
import delimited "c20_disabled.csv", clear
drop in 1/5

* --- 2. Rename columns ---
rename v1 tablename
rename v2 state_code
rename v3 district_code
rename v4 area_name
rename v5 area_type
rename v6 age_group
rename v7 total_persons
rename v8 total_males
rename v9 total_females
rename v10 seeing_persons
rename v11 seeing_males
rename v12 seeing_females
rename v13 hearing_persons
rename v14 hearing_males
rename v15 hearing_females
rename v16 speech_persons
rename v17 speech_males
rename v18 speech_females
rename v19 movement_persons
rename v20 movement_males
rename v21 movement_females
rename v22 mr_persons
rename v23 mr_males
rename v24 mr_females
rename v25 mi_persons
rename v26 mi_males
rename v27 mi_females
rename v28 other_persons
rename v29 other_males
rename v30 other_females
rename v31 multiple_persons
rename v32 multiple_males
rename v33 multiple_females
drop tablename

* --- 3. Destring ---
destring state_code district_code, replace
destring total_persons total_males total_females seeing_persons seeing_males seeing_females hearing_persons hearing_males hearing_females speech_persons speech_males speech_females movement_persons movement_males movement_females mr_persons mr_males mr_females mi_persons mi_males mi_females other_persons other_males other_females multiple_persons multiple_males multiple_females, replace ignore(",")

* --- 4. Filter to state-level totals ---
keep if area_type == "Total" & age_group == "Total"
save census_disability_states.dta, replace

* --- 5. Keep 5 focus states ---
keep if inlist(area_name, "State-UTTAR PRADESH", "State-MAHARASHTRA", "State-BIHAR", "State-KERALA", "State-TAMIL NADU")

* --- 6. Add state population (Census 2011) and compute rate ---
gen total_population = .
replace total_population = 199812341 if area_name == "State-UTTAR PRADESH"
replace total_population = 112374333 if area_name == "State-MAHARASHTRA"
replace total_population = 104099452 if area_name == "State-BIHAR"
replace total_population = 33406061  if area_name == "State-KERALA"
replace total_population = 72147030  if area_name == "State-TAMIL NADU"

gen disability_rate = (total_persons / total_population) * 100
format disability_rate %5.2f

* --- 7. Bar chart ---
replace area_name = subinstr(area_name, "State-", "", .)
graph hbar disability_rate, over(area_name, sort(1) descending) ///
    title("Disability Prevalence Rate by State, Census 2011") ///
    ytitle("Rate (%)") bar(1, color(navy))
graph export output/state_comparison.png, replace

* --- 8. Save enriched dataset ---
save census_disability_states.dta, replace
EOF

# Disability Prevalence in India — Census 2011 & NFHS-5 Comparison

A small analysis of disability prevalence across five Indian states
(Uttar Pradesh, Maharashtra, Bihar, Kerala, Tamil Nadu) using
Census 2011 data, with a postmortem comparing it against NFHS-5
findings.

## Headline Finding

Among five major states analyzed using Census 2011 data, disability
prevalence ranges from **1.64% in Tamil Nadu** to **2.64% in
Maharashtra**, with Kerala (2.28%), Bihar (2.24%), and Uttar Pradesh
(2.08%) in between. The ranking does not map cleanly onto
conventional development indicators — Maharashtra and Kerala, both
relatively high on human development metrics, report *higher*
prevalence than Bihar and UP, which rank lower on most such measures.

Initial hypothesis: this reflects differences in disability
awareness and self-reporting rather than true underlying incidence,
since Census 2011 relied on a simple yes/no disability question
rather than a more sensitive functional-difficulty format. This
hypothesis is tested — and complicated — below.

## Postmortem — Census 2011 vs NFHS-5

NFHS-5 (2019–21) measures disability using the Washington Group
Short Set (WG-SS), six functional-difficulty questions (seeing,
hearing, walking, cognition, self-care, communication), considered
more accurate than Census's binary yes/no format.

State-wise NFHS-5 estimates (from Pattnaik et al., 2023, corrected
via published corrigendum — see Sources) show a striking reversal:
**Tamil Nadu**, the *lowest*-ranked state in my Census 2011 analysis,
becomes one of the *highest*-ranked states nationally under NFHS-5.
Uttar Pradesh and Bihar, mid-pack under Census, drop toward the
bottom under NFHS-5.

| State | Census 2011 | NFHS-5 (2019–21) |
|---|---|---|
| Maharashtra | 2.64% | 1.21% |
| Kerala | 2.28% | 1.16% |
| Bihar | 2.24% | 0.90% |
| Uttar Pradesh | 2.08% | 0.72% |
| Tamil Nadu | 1.64% | **1.28%** |

This contradicts a simple "higher literacy → more accurate
self-reporting" story — if that were the whole explanation, Tamil
Nadu should rank high under *both* methods, not flip entirely.
National prevalence also differs sharply across sources: 2.21%
(Census 2011) vs. 0.93% (NFHS-5, post-corrigendum) vs. 2.2% (NSS 76th
Round, 2018) — three credible surveys disagreeing not just on level
but on direction. Reconciling this fully requires the underlying
microdata; a DHS Program request for NFHS-5 unit-level data is
pending as independent verification (see Caveats).

## Data Sources

- **Census 2011 Table C-20** — Disabled Population by Type of
  Disability, Age and Sex — via [data.gov.in](https://data.gov.in)
- **NFHS-5 state-wise disability estimates** — Pattnaik S, Murmu J,
  Agrawal R, Rehman T, Kanungo S, Pati S. "Prevalence, pattern and
  determinants of disabilities in India: Insights from NFHS-5
  (2019–21)." *Frontiers in Public Health*, 2023 (PMID 36923034),
  with corrigendum correcting national prevalence to 0.93%.

## Tools

- - StataNow/MP 19.5 (data import, cleaning, analysis, chart)

## Repo Structure
├── README.md
├── data/
│ └── census_disability_states.dta # cleaned 5-state dataset
├── scripts/
│ └── census_state_comparison.do # full pipeline
├── output/
│ └── state_comparison.png # bar chart
└── analysis/
└── postmortem_nfhs5_comparison.md # write-up of the reversal finding


## Reproduction

1. Download the Census 2011 C-20 file from data.gov.in (search:
   "Disabled Population by type of Disability, Age and Sex Census
   2011"); it downloads as `DDW-C20-0000.xlsx`.
2. Convert to CSV: open the `.xlsx` in Excel or Numbers, **File →
   Save As → CSV (UTF-8)**, name it `c20_disabled.csv`, and place it
   in the same directory as the `.do` file.
3. In Stata, run `scripts/census_state_comparison.do` top to bottom.
   The script imports the CSV, drops the 5 leading header rows,
   renames columns, destrings the count columns (handling embedded
   commas), filters to state-level totals, keeps the 5 focus states,
   computes prevalence rates, and exports the chart.
4. Chart appears as `output/state_comparison.png`.

## Caveats

- Population figures used to compute Census-based rates are 2011
  state totals, entered manually.
- Census 2011 disability status is self-reported and
  enumerator-coded via a binary question; cross-state comparability
  is limited by awareness and reporting differences.
- NFHS-5 state-wise figures are drawn from a secondary published
  source (not raw microdata I processed myself). A DHS Program
  request for unit-level NFHS-5 data is pending, to independently
  verify these estimates.

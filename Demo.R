# install.packages("genieBPC")

library(genieBPC)
library(tidyverse)
library(gtsummary)

###############################################################################
#                         Demo with NSCLC 2.0-public data                     #
###############################################################################
# log into Synapse
set_synapse_credentials("email@email.com", "password")

# pull data from Synapse into R
nsclc_synapse_data <- pull_data_synapse(cohort = "NSCLC",
                                  version = "v2.0-public")

# create analytic cohort for case study
nsclc_cohort <- create_analytic_cohort(
  data_synapse = nsclc_synapse_data$NSCLC_v2.0,
  stage_dx = c("Stage IV"),
  histology = "Adenocarcinoma",
  regimen_drugs = c("Carboplatin, Pemetrexed Disodium",
                    "Cisplatin, Pemetrexed Disodium",
                    "Bevacizumab, Carboplatin, Pemetrexed Disodium",
                    "Bevacizumab, Cisplatin, Pemetrexed Disodium"),
  regimen_type = "Exact",
  regimen_order = 1,
  regimen_order_type = "within cancer",
  return_summary = TRUE
)

# review summary tables
nsclc_cohort$tbl_overall_summary
nsclc_cohort$tbl_cohort
nsclc_cohort$tbl_drugs
nsclc_cohort$tbl_ngs

# create sunburst plot
nsclc_sunburst <- drug_regimen_sunburst(data_synapse = nsclc_synapse_data$NSCLC_v2.0,
                                        data_cohort = nsclc_cohort)

nsclc_sunburst$sunburst_plot

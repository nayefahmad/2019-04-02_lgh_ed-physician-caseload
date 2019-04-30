


#*****************************************************************************
# LGH Trauma physicians' caseload 
# 2019-04-15
# Nayef 
# jira si-2680 


#*****************************************************************************

library(tidyverse)
library(here)

# source function for subsetting rows using all columns of doctor codes: 
source(here::here("src", 
                  "filter-by-doc_function.R"))



# 1) read in ED data data: ------------
options(readr.default_locale=readr::locale(tz="America/Los_Angeles"))

df1.ed_data <- 
  read_csv(here::here("results", 
                      "dst", 
                      "2019-04-25_lgh_physician-caseload-patient-details.csv")) %>% 
  mutate(CMGPlusCode = as.character(CMGPlusCode)) %>% 
  mutate_at(vars(DR1DoctorCode, 
                 DR2DoctorCode, 
                 MostRespProviderCode), 
            as.character)



# str(df1.ed_data)
# summary(df1.ed_data)
# head(df1.ed_data)




# 2) read in list of doctors we are interested in: ----------
df2.ed_docs <- 
  read_csv(here::here("results", 
                      "dst", 
                      "2019-04-15_lgh_trauma-physicians.csv")) %>% 
  mutate(code = as.character(code))


# df2.ed_docs





# 3) map function across rows: ------------
df3.filtered_by_doc <- 
  df2.ed_docs %>% 
  mutate(filtered_data = map(code, 
                             filter_rows_by_doc, 
                             df = df1.ed_data))


# unnest result: 
df4.filtered_by_doc_unnested <- 
  df3.filtered_by_doc %>% 
  unnest()




# 4) write output: 
write_csv(df4.filtered_by_doc_unnested,
          here::here("results", 
                     "dst", 
                     "2019-04-16_lgh_cases-grouped-by-trauma-physicians.csv"))
             



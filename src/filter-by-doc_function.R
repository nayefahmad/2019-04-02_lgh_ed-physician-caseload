

#*****************************************************************************
# Function to filter rows based on all doctor codes: Dr1 to Dr8
# 2019-04-15
# Nayef 
# jira si-2680 


#*****************************************************************************


# define function: --------
filter_rows_by_doc <- 
  function(doc_code, df) {
    
    # input: dataframe of patient-level records. 
    
    # output: filter rows to include only those where the doctor we're
    # interested in ("doc_code") is involved as Dr1, or D2, or ... Dr8
    
    
    df_filtered <- 
      df %>% 
      filter(DR1DoctorCode == doc_code | 
               DR2DoctorCode == doc_code |
               DR3DoctorCode == doc_code | 
               DR4DoctorCode == doc_code |
               DR5DoctorCode == doc_code |
               DR6DoctorCode == doc_code |
               DR7DoctorCode == doc_code |
               DR8DoctorCode == doc_code
      )
    
    return(df_filtered)
    
  }



# test function: --------
# filter_rows_by_doc("26650", 
#                    df1.ed_data) %>% 
#   select(starts_with("DR")) %>% 
#   View("test")

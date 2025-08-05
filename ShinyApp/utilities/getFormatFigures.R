format_number <- function(x, digits = 2) {
  if (is.na(x)) return("NA")
  
  abs_x <- abs(x)
  formatted_number <- 
    if (abs_x >= 1e9) {
      paste0(round(x / 1e9, digits), "B") 
  } 
    else if (abs_x >= 1e6) {
      paste0(round(x / 1e6, digits), "M")
  } 
    else if (abs_x >= 1e3) {
      paste0(round(x / 1e3, digits), "K")
  }
    else {
      as.character(round(x, digits))
  }
  
  return(formatted_number)
}

format_percentage <- function(x) {
  if (is.na(x)) return("NA")
  paste0(x, "%")
}
data <- read.csv("D:GIT/studyR/data/lab1_e1.csv",sep=',')
restore <- function(entry) {
  tryCatch(
    { as.numeric(gsub(" ", "", entry)) },
    error = function(cond) entry,
    warning = function(cond) entry,
    finally = {}
  ) 
}

fix <- function(data) {
  sapply(data, function(obs) lapply(obs, restore))
}
fix(data)

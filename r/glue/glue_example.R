# https://github.com/tidyverse/glue

devtools::install_github("tidyverse/glue")

library(glue)

name <- "Max"
age <- 24
birthday <- as.Date("1993-06-07")

glue('My name is {name}, I am going to be {age + 1} next year. My birthday is on {birthday}.')

`%>%` <- magrittr::`%>%`
head(mtcars) %>% glue_data("{rownames(.)} has {hp} hp")

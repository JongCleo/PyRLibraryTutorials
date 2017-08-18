library(tidyverse)

# data <- tibble(a = rnorm(1000, 100, 5), b = rnorm(1000, 0, 2))
# write_csv(data, "data/fake_data.csv")

devtools::install_github("krlmlr/here")
library(here)
here()

here("data", "fake_data.csv")

df <- here("data", "fake_data.csv") %>% read_csv()

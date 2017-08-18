# daff
# https://github.com/edwindj/daff
# http://schd.ws/hosted_files/user2017/09/daff.pdf

# Daff is a diff for data.frames
# Detect changes: diff_data, differs_from 
# Store and restore diff: write_diff, read_diff 
# Patch updated data: patch_data, merge_data 
# Render a diff: render_diff

# install----

devtools::install_github("edwindj/daff")

# load----

library(daff)
library(tibble)
library(magrittr)
library(tidyverse)

# example 1 - value changed----

x <- data.frame(a = 1, b = 1)
x_changed <- data.frame(a = 1, b = 100)
patch <- diff_data(x, x_changed)
print(patch)

patch_data(x_changed, patch)

# example 2 - row was added----

x <- tibble(a = 1, b = 1)
x_changed <- tibble(a = c(1, 2), b = c(1, 2))
diff_data(x, x_changed)

# example 3 - row was deleted---- 

x <- tibble(a = c(1, 2), b = c(1, 2))
x_changed <- tibble(a = 1, b = 1)
diff_data(x, x_changed)

# example 4 - column was added----

x <- tibble(a = 1, b = 1)
x_changed <- tibble(a = 1, b = 1, c = 1)
diff_data(x, x_changed)

# example 5 - column was removed----

x <- tibble(a = 1, b = 1, c = 1)
x_changed <- tibble(a = 1, b = 1)
diff_data(x, x_changed)

# example 6 - merge changes----

x <- tibble(a = 1, b = 1)
x_a <- tibble(a = 100, b = 1)
x_b <- tibble(a = 1, b = 100)

merge_data(x, x_a, x_b)

# example 7 - render changes----

x <- tibble(a = c(1, 2), b = c(1, 2))
x_changed <- tibble(b = 2, c = 1)

x_changed %>% 
    differs_from(x) %>% 
    render_diff(use.DataTable = FALSE)

# bigger example

data("starwars")
View(starwars)

sw_small <- starwars %>% 
    filter(row_number() <= 10) %>% 
    select(name, homeworld, species, birth_year)

sw_small_changed <- sw_small %>% 
    filter(name != "R5-D4") %>% 
    rowwise() %>% 
    mutate(alive = rbinom(1, size = 1, prob = 0.5)) %>% 
    select(-birth_year) %>% 
    mutate(species = ifelse(name == "R2-D2", "Robot", species)) %>% 
    bind_rows(tibble(name = "Max", homeworld = "Earth", species = "Human", alive = 1)) %>% 
    arrange(alive)

diff_data(sw_small, sw_small_changed) %>% render_diff(use.DataTable = FALSE)

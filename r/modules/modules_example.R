# https://github.com/wahani/modules

devtools::install_github("wahani/modules")

library(modules)

# one-file example

example <- module({
    boring_function <- function() {"boring output"}
})

example$boring_function()

# example for using other functions 

stats <- module({
    import("stats", "median") # make median from package stats available
    my_median <- function(x) { median(x, TRUE) } 
})

stats$my_median(c(10, 20, 30))

# example for seperate scripts

code <- "
import('stats', 'median')
functionWithDep <- function(x) median(x)
"

fileName <- tempfile(fileext = ".R")
writeLines(code, fileName)

m <- use(fileName)
m$functionWithDep(1:2)

# more complete example 

library(modules)
library(here)
here()

pf <- use("personal_functions.R")

pf$kink(
    x = 0.132,
    intercept = 100,
    slopes = c(1500, 1100, 3100, 1500),
    breaks = c(0.06, 0.14, 0.16)
)

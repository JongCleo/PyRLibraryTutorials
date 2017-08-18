# FFTrees
# http://www.github.com/ndphillips/FFTrees
# install.packages("FFTrees")  

library(FFTrees)

# guide

FFTrees.guide()

# data

data("titanic")
head(titanic)

titanic_fft <- FFTrees(survived ~., data = titanic, main = "Titanic", decision.labels = c("Died", "Survived"))
plot(titanic_fft)
inwords(titanic_fft)

##  motivation
# A fast-and-frugal decision tree (FFT) developed by Green & Mehr (1997).
# Tree cut the false-alarm rate in half
# Tree is transparent, easy to modify, and accepted by physicians (unlike regression).

## Fast-and-Frugal Decision Tree (FFT)
# An FFT is a decision tree with exactly two branches from each node, where one, or both, of the branches are exit branches (Martignon et al., 2008)

# example 1

data(heartdisease)
head(heartdisease)

heart_fft <- FFTrees(
    formula = diagnosis ~.,
    data = heart.train,
    data.test = heart.test,
    main = "Heart Disease",
    decision.labels = c("Low-Risk", "High-Risk"))

# inspect fit

heart_fft

## Print a tree "in words"

inwords(heart_fft)

# plot

plot(heart_fft, stats = FALSE, data = "test")
plot(heart_fft, data = "test")  # test data
plot(heart_fft, data = "test", tree = 6)   # Testing data, tree 6
plot(heart_fft, data = "test", tree = 7)   # Testing data, tree 7

# fancy base plot

data.name <- c("arrhythmia", "audiology", "breast", "bridges", "cmc", "credit", "dermatology", "heart", "occupancy", "yeast")
mcu <- c(1.85, 1.73, 1.39, 2.40, 2.06, 1.9, 1.69, 1.72, 1.92, 1.63)
pci <- c(.99, .98, .86, .76, .79, .88, .95, .88, .68, .82)

plot(mcu, pci, xlim = c(1, 10), ylim = c(0, 1), xlab = "Mean cues used to make a decision", 
ylab = "Percent of information ignored", pch = 21, col = "white", 
bg = yarrr::piratepal("basel", trans = .2), cex = 2, main = "FFTrees speed and frugality", xaxt = "n", yaxt = "n")
grid()
axis(1, 1:10)
axis(2, seq(0, 1, .2), las = 1)

rect(7, .05, 10, .95, col = yarrr::transparent("white", .2), border = gray(.5, .5))

text(rep(8, length(data.name)), seq(.1, .9, length.out = length(data.name)), labels = data.name, adj = 0)
points(rep(7.5, length(data.name)), seq(.1, .9, length.out = length(data.name)), pch = 21, col = "white", bg = yarrr::piratepal("basel", trans = .7), cex = 2)

segments(mcu, pci, rep(7.5, length(data.name)), seq(.1, .9, length.out = length(data.name)), col = gray(.5, .2))

# breast cancer diagnosis

breast_fft <- FFTrees(diagnosis ~., data = breastcancer, main = "Breast Cancer", decision.labels = c("Healthy", "Cancer"))
plot(breast_fft)

### Define an FFT manually

# Create an FFT manually
FFTrees(formula = diagnosis ~.,
    data = heart.train,
    my.tree = "
        If chol > 350, predict True. 
        If cp != {a}, predict False. 
        If age <= 35, predict False.
        Otherwise, predict True"
    )

## Cue importance
# As calculated by `randomForest`

heart_importance <- heart_fft$comp$rf$model$importance
heart_importance <- data.frame(cue = rownames(heart_fft$comp$rf$model$importance), importance = heart_importance[,1])
heart_importance <- heart_importance[order(heart_importance$importance),]
yarrr::pirateplot(formula = importance ~ cue, data = heart_importance, sortx = "s", bar.f.o = .5, bar.f.col = "blue")

# Tree Building Algorithm
#1. For each cue (aka, feature), calculate a threshold that maximizes `goal.chase` (default: balanced accuracy)
#2. Rank order cues by `goal.chase`
#3. Select the top `max.levels` (default: 4)
#4. Create a "fan" of all possible trees with all possible exit directions.
#5. Select the tree that maximizes `goal` (default: balanced accuracy)

# Create a forest of FFTs

heart_fff <- FFForest(formula = diagnosis ~., data = heartdisease)
plot(heart_fff)

heart_fff
inwords(heart_fff)

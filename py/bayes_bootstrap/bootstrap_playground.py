# https://github.com/lmc2179/bayesian_bootstrap

! pip install bayesian_bootstrap

import numpy as np

X = np.random.exponential(7, 4)
X

import bayesian_bootstrap.bootstrap as bbs

posterior_samples = bbs.mean(X, 10000)
l, r = bbs.highest_density_interval(posterior_samples)

from matplotlib import pyplot as plt
import seaborn as sns
%matplotlib inline

sns.distplot(posterior_samples, label = "Bayesian Bootstrap Samples")
plt.plot([l, r], [0, 0], linewidth = 5.0, marker='o', label='95% HDI')

# example loan size

three = np.array([18300, 19200, 18200, 18300, 17700, 18500, 18800, 18800, 18200, 18500])
three
three_ps = bbs.bayesian_bootstrap(three, np.mean, 10000, 100)

five = np.array([18200, 18000, 18000, 18300, 17700, 17300, 18800, 18500, 17500])
five_ps = bbs.bayesian_bootstrap(five, np.mean, 10000, 100)

diff = (np.array(five_ps) - np.array(three_ps))

sns.distplot(diff, label = "Bayesian Bootstrap Samples")

help(bbs.bayesian_bootstrap)

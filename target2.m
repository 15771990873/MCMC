function p = target2(x, mu, Sigma)
p = log(mvnpdf(x(:)', mu, Sigma));
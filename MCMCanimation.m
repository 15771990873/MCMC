clc;
clear;
weights = [0.3 0.7];
mus = [0 10];
sigmas = [2 2];
Nsamples = 5000;
sigma_prop = 10; % Standard deviation of the Gaussian proposal.
targetArgs = {weights, mus, sigmas};
proposalArgs = {sigma_prop};
seed = 1;
xinit = 20*rand(1,1); % initial state
[x, naccept] = MH(@target, @proposal, xinit, Nsamples, targetArgs, proposalArgs);


N_bins = 50;
v = VideoWriter('newfile.avi');
open(v)

for i=1:10:Nsamples
    [b,a] = hist(x(1:i-1), N_bins);
    measure = a(2)-a(1); % bin width.
    area = sum(b*measure);
    bar(a,b/(area),'y')
    axis([-10 20 0 .25])
    text(-8,.1,sprintf('Nsamples=%d', i-1))
    writeVideo(v,getframe);
end
close(v)

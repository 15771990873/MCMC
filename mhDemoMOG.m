clc;
clear;
%function mhDemoMOG()
% Demo of Metropolis-Hastings algorithm for sampling from
% a mixture of two 1D Gaussians using a Gaussian proposal.
% Based on code originally written by Nando de Freitas.
weights = [0.3 0.7];
mus = [0 10];
sigmas = [2 2];
Nsamples = 5000;
x = zeros(Nsamples,1);
sigma_prop = 10; % Standard deviation of the Gaussian proposal.
targetArgs = {weights, mus, sigmas};
proposalArgs = {sigma_prop};
seed = 1; %randn('state', seed); rand('state', seed);
xinit = 20*rand(1,1); % initial state
[x, naccept] = MH(@target, @proposal, xinit, Nsamples, targetArgs, proposalArgs);

% plot the histogram of samples
N_bins = 50;

Ns = [100 500 1000 Nsamples];
figure;
for i=1:4
    subplot(2,2,i)
    x_t = linspace(-10,20,1000);
    y_t = feval(@target, x_t, weights, mus, sigmas);
    [b,a] = hist(x(1:Ns(i)), N_bins);
    measure = a(2)-a(1); % bin width.
    area = sum(b*measure);
    bar(a,b/(area),'y')
    %plot(x_t,y_t,'k','linewidth',100, 'color', 'r')
    %axis([-10 20 0 .15])
    text(14,.1,sprintf('N=%d', Ns(i)))
end


clear;

% This program is to simulate the process of resampling, aka, given a set
% of particles with weights, resample from them.

% author: moxie
% date: 2014.6.26

wparticles = [.1, .3, .2, .4];% 4particles with weights
%swparticles = sort(wparticles, 'descend');% sort at first
%wparticles = swparticles;
lparticles = length(wparticles);% 4
nparticles = 1000;% resample numbers
particles = [];
freqs = [0,0,0,0];% to count num of new particles from the correspondent old ones
tic
for i = 1 : nparticles
    rnum = rand();
    weight_sum = 0;
    for j = 1:lparticles
        weight_sum = weight_sum + wparticles(j);
        if weight_sum >= rnum
            break;
        end
    end
    particles = [particles, j];
    freqs(j) = freqs(j) + 1;
end
toc
disp(freqs/nparticles);% display the approximation
hist(particles, lparticles);% display above in hist
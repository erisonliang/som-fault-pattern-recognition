% This script cumputes a bidimensional gaussian distribution and a parabolic one
% which are assumed to represent the probability of a fault to happen on the chip
% in the coordinates (x1, x2).
% After that, a map is created where random faults are simulated. The value
% 0 in the map means 'no fault' and 1 means 'fault', whereas -1 indicates
% the points out of the circular wafer.
% Then KDE with gaussian kernel is launched: the true probability function
% and the extimated one are compared and the mean quaratic error is
% computed. The process is iterated for different amounts of faults and
% sevreal times for every amount, in order to avoid outliers.
% Finally, a graph error vs fault number is plotted

clear all
close all
clc

% Initializing benchmark parameters
ray = 30;
maximimumFaultProbabilities = 0.1:0.01:1;
testsNumber = 5;
KDEpoints = 64;

for i = 1:length(maximimumFaultProbabilities)
    maximumFaultProbability = maximimumFaultProbabilities(i);
    for j = 1:testsNumber
        % GAUSSIAN DENSITY
        % Computing multivariate gaussian probability density function
        varX = 1;
        varY = 1;
        Z = GaussianDensity(ray, varX, varY);
        
        % Filling sqare matrix with simbolic values. Fault are deployed according to
        % the probability function.
        faultMap = fillSquareGrid(Z, 2*ray, maximumFaultProbability);
        faultMap = createCircularGrid(faultMap, ray, -1);
        faultNumber(j,1) = length(find(faultMap==1));
        
        % KDE
        % call the routine, which has been saved in the current directory
        [faultX, faultY] = find(faultMap==1); % find seach elements by columns
        [bandwidth,extimatedDensity,X,Y] = kde2d([faultY,faultX], KDEpoints);
        
        % BENCHMARK
        % Computing and saving the average square error, ie the difference
        % between the value of the extimeted function and the value of the real
        % one.
        mu = [ray, ray]; 
        sigma = [varX, 0; 0, varY];
        trueDensity = mvnpdf([X(:), Y(:)], mu, sigma);
        trueDensity = reshape(trueDensity, length(X), length(Y));
        errorMatrix = (trueDensity - extimatedDensity).^2;
        error(j,1) = sum(sum(errorMatrix))/numel(errorMatrix);
        
        % PARABOLIC DENSITY
        % Computing parabolic probability density function
        coefficient = 2/(pi*ray^4);
        Z = parabolicIntensity(ray, coefficient);
        
        % Filling sqare matrix with simbolic values. Fault are deployed according to
        % the probability function.
        faultMap = fillSquareGrid(Z, 2*ray, maximumFaultProbability);
        faultMap = createCircularGrid(faultMap, ray);
        faultNumber(j,2) = length(find(faultMap==1));
        
        % KDE
        % call the routine, which has been saved in the current directory
        [faultX, faultY] = find(faultMap==1); % find seach elements by columns
        [bandwidth,extimatedDensity,X,Y] = kde2d([faultY,faultX], KDEpoints);
        
        % BENCHMARK
        % Computing and saving the average square error, ie the difference
        % between the value of the extimeted function and the value of the real
        % one.
        trueDensity = coefficient.*(X.^2+Y.^2);
        errorMatrix = (trueDensity - extimatedDensity).^2;
        error(j,2) = sum(sum(errorMatrix))/numel(errorMatrix);
    end
    meanError(i,1) = mean(error(:,1));
    meanFaults(i,1) = mean(faultNumber(:,1));
    meanError(i,2) = mean(error(:,2));
    meanFaults(i,2) = mean(faultNumber(:,2));
    
end


GaussianCurve = fit(meanFaults(:,1), meanError(:,1), 'poly5', 'Normalize', 'on');
ParabolicCurve = fit(meanFaults(:,2), meanError(:,2), 'poly5', 'Normalize', 'on');

figure(1)
subplot(2,1,1)
hold on
scatter(meanFaults(:,1), meanError(:,1), 'x')
plot(GaussianCurve)
title(['GAUSSIAN DENSITY. Mean error vs fault number - ', num2str(length(maximimumFaultProbabilities)), ' different fault amounts'])
legend('Simulated data', '5th degree fitting')

subplot(2,1,2)
hold on
scatter(meanFaults(:,2), meanError(:,2), 'x')
plot(ParabolicCurve)
title(['PARABOLIC DENSITY. Mean error vs fault number - ', num2str(length(maximimumFaultProbabilities)), ' different fault amounts'])
legend('Simulated data', '5th degree fitting')

clear all
close all

% Load the corrected mean RT data and subject-specific information
load("control_group_corrected_data.mat")
subj_info = readtable('subjInfo.csv'); % Subject-specific factors (Age, IQ, Sleep Duration)

% for defining difference between subject reaction time for 20 distractors
% to 10 distractos I need Distractor Effect = Mean RT (20 distractors) - Mean RT 10 distractors

distractor_effect = mean_rt(:, 3) - mean_rt(:, 1);

% Add the distractor effect to the subject info table
subj_info.DistractorEffect = distractor_effect;

% Display the updated table
disp(subj_info);

%% I Use Pearson’s correlation to test the relationship between the distractor effect and each factor (age, IQ, sleep duration):
% Correlation with Age
[R_age, P_age] = corr(subj_info.DistractorEffect, subj_info.age);

% Correlation with IQ
[R_iq, P_iq] = corr(subj_info.DistractorEffect, subj_info.IQ);

% Correlation with Sleep Duration
[R_sleep, P_sleep] = corr(subj_info.DistractorEffect, subj_info.sleep);

%% I did multiple regression 
% I would like to know which factor is affected other factors and multiple
% regression quantify how each individual factor affects the distractor
% effect, while controlling for the influence of the other factors.

% Fit a linear regression model
mdl = fitlm(subj_info, 'DistractorEffect ~ age + IQ + sleep');

disp(mdl);

% Visualizations
figure;


% Scatter plot: Distractor Effect vs. Age
subplot(2, 2, 1);
scatter(subj_info.age, subj_info.DistractorEffect, 'filled');
hold on
plot(subj_info.age, predict(mdl, [subj_info.age, mean(subj_info.IQ)*ones(size(subj_info.age)), mean(subj_info.sleep)*ones(size(subj_info.age))]), '-');
text(min(subj_info.age), max(distractor_effect), ['r = ', num2str(R_age, '%.2f'), ', p = ', num2str(P_age, '%.4f')]);
%plot(subj_info.age, reg_line_age, 'r-', 'LineWidth', 2); % Regression line
hold off
xlabel('age');
ylabel('Distractor Effect (RT Difference)');
title('Age vs. Distractor Effect');
grid on;


% Scatter plot: Distractor Effect vs. IQ
subplot(2, 2, 2);
scatter(subj_info.IQ, subj_info.DistractorEffect, 'filled');
hold on
plot(subj_info.IQ, predict(mdl, [mean(subj_info.age)*ones(size(subj_info.IQ)), subj_info.IQ, mean(subj_info.sleep)*ones(size(subj_info.IQ))]), '-');
text(min(subj_info.IQ), max(distractor_effect), ['r = ', num2str(R_iq, '%.2f'), ', p = ', num2str(P_iq, '%.4f')]);
hold off
xlabel('IQ');
ylabel('Distractor Effect (RT Difference)');
title('IQ vs. Distractor Effect');
grid on;

% Scatter plot: Distractor Effect vs. Sleep Duration
subplot(2, 2, 3);
scatter(subj_info.sleep, subj_info.DistractorEffect, 'filled');
hold on
% Plot the regression line for Sleep Duration
plot(subj_info.sleep, predict(mdl, [mean(subj_info.age)*ones(size(subj_info.sleep)), mean(subj_info.IQ)*ones(size(subj_info.sleep)), subj_info.sleep]), '-');
text(min(subj_info.sleep), max(distractor_effect), ['r = ', num2str(R_sleep, '%.2f'), ', p = ', num2str(P_sleep, '%.4f')]);
hold off
xlabel('Sleep Duration (hours)');
ylabel('Distractor Effect (RT Difference)');
title('Sleep Duration vs. Distractor Effect');
grid on



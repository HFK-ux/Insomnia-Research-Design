clear all; 
close all

% Load datasets
load("control_group_corrected_data.mat"); 
load("Insomnia_group_corrected_data.mat"); 

% Get subject counts
num_control = size(mean_rt, 1);
num_insomnia = size(insomnia_mean_rt, 1);
total_subjects = num_control + num_insomnia;

% Define groups (1 = Control, 2 = Insomnia)
group_labels = [ones(num_control, 1); ones(num_insomnia, 1) * 2]; 

% Merge reaction time data while keeping structure
RT_Combined = [mean_rt; insomnia_mean_rt];

% Convert RT data from wide format (subjects × conditions) to long format
RT_Long = reshape(RT_Combined', [], 1);  % Column-wise reshaping

% Define ANOVA factors
% I learned (kron) fuction from AI it is peratty useful. For this resason I
% used it. It helps us repeating and expanding matrices or vectors in a
% structured way
group = kron(group_labels, ones(3, 1));  % Expanding groups across 3 levels
distractors = repmat((1:3)', total_subjects, 1);  % Sequential levels

% Perform 2×3 factorial ANOVA
[p, tbl, stats] = anovan(RT_Long, {group, distractors}, ...
                         'model', 'interaction', ...
                         'varnames', {'Group', 'Distractor_Level'}, ...
                         'display', 'on');

% Display results
disp(tbl);

%% Perform Post-hoc analysis

% I didn't do a post-hoc test because there is no significant group
% difference between insomnia and control groups (p = 0.347).
% However, there is a significant main effect of Distractor Level
% (p < 0.001), meaning RTs increase as the number of distractors increases
% (20 distractors > 15 distractors > 10 distractors). 
% Since the Group × Distractor Level interaction is not significant 
% (p = 0.6491), both groups show the same trend, meaning the increase in
% RT is not related to group differences.

% Because of the these reason that I mention above post-hoc tests are not
% necessary.
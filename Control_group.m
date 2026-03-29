clear all
close all

folder = "/Users/harunfurkankanik/Desktop/targetDetect/targetDetect_controls";

% Initialize arrays to hold data for all participants
num_subjects = 35;
distractor_conditions = [10, 15, 20];
num_conditions = length(distractor_conditions);

% Pre-allocate arrays for accuracy and mean RT for each subject and condition
mean_accuracy = zeros(num_subjects, num_conditions);
mean_rt = zeros(num_subjects, num_conditions);

for subj = 1:num_subjects
    %load each subjects data
    filename = sprintf("%s/SUB%02d.mat", folder, subj);
    data = load(filename);
  
    trials = data.Exp.trial; % Access the trial data
    
    % Initialize temporary storage for current subject
    correct_responses = cell(1, num_conditions); % RT and accuracy our dependent variables
    reaction_times = cell(1, num_conditions); 
    
    % Iterate through each trial
    for t = 1:length(trials)
        numDistractors = trials(t).numDistractors; % number of distractors our IV
        target = trials(t).target; % 1 if target present, 0 otherwise
        response = trials(t).response;
        RT = response.RT; % Reaction time
        button = response.button; % Button pressed (1 = present, 0 = absent)

        correct = (response.button == target); %this checks if the subject's response was correct
        
        % Store RT and correctness by distractor condition
        cond_idx = find(distractor_conditions == numDistractors); % Map distractor count to condition index
        correct_responses{cond_idx} = [correct_responses{cond_idx}, correct];
        reaction_times{cond_idx} = [reaction_times{cond_idx}, RT];
    end
    
    % Calculate mean accuracy and mean reaction time for each condition
    for cond = 1:num_conditions
        mean_accuracy(subj, cond) = mean(correct_responses{cond}); % Mean accuracy for this condition
        mean_rt(subj, cond) = mean(reaction_times{cond}(correct_responses{cond} == 1)); % Mean RT for correct responses
    end
end

save("control_group_corrected_data", "mean_accuracy", "mean_rt");

%% Repeted measure ANOVA 
% I need to do because in this experiment same participants are tested
% under all conditions (10, 15, 20 distractors). This means the data is
% not independent, as each participant contributes multiple measurements
% accuracy and RT across the conditions

load("control_group_corrected_data.mat");

% I flatten the reaction time (RT) and accuracy data into a single vector
% and create a grouping variable for distractor levels.

% Flatten the data for RT and Accuracy
reaction_times = reshape(mean_rt, [], 1); % Converts 35x3 to a single column vector
accuracy_scores = reshape(mean_accuracy, [], 1);

% Create a grouping variable for distractor levels
group_labels = [ones(size(mean_rt, 1), 1); ones(size(mean_rt, 1), 1) * 2; ones(size(mean_rt, 1), 1) * 3];

% I used anovan for repeated measures analysis

% repeated measure anova analysis for reaction  times
[P, table, STATS] = anovan(reaction_times, {group_labels}, 'model', 'full', 'varnames', {'Distractor_Level'});

% repeated measure anova analysis for accuracy
[P, table, STATS]= anovan(accuracy_scores, {group_labels}, 'model', 'full', 'varnames', {'Distractor_Level'});


% for multiple comparison I adjusted benferoni correction because
% comparison tree distractors across significant level. I arranged 95%.
alpha_corrected = 0.05 / 3;

% posthoc pairwise t-test comparison

% Pairwise t-tests for Reaction Times

% 10 - 15 Distractors
[H P CI STAT] = ttest(mean_rt(:, 1), mean_rt(:, 2), 'Alpha', alpha_corrected)

% 10 vs 20 Distractors
[H P CI STAT] = ttest(mean_rt(:, 1), mean_rt(:, 3), 'Alpha', alpha_corrected)

% 15 vs 20 Distractors
[H P CI STAT]= ttest(mean_rt(:, 2), mean_rt(:, 3), 'Alpha', alpha_corrected)

%% Plotting

figure;
bar(mean(mean_rt, 1), 'FaceColor', [0.2 0.6 0.8]);
hold on;
errorbar(mean(mean_rt, 1), std(mean_rt, [], 1) / sqrt(size(mean_rt, 1)), 'k.', 'LineWidth', 1.5);
xticklabels({'10', '15', '20'});
xlabel('Number of Distractors');
ylabel('Reaction Time (ms)');
title('Control group Reaction Times for Different Distractor Levels');
grid on;
hold off;

figure;
bar(mean(mean_accuracy, 1), 'FaceColor', [0.8 0.4 0.2]);
hold on;
errorbar(mean(mean_accuracy, 1), std(mean_accuracy, [], 1) / sqrt(size(mean_accuracy, 1)), 'k.', 'LineWidth', 1.5);
xticklabels({'10', '15', '20'});
xlabel('Number of Distractors');
ylabel('Accuracy (%)');
title('Accuracy Across Distractor Levels');
grid on;
hold off;
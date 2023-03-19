load('classnumber68.mat');
load('classnumber68.mat');

eeglab

for m=1:68 %
    %% load data
    % load .set data
    m
%   EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
% % EEG = pop_biosig(load([matfile_array(i).folder '\' matfile_array(i).name])); 
% %
%   a1='C:\Users\fantengwen\Desktop\remove_sharp_20200522\';
    a2='data_';
    a3=num2str(classnumber68(m,1));% class info
    a4='_';
    a5=num2str(classnumber68(m,2));% ID info
    a4='_';
    a6=char(classnumber68S1(m,1));% name info
%   a7='_raw.set';
    aa7='.set';
    a8=strcat(a2,a3,a4,a5,a4,a6);% data_class_number_name
%     a9=strcat(a8,a7);%data_class_number_name_raw.set
%     a9=strcat(a1,a2,a3,a4,a5,a4,a6,a7);%C:\Users\fantengwen\Desktop\remove_sharp_20200522\data_class_number_name.set
%     a33='_all_epoches_baseline'
%     a34=strcat(a8,a33,aa7);%data_class_number_name_all_epoches_baseline.set
%     a35='_ICAdone';
%     a36=strcat(a8,a33,a35,aa7);% data_class_number_name_all_epoches_baseline_ICAdone.set
 
    %% load channel interpolated data
    a37='_interpolate_done';
    a38=strcat(a8,a37,aa7);% data_class_number_name_interpolate_done.set        
    
    % load .set dataset
    EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
    EEG = pop_loadset('filename',a38,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step2_interpolate_20201205\\');
    % G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step2_interpolate_20201205
    EEG = eeg_checkset( EEG );
    
    %% re-reference
    EEG = pop_reref( EEG, []);
    EEG = eeg_checkset( EEG ); 
    
    a41='_reref';
    a42=strcat(a8,a41,aa7);% data_class_number_name_reref.set
    EEG = pop_saveset( EEG, 'filename',a42,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step3_reref_20201206\\');
    EEG = eeg_checkset( EEG );
        
%   %%%&&&&&&&&&&&&&&&&预处理完成&&&&&&&&&&&&&&&&&%%%%%%%%%
    
end
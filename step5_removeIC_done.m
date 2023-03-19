load('classnumberIC.mat');

eeglab
for m=1:68 %
    m
%   a1='C:\Users\fantengwen\Desktop\remove_sharp_20200522\';
    a2='data_';
    a3=num2str(classnumberIC{m,1});% class info
    a4='_';
    a5=num2str(classnumberIC{m,2});% ID info
    a4='_';
    a6=char(classnumberIC{m,3});% name info
    a7='_ICAdone.set';
    a8=strcat(a2,a3,a4,a5,a4,a6);% data_class_number_name
    a9=strcat(a8,a7);% data_class_number_name_ICAdone.set
%     a9=strcat(a1,a2,a3,a4,a5,a4,a6,a7);%C:\Users\fantengwen\Desktop\remove_sharp_20200522\data_class_number_name.set
    a10='_ICA_removed.set';
    a11=strcat(a8,a10);% data_class_number_name_ICA_removed.set
    
    a12=eval(classnumberIC{m,4});%%%%% remove ICA component
  
if isempty(a12)
    EEG = pop_loadset('filename',a9,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step4_ICA_done_20201206\\');
    EEG = pop_saveset( EEG, 'filename',a11,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step5_removeIC_done_20201207\\');
else
  
% load .set dataset
% EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_loadset('filename',a9,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step4_ICA_done_20201206\\');
EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, a12, 0);
EEG = eeg_checkset( EEG );

EEG = pop_saveset( EEG, 'filename',a11,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step5_removeIC_done_20201207\\');
EEG = eeg_checkset( EEG );
end
end
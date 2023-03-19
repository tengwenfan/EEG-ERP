% cd('C:\Users\fantengwen\Desktop\test_0622')
load('classnumber68.mat');
load('classnumber68S1.mat');

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
    a41='_reref';
    a42=strcat(a8,a41,aa7);%data_class_number_name_reref.set
  
   % load .set dataset

   EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
   EEG = pop_loadset('filename',a42,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step3_reref_20201206\\');
   EEG = eeg_checkset( EEG );

   event_type=unique([EEG.event(:).type]);
   n_event_type(m,1)=length(event_type);
   n_event_type(m,2)=max(event_type);

% EEG = eeg_checkset( EEG );
  EEG = pop_runica(EEG, 'extended',1,'interupt','on');
  EEG = eeg_checkset( EEG );

  a43='_ICAdone';
  a44=strcat(a8,a43,aa7);% data_class_number_name_ICAdone.set

  EEG = pop_saveset( EEG, 'filename',a44,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step4_ICA_done_20201206\\');
  EEG = eeg_checkset( EEG );

end
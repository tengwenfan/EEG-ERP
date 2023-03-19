% load('classnumber68.mat');
% load('classnumber68S1.mat');
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


% load .set dataset
  EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
  EEG = pop_loadset('filename',a9,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step4_ICA_done_20201206\\');
  EEG = eeg_checkset( EEG );
  
%% epoch

a30='_epoch_done';
a31=strcat(a8,a30);% data_class_number_name_epoch_done

EEG = pop_epoch( EEG, {  '1'  '2'  '31'  '32'  }, [-0.1         1], 'newname', a31, 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-100    100]);
EEG = eeg_checkset( EEG );

aa7='.set';
a32=strcat(a31,aa7);% data_class_number_name_epoch_done.set
EEG = pop_saveset( EEG, 'filename',a32,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step10_no_ICs_20201224\\step6_1_all_epochs_20201224\\');
% 
EEG = eeg_checkset( EEG );

end

clear all;clc;
load('classnumber77.mat');
load('classnumber77S1.mat');

for m=1:77
    m
    a2='data_';
    a3=num2str(classnumber77(m,1));% class info
    a4='_';
    a5=num2str(classnumber77(m,2));% ID info
    a4='_';
    a6=char(classnumber77S1(m,1));% name info
    
    a8=strcat(a2,a3,a4,a5,a4,a6);% data_class_number_name
    
    a30='_epoch_done';
    a31=strcat(a8,a30);% data_class_number_name_epoch_done
    aa7='.set';
    a32=strcat(a31,aa7);% data_class_number_name_epoch_done.set

   EEG = pop_loadset('filename',a32,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step10_no_ICs_20201224\\step6_1_all_epochs_20201224\\');

%% extract deviant stimuli and the standard stimuli just before it (remove other standard trials)

% mark_type=[EEG.event.type];% marker value
% epoch_number=[EEG.event.epoch];% the epoch that each marker corresponds with
% [Deviant_X,Deviant_Y]=find(mark_type==2);

clear mark_type
for j=1:length(EEG.epoch)
mark_type(j,1)=EEG.epoch(j).eventtype{1,1};%j*1:all markers at zaro timepoint, j is the epoch
end
[Deviant_X,Deviant_Y]=find(mark_type==2|mark_type==32);% find deviant stimuli.Deviant_X: epoch of deviant stimuli. Deviant_Y: all should be 1;
Deviant_X=Deviant_X';% transpose
Standard_X=Deviant_X-1;% standard epoches that just before the deviant stimuli
epoch_needed=horzcat(Deviant_X,Standard_X);

%Keep epoch_needed and remove other epoches
epoch_number=[1:1:length(EEG.epoch)];%1*epoch
epoch_delet=epoch_number;
epoch_delet(:,epoch_needed)=[];% the epoches that need to be removed

%% remove trials that will NOT be used
EEG = pop_rejepoch( EEG, epoch_delet,0); % remove epoches
aa30='_all_equal_epochs';
aa7='.set';
aa31=strcat(a8,aa30,aa7);% data_class_number_name_all_equal_epochs.set

EEG = pop_saveset( EEG, 'filename',aa31,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step10_no_ICs_20201224\\step6_2_equal_epochs_20201224\\');
EEG = eeg_checkset( EEG );

end


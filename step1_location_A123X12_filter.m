

%% Step 1: load raw data, channel location, remove unused channel and filter
%% 
% cd('C:\Users\fantengwen\Desktop\test_0622')
load('classnumber81.mat');
load('classnumber81S1.mat');

eeglab
%data: 
% consonant: standard£º1£»deviant£º2£»
% tone: standard£º31£»deviant£º32

for m=1:81 %
    %% load data
    %load .edf data
    m
%   EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
% % EEG = pop_biosig(load([matfile_array(i).folder '\' matfile_array(i).name])); 
% %
%   a1='C:\Users\fantengwen\Desktop\remove_sharp_20200522\';
    a2='data_';
    a3=num2str(classnumber81(m,1));% class info
    a4='_';
    a5=num2str(classnumber81(m,2));% ID info
    a4='_';
    a6=char(classnumber81S1(m,1));% name info
    a7='_raw.set';
    a8=strcat(a2,a3,a4,a5,a4,a6);%data_class_number_name
    a9=strcat(a8,a7);%data_class_number_name_raw.set
%   a9=strcat(a1,a2,a3,a4,a5,a4,a6,a7); %C:\Users\fantengwen\Desktop\remove_sharp_20200522\data_class_number_name.set


   
% load .set data
% EEG.etc.eeglabvers = '2019.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG.etc.eeglabvers = '14.1.2'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_loadset('filename',a9,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\kindergarten_MMN_2019_pre\\');% note that '.set' should be added in the filename string
% G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\kindergarten_MMN_2019_pre
EEG = eeg_checkset( EEG );


    
    %% channel locate£¬channel collection and save file
    for i = 1:numel(EEG.chanlocs)
   
  if EEG.chanlocs(i).labels(7) == ' '
       
      EEG.chanlocs(i).labels = EEG.chanlocs(i).labels(5:6);
    
  else
        EEG.chanlocs(i).labels = EEG.chanlocs(i).labels(5:7); 
  end
  end


    
    EEG=pop_chanedit(EEG, 'lookup','E:\\eeglab14_1_2b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp');
    EEG = eeg_checkset( EEG );

    aa7='.set';
    aa9=strcat(a8,aa7); %data_class_number_name.set
%   a33='_nonchanCMA1A2';
%   a34=strcat(a8,a33,aa7); %data_class_number_name_nonchanCMA1A2.set

    EEG = pop_saveset( EEG, 'filename',aa9,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step1_location_A123X12_filter_20201205\\');% note that '.set' should be added in the filename string
    EEG = eeg_checkset( EEG );% save file after channel location£¬filename: data_class_number_name.set
    
    %% remove useless electrode
    EEG = pop_select( EEG,'nochannel',{'CM' 'A1' 'X3' 'X2' 'X1' 'A2'});
    EEG = eeg_checkset( EEG );

    %% filter
    EEG = pop_eegfiltnew(EEG, [],0.3,3300,1,[],1);
    EEG = eeg_checkset( EEG );
    EEG = pop_eegfiltnew(EEG, [],30,132,0,[],1);
    EEG = eeg_checkset( EEG );

    EEG = pop_saveset( EEG, 'savemode','resave');
    EEG = eeg_checkset( EEG );

end


%% Step2: manually interpolate bad channels



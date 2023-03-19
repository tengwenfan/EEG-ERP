clear all;clc;
load('classnumber78.mat');
load('classnumber78S1.mat');
%% 
for m=1:78
    m
    a2='data_';
    a3=num2str(classnumber78(m,1));% class info
    a4='_';
    a5=num2str(classnumber78(m,2));% ID info
    a4='_';
    a6=char(classnumber78S1(m,1));% name info
    aa7='.set';
    a8=strcat(a2,a3,a4,a5,a4,a6);% data_class_number_name
    
    a30='_epoch_done';
    a31=strcat(a8,a30);% data_class_number_name_epoch_done
    a32=strcat(a31,aa7);% data_class_number_name_epoch_done.set
    
    aa30='_all_equal_epochs';
    aa31=strcat(a8,aa30,aa7);% data_class_number_name_all_equal_epochs.set
    
    a33='_epochs100_done.set';
    a34=strcat(a8,a33);% data_class_number_name_epochs100_done.set

   EEG = pop_loadset('filename',aa31,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step10_no_ICs_20201224\\step6_2_equal_epochs_20201224\\');
   % 
   epochs_comp(m,1)=length(EEG.epoch);
   EEG = pop_autorej(EEG, 'nogui','on','threshold',100,'maxrej',30);
   EEG = eeg_checkset( EEG );
   EEG = pop_saveset( EEG, 'filename',a34,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step10_no_ICs_20201224\\step7_bad_epochs_20201224\\');
   % 
   epochs_comp(m,2)=length(EEG.epoch);
end

clear all;clc;
load('classnumber78.mat');
load('classnumber78S1.mat');
for m=1:78
    m
    a2='data_';
    a3=num2str(classnumber78(m,1));% class info
    a4='_';
    a5=num2str(classnumber78(m,2));% ID info
    a4='_';
    a6=char(classnumber78S1(m,1));% name info
    aa7='.set';
    a8=strcat(a2,a3,a4,a5,a4,a6);% data_class_number_name
    
    a30='_epoch_done';
    a31=strcat(a8,a30);% data_class_number_name_epoch_done
    a32=strcat(a31,aa7);% data_class_number_name_epoch_done.set
    
    aa30='_all_equal_epochs';
    aa31=strcat(a8,aa30,aa7);% data_class_number_name_all_equal_epochs.set
    
    a33='_epochs100_done.set';
    a34=strcat(a8,a33);% data_class_number_name_epochs100_done.set
    

   EEG = pop_loadset('filename',aa31,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step10_no_ICs_20201224\\step6_2_equal_epochs_20201224\\');
   epochs_comp_strict(m,1)=length(EEG.epoch);
   EEG = pop_autorej(EEG, 'nogui','on','threshold',100,'maxrej',100);
   EEG = eeg_checkset( EEG );
   EEG = pop_saveset( EEG, 'filename',a34,'filepath','G:\\Kindergarten_MMN_2019_processing_all_detailed\\Kindergarten_MMN_202012_final_processing\\step10_no_ICs_20201224\\step7_bad_epochs_20201224\\strict_20201224\\');
   % 
   epochs_comp_strict(m,2)=length(EEG.epoch);
end
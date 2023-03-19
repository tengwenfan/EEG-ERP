%%  consonant£¡

rawdata=dir('D:\Kindergarten_MMN_202012_final_processing\step14_simple_20201226\consonant_20201226\step7_bad_epochs_20201224\strict_20201224\*.set')
Cond={ '1'  '2' }; %% condition name: 1 std_consonant; 2 dev_consonant; 31 std_tone; 32 dev_tone 
for i=1:length(rawdata)
    EEG= pop_loadset(strcat('D:\Kindergarten_MMN_202012_final_processing\step14_simple_20201226\consonant_20201226\step7_bad_epochs_20201224\strict_20201224\', rawdata(i,1).name));  %% load the data into EEG
    EEG= eeg_checkset( EEG );
    for j=1:length(Cond)
        EEG_new = pop_epoch( EEG, Cond(j), [0  1]); %% epoch by conditions, input to EEG_new
        EEG_new = eeg_checkset( EEG_new );
        EEG_new = pop_rmbase( EEG_new, [0    100]); %% baseline correction for EEG_new
        EEG_new = eeg_checkset( EEG_new );
        %% EEG_new.data£ºchannel*timepoint*epoch
        EEG_avg_consonant_base100(i,j,:,:)=squeeze(mean(EEG_new.data,3));  %% average across trials for EEG_new, EEG_avg dimension: subj*cond*channel*time
    end 
end

channel=[4]; %% channel to display, Fz,4; Cz,8; C3,2; C4,6
mean_data(:,1)=squeeze(mean(mean(EEG_avg_consonant_base100(:,1,channel,:),1),3)); %% std_consonant
mean_data(:,2)=squeeze(mean(mean(EEG_avg_consonant_base100(:,2,channel,:),1),3)); % dev_consonant

EEG_times_copy=EEG_new.times-100;
figure; 
plot(EEG_times_copy, mean_data(:,1),'linewidth', 1.5,'Color','r'); %% plot waveforms for different conditions
hold on;
plot(EEG_times_copy, mean_data(:,2),'linewidth', 1.5,'Color','b');

mean_data2=squeeze(mean(mean(EEG_avg_consonant_base100(:,:,channel,:),1),3)); %% select data at Cz, and average across subjects, mean_data: cond*times
consonant_MMN=squeeze(mean_data2(2,:)-mean_data2(1,:)) %% consonantvMMN

hold on;
plot(EEG_times_copy, consonant_MMN,'linewidth', 1.5,'Color','k');

% Limit the display range of the horizontal and vertical axes
axis([-100 700 -5 5]);  %% define the region to display
set(gca,'YDir','reverse','XAxisLocation','origin','YAxisLocation','origin','xtick',[-100:100:700],'ytick',[-5:1:4],'fontname','Times New Roman','fontsize',10);
set (gcf,'Position',[300,300,700,600], 'color','w') 
% size. % horizontal distance to the left of the screen£¬vertical distance to the bottom of the screen£¬width of figure£¬height of figure
% the first two value determine the bottomleft corner of the figure 
% set(gca,'xtick',xtick,'xticklabel',xticklabel)  
box off;

title('consonant MMN ','fontname','Times New Roman','fontsize',12); %% specify the figure name
xlabel('Latency (ms)','fontname','Times New Roman','fontsize',10); %% name of X axis
ylabel('Amplitude (uV)','fontname','Times New Roman','fontsize',10);  %% name of Y axis

%% 
%% topographic map
mean_data3=squeeze(mean(EEG_avg_consonant_base100(:,:,:,:),1)); %% select data at Cz, and average across subjects, mean_data: cond*chan*times
consonant_MMN_topo=squeeze(mean_data3(2,:,:)-mean_data3(1,:,:)) %% chan*time

time_interval=[100:200:300]; %% specify the time intervals to display (to be changed)
figure;
for i=1 %:length(time_interval)
    latency_range=[time_interval(i) time_interval(i)+200]; %% lower and upper limits
    latency_idx=find((EEG_times_copy>=latency_range(1))&(EEG_times_copy<=latency_range(2)));
    Amplitude=squeeze(mean(consonant_MMN_topo(:,latency_idx),2)); 

    %subplot(1,2,1); 
    %plot topographic map
    topoplot(Amplitude,EEG.chanlocs,'maplimits',[-3 4], 'numcontour',0); %% topoplot(Amplitude,EEG.chanlocs)
    % colorbar();% scale
    setname=strcat(num2str(latency_range(1)),'--',num2str(latency_range(2)),'ms'); %% specify the name of subplots
    % title(setname,'fontsize',16); %% display the names of subplots
end
% colormap(redbluecmap)

%3
% the best color so far
r = [0.2627 0.5765 0.7647];       %# start
w = [0.9686 0.9686 0.9686];    %# middle
b = [0.8392 0.3765 0.3020];       %# end

%# colormap of size 64-by-3, ranging from red -> white -> blue
c1 = zeros(32,3); c2 = zeros(32,3);
for i=1:3
    c1(:,i) = linspace(r(i), w(i), 32);
    c2(:,i) = linspace(w(i), b(i), 32);
end
c = [c1(1:end-1,:);c2];

colormap(c),colorbar("FontSize",15, "FontWeight","bold")


% LDN 300-600
time_interval=[300:300:600]; %% specify the time intervals to display (to be changed)
 figure;
for i=1
    latency_range=[time_interval(i) time_interval(i)+300]; %% lower and upper limits
    latency_idx=find((EEG_times_copy>=latency_range(1))&(EEG_times_copy<=latency_range(2)));
    Amplitude=squeeze(mean(consonant_MMN_topo(:,latency_idx),2)); 

    %subplot(1,2,2); 
    %topographic map
    topoplot(Amplitude,EEG.chanlocs,'maplimits',[-3 4],'numcontour',0); %% topoplot(Amplitude,EEG.chanlocs)
    % colorbar();% scale
    setname=strcat(num2str(latency_range(1)),'--',num2str(latency_range(2)),'ms'); %% specify the name of subplots
    % title(setname,'fontsize',16); %% display the names of subplots
end


%
r = [0.2627 0.5765 0.7647];       %# start
w = [0.9686 0.9686 0.9686];    %# middle
b = [0.8392 0.3765 0.3020];       %# end

%# colormap of size 64-by-3, ranging from red -> white -> blue
c1 = zeros(32,3); c2 = zeros(32,3);
for i=1:3
    c1(:,i) = linspace(r(i), w(i), 32);
    c2(:,i) = linspace(w(i), b(i), 32);
end
c = [c1(1:end-1,:);c2];

colormap(c)%,colorbar


%% %% amplitude of each subject:  amplitude of Fz within time window between 250-350ms
  MMN_consonant_peaks_interval=find((EEG_times_copy>=250)&(EEG_times_copy<=350));
  amplitude_around_MMNpeak=consonant_MMN(1,MMN_consonant_peaks_interval);% amplitude
   times_around_MMNpeak=EEG_times_copy(1,MMN_consonant_peaks_interval); % timepoint
   
MMN_consonant_peak=min(amplitude_around_MMNpeak);% peak amplitude

MMN_consonant_peak_time_posi=find(amplitude_around_MMNpeak==MMN_consonant_peak);% postion of peak amplitude
MMN_consonant_peak_time=times_around_MMNpeak(1,MMN_consonant_peak_time_posi);% time of peak amplitude

%time window: ¡À20ms£ºMMN_peak_time¡À20
MMN_consonant_time_up=MMN_consonant_peak_time+20;
MMN_consonant_time_low=MMN_consonant_peak_time-20;
MMN_consonant_interval=find((EEG_times_copy>=MMN_consonant_time_low)&(EEG_times_copy<=MMN_consonant_time_up));


diffwave=squeeze(EEG_avg_consonant_base100(:,2,:,:)-EEG_avg_consonant_base100(:,1,:,:));% subject*channel*timepoint
%Final MMN amplitude£¡£¡£¡£¡£¡£¡£¡£¡£¡£¡£¡£¡£¡£¡£¡
% MMN_consonant_measures: average channel£¬average timepoint within time window
 MMN_consonant_measures= squeeze(mean(mean(diffwave(:,channel,MMN_consonant_interval),2),3)); % 250-350ms
 
 %% peak Fz
 MMN_consonant_peak_time_position=find(EEG_times_copy==MMN_consonant_peak_time);% position index of peak timwpoint
 MMN_consonant_peak_measures= squeeze(mean(diffwave(:,channel,MMN_consonant_peak_time_position),2));% peak amplitude
 
 
 %% 100-300ms
 diffwave=squeeze(EEG_avg_consonant_base100(:,2,:,:)-EEG_avg_consonant_base100(:,1,:,:));% subject*channel*timepoint

 MMN_consonant_peaks_interval=find((EEG_times_copy>=100)&(EEG_times_copy<=300));% position index
 
 MMN_consonant_measures_100300=squeeze(mean(mean(diffwave(:,channel,MMN_consonant_peaks_interval),2),3)); % amplitude

 %% 300-600ms
 diffwave=squeeze(EEG_avg_consonant_base100(:,2,:,:)-EEG_avg_consonant_base100(:,1,:,:));% subject*channel*timepoint

 MMN_consonant_peaks_interval=find((EEG_times_copy>=300)&(EEG_times_copy<=600));% position index
 
 MMN_consonant_measures_300600=squeeze(mean(mean(diffwave(:,channel,MMN_consonant_peaks_interval),2),3)); % amplitude

%% statistical analysis
 diffwave=squeeze(EEG_avg_consonant_base100(:,2,:,:)-EEG_avg_consonant_base100(:,1,:,:));% subject*channel*timepoint 
 MMN_consonant_measures_all=squeeze(mean(diffwave(:,channel,:),2)); %76*300
MMN_consonant_measures_all = MMN_consonant_measures_all(:, 1:241);% 700 ms; 76*241

 for i = 1:length(MMN_consonant_measures_all)
[R1,P1] = corr(MMN_consonant_measures_all(:,i), consonantPA(:,4));
coefMMNSD(1,i) = R1;
coefMMNSD(2,i) = P1;
[R2,P2] = corr(MMN_consonant_measures_all(:,i), consonantPA(:,5));
coefMMNPD(1,i) =R2;
coefMMNPD(2,i) =P2;
 end


% MMNID:14, 19, 43, 68,70: no CR
MMN_consonant_measures_all([14,19,43,68,70],:) = [];
for i = 1:length(MMN_consonant_measures_all)
[R3,P3] = corr(MMN_consonant_measures_all(:,i), consonantCR(:,4));
coefMMNCR(1,i) = R3;
coefMMNCR(2,i) = P3;
 end

figure; 
% subplot(311);
% plot(EEG_times_copy(1:241),coefMMNSD(1,:), 'r', EEG_times_copy(1:241),coefMMNSD(2,:), 'b'); 
% subplot(312);
% plot(EEG_times_copy(1:241),coefMMNPD(1,:), 'r', EEG_times_copy(1:241),coefMMNPD(2,:), 'b'); 
% subplot(313);
% plot(EEG_times_copy(1:241),coefMMNCR(1,:), 'r', EEG_times_copy(1:241),coefMMNCR(2,:), 'b'); 

figure;
subplot(211);
plot(EEG_times_copy(1:241),coefMMNSD(1,:)), axis([-100 600 -1 1]); 
subplot(212);
plot(EEG_times_copy(1:241),coefMMNSD(2,:)), axis([-100 600 0 0.1]); 

figure;
subplot(211);
plot(EEG_times_copy(1:241),coefMMNPD(1,:)); axis([-100 600 -1 1]); 
subplot(212);
plot(EEG_times_copy(1:241),coefMMNPD(2,:)); axis([-100 600 0 0.1]); 

figure;
subplot(211);
plot(EEG_times_copy(1:241),coefMMNCR(1,:)); axis([-100 600 -1 1]);
subplot(212);
plot(EEG_times_copy(1:241),coefMMNCR(2,:)); axis([-100 600 0 0.1]);



%%%% ----------------------

 latency_idx_100300=find((EEG_times_copy>=100)&(EEG_times_copy<=300));
 Amplitude_100300=squeeze(mean(consonant_MMN_topo(:,latency_idx_100300),2)); 


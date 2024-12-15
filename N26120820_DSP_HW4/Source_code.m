[clean_signal, fs] = audioread('singing16k16bit-clean.wav');
[noisy_signal, ~] = audioread('singingWithPhoneRing16k16bit-noisy.wav');

figure;
subplot(2,1,1);
spectrogram(clean_signal, 256, 128, 256, fs, 'yaxis');
title('Clean Signal Spectrogram');
colorbar;

subplot(2,1,2);
spectrogram(noisy_signal, 256, 128, 256, fs, 'yaxis');
title('Noisy Signal Spectrogram');
colorbar;

fs = 16000;                
filter_order = 1200;       
attenuation = 60;         

if attenuation > 50
    beta = 0.1102 * (attenuation - 8.7);
elseif attenuation >= 21
    beta = 0.5842 * (attenuation - 21)^0.4 + 0.07886 * (attenuation - 21);
else
    beta = 0;
end

notch1 = [1200 1300];   
notch2 = [1550 1650];   
notch3 = [2000 3400];  
notch4 = [4000 7900];   

b1 = fir1(filter_order, notch1/(fs/2), 'stop', kaiser(filter_order+1, beta));
b2 = fir1(filter_order, notch2/(fs/2), 'stop', kaiser(filter_order+1, beta));
b3 = fir1(filter_order, notch3/(fs/2), 'stop', kaiser(filter_order+1, beta));
b4 = fir1(filter_order, notch4/(fs/2), 'stop', kaiser(filter_order+1, beta));


filtered_signal_step1 = filtfilt(b1, 1, noisy_signal);
filtered_signal_step2 = filtfilt(b2, 1, filtered_signal_step1);
filtered_signal_step3 = filtfilt(b3, 1, filtered_signal_step2);
filtered_signal = filtfilt(b4, 1, filtered_signal_step3);

figure;
subplot(2,1,1);
spectrogram(noisy_signal, 256, 128, 1024, fs, 'yaxis');
title('Original Noisy Signal Spectrogram');

subplot(2,1,2);
spectrogram(filtered_signal, 256, 128, 1024, fs, 'yaxis');
title('Denoised siganl spectrogram');

filtered_signal = filtered_signal / max(abs(filtered_signal));
audiowrite('denoised.wav', filtered_signal, fs);










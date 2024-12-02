[originalAudio, fs] = audioread('singing16k16bit-clean.wav'); 

semitonesUp = 6;  
semitonesDown = -6; 

higherPitchAudio = shiftPitch(originalAudio, semitonesUp); 
lowerPitchAudio = shiftPitch(originalAudio, semitonesDown); 

audiowrite('higher_pitch_audio.wav', higherPitchAudio, fs);
audiowrite('lower_pitch_audio.wav', lowerPitchAudio, fs);

figure;
subplot(3,1,1);
spectrogram(originalAudio, 256, [], [], fs, 'yaxis');
title('original');

subplot(3,1,2);
spectrogram(higherPitchAudio, 256, [], [], fs, 'yaxis');
title('higher pitch');

subplot(3,1,3);
spectrogram(lowerPitchAudio, 256, [], [], fs, 'yaxis');
title('lower pitch');



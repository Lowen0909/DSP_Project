[audio,fs]=audioread('singing16k16bit-clean.wav');
disp(fs);
%upsampling
L=3;
upsample_audio=zeros(L*length(audio),1); 
upsample_audio(1:L:end)=audio; 
%frequency domain
N=length(upsample_audio);
freq_audio=fft(upsample_audio);
%ideal filter cutoff at min(pi/3,pi/4),gain=L
cutoff=round(N * 6000/48000); 
freq_audio(cutoff+1:N-cutoff) = 0;
freq_audio(1:cutoff)=freq_audio(1:cutoff)*L;
%time domain 
audio1=real(ifft(freq_audio));
%downsampling
M=4;
downsample_audio=audio1(1:M:end);
%play 12khz audio
sound(downsample_audio,12000); 
audiowrite('audio_12kHz.wav',downsample_audio,12000); 





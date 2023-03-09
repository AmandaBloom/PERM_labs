function [s, f, t] = labka2()
% Autor - Tomasz Pawlak, 304104
% Wywołanie
% [ff] = lab1()

[x, fs] = audioread('dtmf.wav'); % fs - freq próbkowania

win_len = 1024;              % wielkość okna do analizy
win_overlap = win_len/2;    % nakładanie ramek
nfft = win_len;                 % liczba próbek do FFT

% s - 
% t - indeksy czasowe - środki kolejnych okien do badania
[s, f, t] = spectrogram(x, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
spectrogram(x, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
end
function [ff] = lab3()
% Autor - Tomasz Pawlak, 304104
% Wywołanie
% [ff] = lab3()
% Cel
%   Obliczanie pulsu na podstawie filmu z kamery aparatu przyłożonej do
%   palca za pomocą metody autokorelacji sygnału, wcześniejsza obróbka
%   sygnału została wykonana za pomocą filtracji 15-elementowym filtrem
%   gaussowskim. 

% Liczba ramek do wczytania (przy 10 sekundach i 30 FPS będzie to 300)
N = 300;
Fs = 30;
t = 1:1:N;
v = VideoReader('output.mp4');

    for i=1:N
        % dla pliku wideo ładowanie ramki z otwartego źródła
        I = rgb2gray(read(v,i));
    
        % wyznaczamy średnią z całego obrazu
        sig(i) = mean(I, 'all');
    end

% dla ułatwienia późniejszej analizy od razu można odjąć od sygnału składową stałą
sig = sig - mean(sig);

% filtr gaussowski 15 elementowy
g15 = fspecial('gaussian', [1, 15], 3);
cg15_1 = conv(sig, g15, 'same');

twoplots(t, sig, cg15_1);

% autokorelacja sygnału
[r, lags] = xcorr(sig);
r = r(lags >= 0);
lags = lags(lags>=0);

clf;
plot(lags, r); % wyświetlenie krzywej autokorelowanego sygnału

% znalezienie maksymów lokalnych powyższej funkcji
[~, loc] = findpeaks(r, "MinPeakDistance", 10);

N_peak = 10;
% przesunięcie w sekundach
lag_s = (loc(N_peak)-1) / N_peak / Fs;

% częstotliwość bazowa
ff = 60/lag_s;

end

function twoplots(t, s1, s2)
    figure('Position', [10 10 1200 300]);
    subplot(121);
    plot(t, s1);
    subplot(122);
    plot(t, s2);
end
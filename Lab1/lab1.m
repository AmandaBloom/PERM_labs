function [ff] = lab1()
%
%   Autor:
%       Tomasz Pawlak, 304104
%   Zastosowanie:
%       Obliczanie pulsu na podstawie obrazu z kamery telefonu, do której
%       przyłożono palec. 
%   Wywołanie:
%      [ff] = lab1()
%   Wyjście:
%       ff - puls (liczony w BPM)
%

N = 300;    % Liczba ramek t_filmu[s]*bitrate[fps]
Fs= 30;     % Bitrate[fps]

br = zeros(1, N); % wektor jasności

% lista obrazów do analizy

%imds = imageDatastore('.', 'FileExtension', '.jpg');

% alternatywnie można załadować bezpośrednio plik wideo
v = VideoReader('output.mp4');


% wczytanie pierwszych N obrazów i analiza jasności
for i=1:N
    % wczytujemy obraz i przekształcamy go do skali szarości
    %I = rgb2gray(imread(imds.Files{i}));
    % dla pliku wideo ładowanie ramki z otwartego źródła
    I = rgb2gray(read(v,i));

    % wyznaczamy średnią z całego obrazu
    br(i) = mean(I, 'all');
end

% dla ułatwienia późniejszej analizy od razu można odjąć od sygnału składową stałą
br = br - mean(br);

Y = fft(br);     % transformata Fouriera

figure;
plot(br);       % Wykres Jasności
title("Wykres Jasności Sygnału");

A = abs(Y);     % amplituda sygnału
A = A/N;        % normalizacja amplitudy

A = A(1:N/2+1); % wycięcie istotnej części spektrum
A(2:end-1) = 2*A(2:end-1);

F = angle(Y);   % faza sygnału
F = F(1:N/2+1); % wycięcie istotnej części spektrum

f_step = Fs/N;     % zmiana częstotliwości
f = 0:f_step:Fs/2; % oś częstotliwości do wykresu

figure;
plot(f, A);        % wykres amplitudowy
title("Wykres Amplitudowy");
%figure;
%plot(f, F);        % wykres fazowy

[~, i] = maxk(A,1);% najwiekszy 1 element macierzy
ff = f(i);         % dominujaca czestotliwość

ff = ff*60;         % BeatsPerMin = frequency*60

end
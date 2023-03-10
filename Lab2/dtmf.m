function [out] = dtmf(x, fs)
% Autor - Tomasz Pawlak, 304104
% Wywołanie:
%   [out] = dtmf(x, fs)
% Gdzie pierw:
%   [x, fs] = audioread('dtmf.wav')
%
% Parametry wejściowe:
%   x  - wektor próbek audio
%   fs - częstotliwość próbkowania
%
% Parametry wyjściowe:
%   out - tablica wykrytych dźwięków nokii

% możliwe etykiety danych
labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"];

% możliwe wartości danych
valuesX = [697, 770, 852, 941];
valuesY = [1209, 1336, 1477];

% współczynniki ostrożności alfa - X, beta - Y, 
alfa = 0.045;
beta = 0.045;

% napis który będziemy wypisywać jako ciąg znaków
out = " ";

win_len = 500;              % wielkość okna do analizy
win_overlap = win_len/2;    % nakładanie ramek
nfft = win_len;             % liczba próbek do FFT


% wyznaczenie widma częstotliwości w oknach i wyznaczenie amplitudy funkcji składowych
% spectrogram(x, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
[s, f, ~] = spectrogram(x, win_len, win_overlap, nfft, fs, 'MinThreshold', -100);
A = abs(s) / nfft;

for i=1:size(A,2)
    % indexy freq o największej wartości Amplitudy
    % oraz indeksy które są maksymami lokalnymi funkcji A(f)
    [~, j_max] = maxk(A(:, i), 6);    
    [~, j_peak] = findpeaks(A(:, i));

    % indexy punktów które na pewno są szukanymi maksymami funkcji o
    % największych amplitudach - przecięcie zbiorów
    j = intersect(j_max, j_peak);

    % nie znajdujemy wymaganych częstotliwości - wypełniamy wektor
    % pierwszym indeksem, aby algorytm mógł przeczytać to jako szum i
    % zapisać jako "_" w wektorze wynikowym
    if size(j)==0 | size(j)==1
         j = [1; 1];
    end
    
    % obliczanie częstotliwości dzięki indeksom oraz sortowanie celem
    % wykrycia w algorytmie
    freq = [f(j(1)) f(j(2))];
    freq = sort(freq);

%     % Wykluczanie sytuacji kiedy peak'i częstotliwości są zbyt blisko
%     % siebie
%     if freq(2) - freq(1) < 50
%         disp("przypał")
%         disp(freq)
%     end

    % spełnienie warunku dla klawiszy 123
    if freq(1) >= (1-alfa)*valuesX(1) && freq(1) <= (1+alfa)*valuesX(1)

        if freq(2) >= (1-beta)*valuesY(1) && freq(2) <= (1+beta)*valuesY(1)
            new_label = labels(1);
        elseif freq(2) >= (1-beta)*valuesY(2) && freq(2) <= (1+beta)*valuesY(2)
            new_label = labels(2);
        elseif freq(2) >= (1-beta)*valuesY(3) && freq(2) <= (1+beta)*valuesY(3)
            new_label = labels(3);
        else
            new_label = "_";
        end
    % spełnienie warunku dla klawiszy 456
    elseif freq(1) >= (1-alfa)*valuesX(2) && freq(1) <= (1+alfa)*valuesX(2)

        if freq(2) >= (1-beta)*valuesY(1) && freq(2) <= (1+beta)*valuesY(1)
            new_label = labels(4);
        elseif freq(2) >= (1-beta)*valuesY(2) && freq(2) <= (1+beta)*valuesY(2)
            new_label = labels(5);
        elseif freq(2) >= (1-beta)*valuesY(3) && freq(2) <= (1+beta)*valuesY(3)
            new_label = labels(6);
        else
            new_label = "_";
        end
    % spełnienie warunku dla klawiszy 789
    elseif freq(1) >= (1-alfa)*valuesX(3) && freq(1) <= (1+alfa)*valuesX(3)

        if freq(2) >= (1-beta)*valuesY(1) && freq(2) <= (1+beta)*valuesY(1)
            new_label = labels(7);
        elseif freq(2) >= (1-beta)*valuesY(2) && freq(2) <= (1+beta)*valuesY(2)
            new_label = labels(8);
        elseif freq(2) >= (1-beta)*valuesY(3) && freq(2) <= (1+beta)*valuesY(3)
            new_label = labels(9);
        else
            new_label = "_";
        end
    % spełnienie warunku dla klawiszy *0#
    elseif freq(1) >= (1-alfa)*valuesX(4) && freq(1) <= (1+alfa)*valuesX(4)

        if freq(2) >= (1-beta)*valuesY(1) && freq(2) <= (1+beta)*valuesY(1)
            new_label = labels(10);
        elseif freq(2) >= (1-beta)*valuesY(2) && freq(2) <= (1+beta)*valuesY(2)
            new_label = labels(11);
        elseif freq(2) >= (1-beta)*valuesY(3) && freq(2) <= (1+beta)*valuesY(3)
            new_label = labels(12);
        else
            new_label = "_";
        end
    else % freq nierozpoznana
        new_label = "_";
    end
    % dopisanie wartosci w momencie nie powtarzania sie jej do wektora out
    if new_label ~= out(size(out))
        out = [out new_label];
    end
end
    % zamiana wektora stringów na stringa
    out = strrep(string(strjoin((out))), " ","");
end
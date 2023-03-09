function [out] = dtmf(x, fs)
% Autor - Tomasz Pawlak, 304104
% Wywołanie:
%   [out] = dtmf(x, fs)
% Gdzie pierw:
%   [x, fs] = audioread('dtmf.wav')

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
[s, f, t] = spectrogram(x, win_len, win_overlap, nfft, fs, 'MinThreshold', -100);
A = abs(s) / nfft;

for i=1:size(A,2)
    % dwa indexy freq o największej wartości Amplitudy
    [~, j] = maxk(A(:, i), 2);    
    freq = [f(j(1)) f(j(2))];
    sort(freq);

%     %inicjacja wektora częstotliwości kluczowych
%     freq = [];
%     % wybranie punktów podejrzanych o bycie maximum lokalnym
%     % j - index punktu podejrzanego
%     [~, j] = maxk(A(:, i), 6);
%     if i == 17
%     end
%     
%     for j_index=1:6
%         f(j(j_index))
%         if f(j(j_index)+1) < f(j(j_index)) && f(j(j_index)) > f(j(j_index)-1) && f(j(j_index)) > 697*(1-alfa)
%             % jeśli punkt jest max lokalnym dodajemy jego freq do tablicy
%             freq = [freq f(j(j_index))];
%         end
%     end
%     %sort(freq);
% 
%     if size(freq)==0 | size(freq)==1
%         freq = [0 0];
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
    % przypisanie wartosci w momencie nie powtarzania sie jej
    if new_label ~= out(size(out))
        out = [out new_label];
    end
end

    out = strrep(string(strjoin((out))), " ","");
    %out = strrep(out, " ", "");
    %out = string(strjoin(out));
end
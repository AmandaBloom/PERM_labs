function [output] = dtmf(x, fs)
% Autor - Tomasz Pawlak, 304104
% Wywołanie:
%   [out] = dtmf(x, fs)

% Parametry wejściowe:
%   x - wektor próbek audio
%   fs - częstotliwość próbkowania
%
% Parametry wyjściowe:
%   out - 

% możliwe etykiety danych
labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"];
valuesX = [697, 770, 852, 941];
valuesY = [1209, 1336, 1477];
alfa = 0.05;
output = [];

win_len = 1024;              % wielkość okna do analizy
win_overlap = win_len/2;    % nakładanie ramek
nfft = win_len;                 % liczba próbek do FFT

% wyznaczenie widma częstotliwości w oknach i wyznaczenie amplitudy funkcji składowych
% spectrogram(x, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');

[s, f, t] = spectrogram(x, win_len, win_overlap, nfft, fs);
A = abs(s) / nfft;
for i=1:size(A,2)
    [v, j] = maxk(A(:, i), 2);    
    freq = [f(j(1)) f(j(2))];
    if freq(1)>freq(2)
        sort(freq);
    end
    if freq(1) >= (1-alfa)*valuesX(1) & freq(1) <= (1+alfa)*valuesX(1)

        if freq(2) >= (1-alfa)*valuesY(1) & freq(2) <= (1+alfa)*valuesY(1)
            output = [output; labels(1)];
        elseif freq(2) >= (1-alfa)*valuesY(2) & freq(2) <= (1+alfa)*valuesY(2)
            output = [output; labels(2)];
        elseif freq(2) >= (1-alfa)*valuesY(3) & freq(2) <= (1+alfa)*valuesY(3)
            output = [output; labels(3)];
        end
    elseif freq(1) >= (1-alfa)*valuesX(2) & freq(1) <= (1+alfa)*valuesX(2)

        if freq(2) >= (1-alfa)*valuesY(1) & freq(2) <= (1+alfa)*valuesY(1)
            output = [output; labels(4)];
        elseif freq(2) >= (1-alfa)*valuesY(2) & freq(2) <= (1+alfa)*valuesY(2)
            output = [output; labels(5)];
        elseif freq(2) >= (1-alfa)*valuesY(3) & freq(2) <= (1+alfa)*valuesY(3)
            output = [output; labels(6)];
        end        
    elseif freq(1) >= (1-alfa)*valuesX(3) & freq(1) <= (1+alfa)*valuesX(3)

        if freq(2) >= (1-alfa)*valuesY(1) & freq(2) <= (1+alfa)*valuesY(1)
            output = [output; labels(7)];
        elseif freq(2) >= (1-alfa)*valuesY(2) & freq(2) <= (1+alfa)*valuesY(2)
            output = [output; labels(8)];
        elseif freq(2) >= (1-alfa)*valuesY(3) & freq(2) <= (1+alfa)*valuesY(3)
            output = [output; labels(9)];
        end          
    elseif freq(1) >= (1-alfa)*valuesX(4) & freq(1) <= (1+alfa)*valuesX(4)

        if freq(2) >= (1-alfa)*valuesY(1) & freq(2) <= (1+alfa)*valuesY(1)
            output = [output; labels(10)];
        elseif freq(2) >= (1-alfa)*valuesY(2) & freq(2) <= (1+alfa)*valuesY(2)
            output = [output; labels(11)];
        elseif freq(2) >= (1-alfa)*valuesY(3) & freq(2) <= (1+alfa)*valuesY(3)
            output = [output; labels(12)];
        end          
    else
        output = [output; " "];
    end
end

end
function out = dtmf(x, fs)

    % x - wektor próbek audio
    % fs - częstotliwość próbkowania
    [x, fs] = audioread("dtmf.wav");
    out = "";

    error = 0.06; % błąd dopuszczalny
    labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"];
    x_freq = [1209, 1336, 1477];
    y_freq = [697, 770, 852, 941];
    
    win_len = 500;            % wielkość okna do analizy
    win_overlap = win_len/2;  % nakładanie ramek
    nfft = win_len;           % liczba próbek do FFT

    % wyznaczenie widma częstotliwości w oknach i wyznaczenie amplitudy funkcji składowych
    [s, f, ~] = spectrogram(x, win_len, win_overlap, nfft, fs);
    A = abs(s) / nfft;

    for i=1:size(A, 2)
        N = 2;
        [~, j_max] = maxk(A(:, i), 6);    
        [~, j_peak] = findpeaks(A(:, i));

        % indexy punktów które na pewno są szukanymi maksymami funkcji o
        % największych amplitudach - przecięcie zbiorów
        j = intersect(j_max, j_peak);
        if size(j, 1)==0 || size(j, 1)==1
            j = [1; 1];
        end

        freq = [f(j(1)) f(j(2))];
        max_freq = sort(freq);
        disp(max_freq)
        freq = [];

        freq(1) = find_freq(y_freq, max_freq(1), error);
        freq(2) = find_freq(x_freq, max_freq(2), error);

        if freq(1)==0 || freq(2)==0
            new_label = "_";
        else
            idx = size(x_freq, 2) * (freq(1) - 1) + freq(2);
            new_label = labels(idx);
        end

        % dopisanie wartosci w momencie nie powtarzania sie jej do wektora out
        if new_label ~= out(size(out))
            out = [out new_label];
        end 
    end

    % zamiana wektora stringów na stringa
    out = strrep(string(strjoin((out))), " ","");
end

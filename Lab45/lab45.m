function lab45()
    [x, fs] = audioread('noised.wav');
    
    win_len = 512;   % wielkość okna do analizy
    win_overlap = win_len/2;    % nakładanie ramek
    nfft = win_len;                 % liczba próbek do FFT

    % aby zastosować filter górnoprzepustowy jako dolnoprzepustowy należy 
    % od sygnału bez filtra odjąć ten z górnoprzepustowym
    
    % zastosować dolnoprzepustowy do odcięcia 50Hz oraz dwa
    % środkowoprzepustowe do odcięcia 3 składowych budzika
  
    %spectrogram(x, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');

    % należy odciąć freq (<150 Hz , 1.95-2.15kHz , 4-4.2kHz , 6.05-6.25kHz

    F = lowpass_filter(1500, 100, fs); % odcięcie przy 1500Hz

    sf = conv(x, F);
    M = round(fs*4/100);
    %plot(F);
    %sf = (M/2+1:length(sf)-M/2+1)';
    %sf1 = ones(length(sf),1) - sf;
    
    spectrogram(sf, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
    
    %audiowrite('unnoised.wav', sig_filtered, fs);
end
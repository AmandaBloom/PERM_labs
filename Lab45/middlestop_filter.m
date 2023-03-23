function filter = middlestop_filter(fc0, fc1, bw, fs)
    if fc0>fc1
        filter = -1;
        return
    end
    high_filter = highpass_filter(fc1, bw, fs);
    low_filter = lowpass_filter(fc0, bw, fs);
    filter = low_filter + high_filter;  % suma filtrów
end
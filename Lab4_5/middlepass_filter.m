function filter = middlepass_filter(fc0, fc1, bw, fs)
    if fc0>fc1
        filter = -1;
        return
    end
    high_filter = highpass_filter(fc0, bw, fs);
    low_filter = lowpass_filter(fc1, bw, fs);
    filter = conv(low_filter,high_filter); % splot dwóch filtrów
end
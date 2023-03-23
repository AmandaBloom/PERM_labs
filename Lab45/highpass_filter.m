function filter = highpass_filter(fc, bw, fs)
    filter = lowpass_filter(fc, bw, fs);
    for i=1:1:size(filter,1)
        filter(i) = -1*filter(i);
    end
    filter((size(filter,1)+1)/2) = filter((size(filter,1)+1)/2) + 1;
    
end
function f_idx = find_freq(array, freq, error)

    for i=1:size(array, 2)
        down_bound = array(i) * (1 - error);
        up_bound = array(i) * (1 + error);
        if freq > down_bound && freq < up_bound
            f_idx = i;
            return;
        end
    end
    f_idx = 0;
    return;
end

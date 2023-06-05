function el = elevation(ENU, el_mask)

[m, n] = size(ENU);

el = [];

for num = 1:n
    R_E = ENU(num,1);
    R_N = ENU(num,2);
    R_U = ENU(num,3);

    el(num) = asind(R_U / sqrt(R_E^2 + R_N^2 + R_U^2));
end

n = length(el);

for num = 1:n
    if el(num) >= el_mask
        continue
    elseif el(num) < el_mask
        el(num) = NaN;
    end
end

end
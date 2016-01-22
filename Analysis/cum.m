function [ Cumulative ] = cum( input_args )
    Cumulative = zeros(1, length(input_args));
    sum = 0;
    for i=1:length(input_args)
        sum = sum + input_args(i);
        Cumulative(i) = sum;
    end
end


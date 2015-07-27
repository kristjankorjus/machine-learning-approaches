function [ labels ] = shuffle_within_partition( labels, partitions )
%SHUFFLE_WITHIN_PARTITION Summary of this function goes here
%   Detailed explanation goes here

for i_partition = unique(partitions)'
  temp = labels(partitions == i_partition);
  labels(partitions == i_partition) = temp(randperm(length(temp)));
end

end


function P = get_significance(method,ACC,ACC_PERM,alpha)

% method: how to calculate significance: 'classical', 'mid', 'prctile', 'prctile2', 'random'
% ACC: n_iter x 1 vector of accuracies
% ACC_PERM: n_iter x n_perm matrix of accuracies
% alpha: desired p-cutoff

[n_iter,n_perm] = size(ACC_PERM);

switch lower(method)
    
    case 'classical'
        
        % the p-value is the percentage of cases where the accuracy is the
        % same or exceeded by permutations
        P = sum(bsxfun(@ge,ACC_PERM,ACC),2)/n_perm;

    case 'mid'
        
        % the p-value is the percentage of cases where the accuracy is
        % exceeded by permutations, plus the percentage of half of the
        % permutations where the accuracy is the same as the permutations
        
        P = (sum(bsxfun(@gt,ACC_PERM,ACC),2) + 0.5*sum(bsxfun(@eq,ACC_PERM,ACC),2) ) / n_perm;
        
    case 'prctile2'
        
        % the p-value is the percentage of cases where the accuracy is
        % exceeded by permutations, plus the percentage of a fraction of
        % the permutations that is related to the point where the cutoff ==
        % acc bin. This is like random, but we will take all P_values that
        % are at the edge and will declare a certain percentage of them
        % significant which is based on the fraction. In other words, it
        % is like random, but exact.
        
        % if this result is significant already, no need to bother
        P = sum(bsxfun(@ge,ACC_PERM,ACC),2)/n_perm;
        
        ACC_PERM_sorted = sort(ACC_PERM,2);
        edge_true   = floor((1-alpha)*n_perm);
        CUTOFF = ACC_PERM_sorted(:,edge_true);
        prob = zeros(n_iter,1);
        cutoffind = find(ACC == CUTOFF);
        
        if ~isempty(cutoffind)
        
          for i_iter = 1:length(cutoffind)
              c_iter = cutoffind(i_iter);
              acc_perm_sorted = ACC_PERM_sorted(c_iter,:);
              cutoff = CUTOFF(c_iter);
              edge_lower  = find(acc_perm_sorted==cutoff,1,'first');
              edge_upper  = find(acc_perm_sorted==cutoff,1,'last');
              sum_lower  = edge_true-edge_lower;
              sum_upper  = edge_upper-edge_true;
              prob(c_iter)  = (sum_upper)/(sum_upper+sum_lower+1); % +1, because the edge needs to be included
          end

          total_prob = mean(prob(cutoffind)); % what is the proportion of those results that should be significant?
          P(cutoffind(1:floor(total_prob*length(cutoffind)))) = alpha - 0.01; % make that proportion significant

        end
        
    case 'random'

        % the p-value is the percentage of cases where the accuracy is
        % exceeded by permutations, plus the percentage of a fraction of
        % the permutations that is related to the point where the cutoff ==
        % acc bin 
        
        % if this result is significant already, no need to bother
        P = sum(bsxfun(@ge,ACC_PERM,ACC),2)/n_perm;
        
        ACC_PERM_sorted = sort(ACC_PERM,2);
        edge_true   = floor((1-alpha)*n_perm);
        CUTOFF = ACC_PERM_sorted(:,edge_true);
        prob = zeros(n_iter,1);
        cutoffind = find(ACC == CUTOFF);
        
        if ~isempty(cutoffind)
                
          for i_iter = 1:length(cutoffind)
              c_iter = cutoffind(i_iter);
              acc_perm_sorted = ACC_PERM_sorted(c_iter,:);
              cutoff = CUTOFF(c_iter);
              edge_lower  = find(acc_perm_sorted==cutoff,1,'first');
              edge_upper  = find(acc_perm_sorted==cutoff,1,'last');
              sum_lower  = edge_true-edge_lower;
              sum_upper  = edge_upper-edge_true;
              prob(c_iter)  = (sum_upper)/(sum_upper+sum_lower+1); % +1, because the edge needs to be included
          end

          issignificant = prob(cutoffind)>rand(size(cutoffind));
          P(cutoffind) = (alpha-0.01)*issignificant + P(cutoffind).*~issignificant;
        
        end
        
    otherwise
        error('unknown method %s.',method)
        
end
        
        
        
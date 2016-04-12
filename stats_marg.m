function [in_pmf]=stats_marg(in_image)
in_image=double(in_image);
%hist(in_image,-500:500);
pmf=hist(in_image,-500:500);
in_pmf=pmf/sum(pmf)+eps;
end


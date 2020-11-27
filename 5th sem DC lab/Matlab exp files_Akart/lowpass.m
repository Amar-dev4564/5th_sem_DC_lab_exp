function newdata = lowpass(data,samprate,cutoff,order)

% newdata = lowpass(data,samprate,cutoff,order)
%
% performs a lowpass filtering of the input data
% using an nth order zero phase lag butterworth filter
%
% given -> data (data)
%	-> samprate (Hz)
%	-> cutoff freq (Hz)
%	-> order of filter (optional: default 2nd order)
%
% returns -> filtered data

if nargin==3 order=2; end; % default to 2nd order

% get filter paramters A and B
[B,A] = butter(order,cutoff/(samprate/2));
% perform filtering
newdata = filtfilt(B,A,data);
function [tfilt,xfilt] = gaussfilt(traw,xraw,filtLength)
% DESCRIPTION: Gaussian Filter.  
%
% USAGE:  Provide the raw data (xraw), the desired filter length
% (flitLength), and the raw time (traw).  For example, to filter BGM3
% counts over a window 361 measurements long:
%  
%
%    [tfilt,xfilt] = gaussfilt(t,bgm3Counts,361)
%
%
%  The time values are not used by the filter or modified.  They are only
%  included for completeness.
%
%  The Guassian fliter parameters are computed in the function
%  calc_gauss_prms which is at the end of this file
%  
%       
% AUTHOR: James Kinsey jkinsey@whoi.edu
%
% COPYRIGHT(c): James C. Kinsey 2011


% MODIFICATION HISTORY
% 2011-10-12 JCK - added check to see if the number of raw data points is
% less than the desired filter window length
% 2015-01-23 JCK - added comments and cleaned up.

  plots = 0; 
  
%   if (nargin>3)
%     for (s=4:nargin)
%       if strcmp(varargin{s-3},'--plot')
%           plots=1; 
%       end % if strcmp(varargin{s},
%     end % for (s=4:nargin)
%   end % if (nargin>3)
    
  dataLength = length(xraw); 
  
  if (dataLength<filtLength)
    error('GAUSSFILT.M: Raw data is SHORTER than specified filter length; aborting');
  end % if (dataLength<filtLength)

  
  %compute the coefficients.  This fcn only returns the right hand side
  %of the gauss filter, hence the half name
  gauss_coeffs = calc_gauss_prms(filtLength); 
    
  if (plots==1)
    figure
    plot(gauss_coeffs,'x-')
  end % if (plots==1)
    
  %predefine the ring buffer memory
  filtLength = length(gauss_coeffs); 
  ringBuffer = zeros(1,filtLength);   
  
  m = 1; %counter for indexing the parsed data

  for (n=1:dataLength)
    newest = xraw(n); 
    ringBuffer = [ringBuffer(2:end) newest]; %left shift the ring buffer
    filtVec = ringBuffer.*gauss_coeffs; %multiply the ring buffer by the
                                        %gauss filer coefficients
    xfilt(m) = sum(filtVec);  %sum the filtered components to get the
                              %filtered value
    tfilt(m)  = traw(n); 
    m = m + 1; 
  end % for (n=(filtLength/2):(dataLength-(filtLength/2))

  if (plots==1)
    plot(traw,xraw,'.-')
    hold on 
    plot(tfilt,xfilt,'r-','linewidth',4)
  end % if (plots==1)
  
  return
   
   
   
function gauss_prms = calc_gauss_prms(sample_length)
% DESCRIPTION: Calculates the coefficients for the Gaussian filter used
% for ship gravity reductions
%
% USAGE:
%       
% AUTHOR: James Kinsey jkinsey@whoi.edu
%
% COPYRIGHT(c): James C. Kinsey 2009


% MODIFICATION HISTORY
% 2009-09-13 JCK - created and written
% 2015-01-22 JCK - added comments and documentation

  half_sample = floor(0.5*sample_length); 
  coeffLength = half_sample + 1; 
  
  frac = 6.0/sample_length;  %using the same value used in the NAVO and
                             %LDEO versions

  %compute the center and the right half of the filter coefficients 
  m = 1;
  for (n=coeffLength:-1:1)
    x = (half_sample - n) * frac; 
    x = -0.5*x^2; 
    gauss_prms(m) = exp(x); 
    m = m + 1; 
  end % for (n=half_sample:-1:0)

  %flip the right half to get all of the filter coefficients
  gauss_prms = [fliplr(gauss_prms(2:end)) gauss_prms(1) gauss_prms(2:end)]; 
  
  %normalize the gaussian filter prms to 1
  gauss_sum = sum(gauss_prms); 
  gauss_prms = gauss_prms./(gauss_sum); 
  
  return 
   

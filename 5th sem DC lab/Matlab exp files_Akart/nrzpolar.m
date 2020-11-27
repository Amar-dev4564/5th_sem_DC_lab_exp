function [y,t]=nrzpolar(x)
    t=0:0.0001:length(x);
    y=zeros(1,length(t));
    bitlength=floor(length(t)/length(x));
    j=1;
    for i=1:length(x)
        if(x(i)==1)
            y(j:j+bitlength-1)=1;
        else 
            y(j:j+bitlength-1)=-1;
        end
        j=j+bitlength;
    end
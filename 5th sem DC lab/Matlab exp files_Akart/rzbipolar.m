function [y,t]=rzbipolar(x)
index=0;
t=0:0.0001:length(x);
y=zeros(1,length(t));
bitlength=floor(length(t)/length(x));
j=1;
for i=1:length(x)
    if(x(i)==1)
        index=index+1;
        if (rem(index,2)==0)
            y(j:j+(bitlength/2)-1)=-1;
        else
            y(j:j+(bitlength/2)-1)=1;
        end
    else
       y(j:j+(bitlength/2)-1)=0;
    end
     j=j+bitlength;
end
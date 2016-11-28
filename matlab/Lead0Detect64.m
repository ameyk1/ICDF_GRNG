function [zero_pos]=Lead0Detect64(urng)
% --------------------------------------
% zero_pos : Leading zero position
% urng: Uniform rand Number
% --------------------------------------
zero_pos=0;
urng_temp = urng;
and_urng=uint64(4611686018427387904);
for i =drange(1:63)
    a= bitand(urng_temp,and_urng,'uint64');
    if(a)
          break;
    else
        zero_pos=zero_pos+1;
        urng_temp = bitshift(urng_temp,1,'uint64');
    end
end


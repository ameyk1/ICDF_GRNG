function [mask, masked_data]=mask20_15(zero_pos,urng_seg3)
% ---------------------------------------------------------
% zero_pos : Leading Zero in bits [63:3] obtained from output of LZD
% urng_seg3 : Obtained from Taussowrthe URNG bits 17:3
% mask : mask to zero 
%  masked_data : as name suggests
% ---------------------------------------------------------
%  For testing 
% zero_pos=13;urng_seg3=8;

switch zero_pos
    case 61 
        mask = 32767; %'111111111111111';
    case 60                    
        mask = 16383; %'011111111111111';
    case 59                    
        mask = 24575; %'101111111111111';
	case 58                    
        mask = 28671; %'110111111111111';
    case 57                    
        mask = 30719; %'111011111111111';
    case 56                    
        mask = 31743; %'111101111111111';
	case 55                    
        mask = 32255; %'111110111111111';
    case 54                    
        mask = 32511; %'111111011111111';
    case 53                    
        mask = 32639; %'111111101111111';
	case 52                    
        mask = 32703; %'111111110111111';
    case 51                    
        mask = 32735; %'111111111011111';
    case 50                    
        mask = 32751; %'111111111101111';
	case 49                    
        mask = 32759; %'111111111110111';
    case 48                    
        mask = 32763; %'111111111111011';
    case 47                    
        mask = 32765; %'111111111111101';
	case 46                    
        mask = 32766; %'111111111111110';
    otherwise                  
        mask = 32767; %'111111111111111';
end
% mask=[repmat('0', 1, 15 - length(mask)), mask]
% mask = logical(mask(:)'-'0')
shiftLSB2MSB= fliplr(dec2bin(urng_seg3));
% shiftLSB2MSB=[repmat('0', 1, 15 - length(shiftLSB2MSB)), shiftLSB2MSB]
% shiftLSB2MSB = logical(shiftLSB2MSB(:)'-'0')
shiftLSB2MSB = bin2dec(shiftLSB2MSB);
masked_data=bitand(mask,shiftLSB2MSB);
% masked_data=dec2bin(masked_data);
end

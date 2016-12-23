clear; clc;

[This_Week,Last_Week,Peaknow,Totalnow,Title,Artist,Entry_Date,Entry,Peak_All,Total_All,Chart_Date] = textread('us_billboard_csv.txt','%f%s%f%f%s%s%s%f%f%f%f%*[^\n]','delimiter',',');

l = length(This_Week);
% real-time Library Size
index = 1;

Library = cell(l,7);
for i = 1:30000
    Library{i,5} = 0;
    Library{i,6} = 0;
    Library{i,7} = 0;
end

for i = 1:l
    % [ret, pos] = search(Title{i,1},Library{:,1});
    ret = 1;
    pos = 0;
    for j = 1:index
        if(strcmp(Library{j,1},Title{i,1}))
            pos = j;
            ret = 0;
            break;
        end
    end
        
    % ?????????????
    if (ret == 1)
        Library{index,1} = Title{i,1};%Title
        Library{index,2} = Entry(i,1);%First Entry
        Library{index,3} = Peak_All(i,1);%All time peak
        Library{index,4} = Total_All(i,1);%All time length
        
        Library{index,5} = Library{index,5}+101-This_Week(i,1);%total area
        if (This_Week(i,1)<=20)
            Library{index,6} = Library{index,6}+1;
            Library{index,7} = Library{index,7}+21-This_Week(i,1);
        end
        index = index+1;
    else
        % can be found in library
        Library{pos,5} = Library{pos,5}+101-This_Week(i,1);%total area
        if (This_Week(i,1)<=20)
            Library{pos,6} = Library{pos,6}+1;
            Library{pos,7} = Library{pos,7}+21-This_Week(i,1);
        end
    end
    i
end


% function [ret, pos] = search(name, library)
% l = length(library);
% % If name can be found in the library, ret = 0
% ret = 1;
% pos = 0;
% for i = 1:l
%     if (library{i,1} == name)
%         pos = i;
%         ret = 0;
%     break;
%     end
% end
% end
    


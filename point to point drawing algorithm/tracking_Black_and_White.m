clc
clear

%(0->black & 255->white)
RGB=imread('azadi.jpg');
% [m,n,p]=size(G);
I = rgb2gray(RGB);

threshold = 150; % custom threshold value
I_bw = I > threshold;

% %*** threshold ***
% t = 70;
% % find values below
% ind_below = (I < t);
% % find values above
% ind_above = (I >= t);
% % set values below to black
% I(ind_below) = 255;
% % set values above to white
% I(ind_above) = 0;

% % ***test***
%imshow(I);
% imtool(I)
 imtool(I_bw)
 imwrite(I_bw,'azadi_two_hundred_px.jpg')



i=0;
m=0;

sz = size(I_bw);
n=sz(1,1);

T=zeros(n^2,3);


for k = -n+1:0
    A=diag(I_bw,k);
    i=i+1;
    j=i-1;
    for s=1:i
        m=m+1;
        if mod(i,2)==0
            T(m,1)=i-j;
            T(m,2)=j+1;
            T(m,3)=A(s);
            j=j-1;
        else
            T(m,1)=j+1;
            T(m,2)=i-j;
            T(m,3)=A(i-s+1);
            j=j-1;
        end
     end
end

if mod(i,2)==1
    for k = 1:n-1
        A=diag(I_bw,k);
        i=i-1;
        j=i+n;
     for s=1:i
        m=m+1;
        if mod(i,2)==1
            T(m,1)=j-i;
            T(m,2)=2*n+1-j;
            T(m,3)=A(i-s+1);
            j=j-1;
        else
            T(m,1)=2*n+1-j;
            T(m,2)=j-i;
            T(m,3)=A(s);
            j=j-1;
        end
     end
     end
else
     for k = 1:n-1
        A=diag(I_bw,k);
        i=i-1;
        j=i+n;
     for s=1:i
        m=m+1;
        if mod(i,2)==1
            T(m,1)=j-i;
            T(m,2)=2*n+1-j;
            T(m,3)=A(i-s+1);
            j=j-1;
        else
            T(m,1)=2*n+1-j;
            T(m,2)=j-i;
            T(m,3)=A(s);
            j=j-1;
        end
     end
     end
end



sz = size(T);
n=sz(1,1);

A=T(:,1);
B=T(:,2);

 T(:,1)=A/4+60;
 T(:,2)=B/4+15;


%T(:,1)=A+59;
%T(:,2)=B+29;

% txt="{";
% for j= 1:n
%     txt=txt+"{";
%     for i=1:3
%         txt=txt+T(j,i)+"";
%         if i==3
%             txt=txt+"}";
%         else
%             txt=txt+",";
%         end
%     end
%     if j==n
%         txt=txt+"}";
%     else
%        txt=txt+","; 
%     end 
% end
% 
% disp(txt)
% 
% fileID = fopen('points.txt','w');
% fprintf(fileID,txt);
% fclose(fileID);
% 
% % % test
% % for n=1:40000
% %      i=T(n,1);
% %      j=T(n,2);
% %      image(i,j)=T(n,3);
% %  end
% %  I= mat2gray(image);
% %  imtool(I)

fileID = fopen('azadi_two_hundred_px.txt','w');

txt="";
for j= 1:n
    for i=1:3
        txt=""+T(j,i);
        fprintf(fileID,txt);
        if i==3
            fprintf(fileID','%s\n',',');
        else
            fprintf(fileID,',');
        end
    end
end


fclose(fileID);




function [] = tracingPER(x,y,p_n,parts,I_perim)
fileID = fopen('Shahrdari800.txt','w');
i_p=800;
j_p=1;
for p=1:parts
    for i = x:-1:1
        for j = 1:p_n(p)
            %Contour Selecting
            if I_perim(j,i)==1
                contour = bwtraceboundary(I_perim,[j i],'E',8);
                if size(contour,1)>2
                    %adding white points
                    if j_p<j-1
                        for m = j_p+1:j-1
                            n=i_p;
                            print_text(n,m,y);
                        end
                        if i_p<i-1
                            for n = i_p+1:i-1
                                print_text(n,m,y);
                            end
                        elseif i_p>i+1
                            for n = i_p-1:-1:i+1
                                print_text(n,m,y);
                            end
                        end
                    elseif j_p>j+1
                        for m = j_p-1:-1:j+1
                            n=i_p;
                            print_text(n,m,y);
                        end
                        if i_p<i-1
                            for n = i_p+1:i-1
                                print_text(n,m,y);
                            end
                        elseif i_p>i+1
                            for n = i_p-1:-1:i+1
                                print_text(n,m,y);
                            end
                        end
                    elseif j_p==j ||  j_p==j+1 ||  j_p==j-1
                        m=j_p;
                        for n = i_p+1:i-1
                            print_text(n,m,y);
                        end
                    end
                    
                    %Contour Tracing
                    I_contour = zeros(size(I_perim));
                    for row=1:size(contour,1)
                        I_contour(contour(row,1),contour(row,2))=1;
                        hold on
                        plot(contour(row,2),contour(row,1),'r.')
                        pause(0.0000000000000000000000001)
                        txt=""+(contour(row,2))+","+(contour(row,1))+","+"0,";
                        fprintf(fileID,'%s\n',txt);
                        %imtool(~I_contour)
                    end
                    
                    %Remove traced contours
                    I_perim = I_perim - I_contour;
                    i_p=i;
                    j_p=j;
                end
            end
        end
    end
end
fclose(fileID);
end




function codebook = LBGTraining(inputs,Iterations,e,E,dim1,dim2,showFigures)
    if (showFigures)
        % Plot the dataset according to the 2 dimensions specified
        figure;
        hold on
        plot(inputs(dim1,:),inputs(dim2,:),'Marker','o','LineStyle','none')
    end
    % Find the initial centroid
    y(:,1)=mean(inputs,2);
    % Start iterating:
    while size(y,2)<2^(Iterations)
        % Split the centroid by the factor e, specified in the function
        % call, and store the result in a temporary variable so we don't
        % overwrite y by mistake
        for i=1:size(y,2)
            ty(:,2*i-1)=y(:,i)*(1+e);
            ty(:,2*i)=y(:,i)*(1-e);
        end
        % Now that we're done reading y, move our temporary variable back
        % into y
        y=ty;
        % Find all the distances between the input and the codewords y
        Distances=disteu(y,inputs);
        % Find the minimum distances, and the y they correspond to
        [MinDist,inputBin]=min(Distances,[],1);
        % Define the previous distortion as the sum of the minimum
        % distances
        PDistortion=sum(MinDist);
        % Recalculate the centroids of each group, using the inputBin
        % variable to discern which vector is closest to each y. Leave
        % unchanged any centroids which are close to no vectors.
        for i=1:size(y,2)
            if (sum(inputBin(inputBin==i))>0)
                y(:,i)=mean(inputs(:,inputBin==i),2);
            end
        end
        % Find the new distances, minimums, and distortion with the
        % centroid values
        Distances=disteu(y,inputs);
        [MinDist,inputBin]=min(Distances,[],1);
        Distortion=sum(MinDist);
        % Repeat the above, stopping when the change in distortion from one
        % step to the next is smaller than E, defined in the function call
        while (PDistortion-Distortion)/Distortion>E
            for i=1:size(y,2)
                if (sum(inputBin(inputBin==i))>0)
                    y(:,i)=mean(inputs(:,inputBin==i),2);
                end
            end
            Distances=disteu(y,inputs);
            [MinDist,inputBin]=min(Distances,[],1);
            PDistortion=Distortion;
            Distortion=sum(MinDist);
        end
    end
    % Return the results, and plot the codebook on the same chart as the
    % data
    codebook=y;
    if (showFigures)
        plot(y(1,:),y(2,:),'LineStyle','none','Marker','+')
        hold off
    end
end
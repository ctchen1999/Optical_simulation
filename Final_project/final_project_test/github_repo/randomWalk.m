function numEnclosedParticles = randomWalk(sizeX,sizeY,numParticles,numIterations,stepTime,circleRadius)

    points = ones(numParticles,1)*[ceil(sizeY/2),ceil(sizeX/2)];
    livePoints = points;

    circleCenter = [ceil(sizeY/2),ceil(sizeX/2)];
    numEnclosedParticles = zeros(numIterations,1);

    moveMat = round(rand(numParticles,1));
    moveMat = [moveMat double(not(moveMat))];
    randNeg = 3-2*round((rand(numParticles,2)+1));
    moveMat = moveMat.*randNeg;

    testMat = zeros(sizeY,sizeX);

    for it = 1:numIterations


        indices = sub2ind(size(testMat),livePoints(:,1),livePoints(:,2));
        testMat(indices) = 1;
        imagesc(testMat);
        title(strcat('Step#:',{' '},string(it)));

        offset = points - circleCenter;
        distances = sqrt(offset(:,1).^2+offset(:,2).^2);
        count = sum(double(distances<=circleRadius));
        numEnclosedParticles(it) = count;

        testMat(:) = 0;
        pause(stepTime);
        points = points+moveMat;
        livePoints = points;

        xMin = livePoints(:,2) > 0;
        xMin = double(xMin);
        xMin(xMin==0) = nan;
        yMin = livePoints(:,1) > 0;
        yMin = double(yMin);
        yMin(yMin==0) = nan;
        xMax = livePoints(:,2) <= sizeX;
        xMax = double(xMax);
        xMax(xMax==0) = nan;
        yMax = livePoints(:,1) <= sizeY;
        yMax = double(yMax);
        yMax(yMax==0) = nan;
        livePoints = livePoints.*[yMin xMin].*[yMax xMax];  
        livePoints(any(isnan(livePoints), 2), :) = [];

        moveMat = round(rand(numParticles,1));
        moveMat = [moveMat double(not(moveMat))];
        randNeg = 3-2*round((rand(numParticles,2)+1));
        moveMat = moveMat.*randNeg;
        
    end

end

